# Daily wallpaper description (Bing)

The noctalia `daily-wallpaper` plugin now keeps Bing's description of each daily image, and `Mod+Shift+W` shows it.

## What changed

- **`noctalia/.config/noctalia/plugins/daily-wallpaper/sources/BingSource.qml`**: keeps `title`, `copyright` (location and photographer), `copyrightlink` and `startdate` from Bing's `HPImageArchive` response. Previously only the image URL was kept.
- **`noctalia/.config/noctalia/plugins/daily-wallpaper/Main.qml`**:
  - New `writeMetadata` step saves the description as `downloads/bing-YYYY-MM-DD.json`, next to the `.jpg`. It runs on every check, including when the image is already downloaded.
  - If the write fails, the plugin logs a warning and still sets the wallpaper.
  - Cleanup deletes `.json` files older than 5 days along with their images.
- **`noctalia/.config/noctalia/plugins/daily-wallpaper/wallpaper-info.sh`** (new): asks noctalia which wallpaper is on the focused output and shows its sidecar as a notification. The notification has a "Learn more" action that opens Bing's search page for the place.
- **`niri/.config/niri/cfg/keybinds.kdl`**: `Mod+Shift+W` ("Wallpaper Info") runs `wallpaper-info.sh`.

## Sidecar format

```json
{
  "title": "Where history stands watch",
  "copyright": "Kunětická hora Castle, Bohemia, Czechia (© Marek Saroch/Alamy)",
  "link": "https://www.bing.com/search?q=...",
  "date": "20261028"
}
```

## Notes

- Restart noctalia after deploying so it loads the new plugin code.
- Wallpapers downloaded before this change have no sidecar, so the notification says "No description available".
- The NASA source doesn't save a description.
- To fetch today's description by hand:

  ```bash
  curl -s 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US' \
    | jq -r '.images[0] | "\(.title)\n\(.copyright)"'
  ```
