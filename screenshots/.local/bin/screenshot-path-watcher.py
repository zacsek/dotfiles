#!/usr/bin/env python3
import ctypes
import os
import struct
import subprocess
import sys
import threading
import time

SCREENSHOT_DIR = os.path.expanduser("~/Pictures/Screenshots")
os.makedirs(SCREENSHOT_DIR, exist_ok=True)

# Inotify constants - only listen to CLOSE_WRITE to avoid duplicate triggers
IN_CLOSE_WRITE = 0x00000008
EVENT_FMT = "iIII"
EVENT_SIZE = struct.calcsize(EVENT_FMT)

# Debounce tracking: filepath -> timestamp
last_processed = {}
lock = threading.Lock()

def process_screenshot(filepath):
    try:
        # 1. Send desktop notification once
        subprocess.run([
            "notify-send",
            "-a", "Screenshot",
            "-i", filepath,
            "Screenshot Path Copied",
            filepath
        ], check=False)

        # 2. Wait 350ms for Niri/compositor to finish writing raw image to clipboard/CopyQ
        time.sleep(0.35)

        # 3. Deduplicate and place filepath at row 0 in CopyQ
        escaped_path = filepath.replace('"', '\\"')
        copyq_script = f"""
        for (var i = 10; i >= 0; --i) {{
            if (str(read("text/plain", i)) === "{escaped_path}") {{
                remove(i);
            }}
        }}
        insert(0, "{escaped_path}");
        selectItems(0);
        select(0);
        """
        subprocess.run(["copyq", "eval", copyq_script], check=False)
        subprocess.run(["wl-copy", filepath], check=False)

        # 4. Verification pass: if compositor was slow and pushed an image after 350ms, fix it cleanly
        time.sleep(0.4)
        verify_script = f"""
        if (str(read("text/plain", 0)) !== "{escaped_path}") {{
            for (var i = 10; i >= 0; --i) {{
                if (str(read("text/plain", i)) === "{escaped_path}") {{
                    remove(i);
                }}
            }}
            insert(0, "{escaped_path}");
            selectItems(0);
            select(0);
        }}
        """
        subprocess.run(["copyq", "eval", verify_script], check=False)
        subprocess.run(["wl-copy", filepath], check=False)

    except Exception as e:
        print(f"Error processing screenshot: {e}", file=sys.stderr)

def on_screenshot_event(filepath):
    now = time.time()
    with lock:
        stale = [k for k, v in last_processed.items() if now - v > 10.0]
        for k in stale:
            del last_processed[k]

        if filepath in last_processed and (now - last_processed[filepath]) < 3.0:
            return
        last_processed[filepath] = now

    threading.Thread(target=process_screenshot, args=(filepath,), daemon=True).start()

def watch_inotify():
    libc = ctypes.CDLL("libc.so.6")
    fd = libc.inotify_init()
    if fd < 0:
        raise OSError("Failed to initialize inotify")

    wd = libc.inotify_add_watch(fd, SCREENSHOT_DIR.encode("utf-8"), IN_CLOSE_WRITE)
    if wd < 0:
        os.close(fd)
        raise OSError(f"Failed to watch directory: {SCREENSHOT_DIR}")

    try:
        while True:
            data = os.read(fd, 4096)
            if not data:
                break

            offset = 0
            while offset + EVENT_SIZE <= len(data):
                wd_ev, mask_ev, cookie, name_len = struct.unpack_from(EVENT_FMT, data, offset)
                name_bytes = data[offset + EVENT_SIZE : offset + EVENT_SIZE + name_len]
                filename = name_bytes.split(b"\x00", 1)[0].decode("utf-8", errors="ignore")
                offset += EVENT_SIZE + name_len

                if filename.endswith(".png"):
                    full_path = os.path.join(SCREENSHOT_DIR, filename)
                    on_screenshot_event(full_path)
    finally:
        os.close(fd)

def watch_fallback():
    last_file = None
    while True:
        try:
            files = [
                os.path.join(SCREENSHOT_DIR, f)
                for f in os.listdir(SCREENSHOT_DIR)
                if f.endswith(".png")
            ]
            if files:
                newest = max(files, key=os.path.getctime)
                if last_file is not None and newest != last_file:
                    on_screenshot_event(newest)
                last_file = newest
        except Exception:
            pass
        time.sleep(1)

def main():
    try:
        watch_inotify()
    except Exception as e:
        print(f"Inotify failed ({e}), falling back to polling.", file=sys.stderr)
        watch_fallback()

if __name__ == "__main__":
    main()
