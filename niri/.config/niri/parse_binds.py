import os
import re

def parse_kdl_binds(file_path):
    if not os.path.exists(file_path):
        return {}
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract the binds { ... } content
    match = re.search(r'\bbinds\s*\{', content)
    if not match:
        return {}
    
    start_pos = match.end()
    brace_count = 1
    binds_content = ""
    for i in range(start_pos, len(content)):
        char = content[i]
        if char == '{':
            brace_count += 1
        elif char == '}':
            brace_count -= 1
        if brace_count == 0:
            binds_content = content[start_pos:i]
            break
            
    lines = binds_content.splitlines()
    binds = {}
    current_comments = []
    
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if not line:
            i += 1
            continue
            
        # Parse comment
        if line.startswith("//") or line.startswith("#"):
            comment_text = re.sub(r'^(?://|#)\s*', '', line).strip()
            # Ignore divider lines
            if comment_text and not all(c in '─-─= ' for c in comment_text):
                comment_text = comment_text.strip(" ─-+=#*")
                if comment_text:
                    current_comments.append(comment_text)
            i += 1
            continue
            
        # Match bindings
        bind_match = re.match(r'^([^\s{]+)\s*(.*?)\s*\{', line)
        if bind_match:
            key_combo = bind_match.group(1)
            attrs_str = bind_match.group(2)
            
            # Now extract the action inside the braces
            brace_count = 1
            action_lines = []
            start_of_action = line.find('{') + 1
            curr_line_action = line[start_of_action:]
            
            for char in curr_line_action:
                if char == '{':
                    brace_count += 1
                elif char == '}':
                    brace_count -= 1
            
            if brace_count == 0:
                action_text = curr_line_action.rstrip('}').strip()
            else:
                action_lines.append(curr_line_action)
                i += 1
                while i < len(lines) and brace_count > 0:
                    next_line = lines[i]
                    for char in next_line:
                        if char == '{':
                            brace_count += 1
                        elif char == '}':
                            brace_count -= 1
                    action_lines.append(next_line)
                    i += 1
                
                action_text = "\n".join(action_lines).strip()
                if action_text.endswith('}'):
                    action_text = action_text[:-1].strip()
            
            action_text = action_text.rstrip(';').strip()
            action_text = re.sub(r'\s+', ' ', action_text)
            
            # Parse description
            description = ""
            title_match = re.search(r'hotkey-overlay-title="((?:[^"\\]|\\.)*)"', attrs_str)
            if title_match:
                description = title_match.group(1)
                # Unescape quotes and tabs
                description = description.replace('\\"', '"').replace('\\t', ' ')
                # Remove pango / html tags
                description = re.sub(r'<[^>]+>', '', description)
                description = re.sub(r'\s+', ' ', description).strip()
            elif 'hotkey-overlay-title=null' in attrs_str:
                description = ""
            else:
                description = " | ".join(current_comments) if current_comments else ""
                
            # Strip decorator characters from description
            description = description.strip(" ─-+=#*")
            
            if not description:
                description = action_text
                
            binds[key_combo] = {
                'action': action_text,
                'description': description
            }
            current_comments = []
            if brace_count == 0:
                i += 1
        else:
            i += 1
            
    return binds

def main():
    paths = [
        "~/.local/share/feathers-and-flame/config-ref/deployed/niri/cfg/keybinds.kdl",
        "~/.config/niri/cfg/keybinds.kdl"
    ]
    
    merged_binds = {}
    for p in paths:
        path = os.path.expanduser(p)
        binds = parse_kdl_binds(path)
        merged_binds.update(binds)
        
    if not merged_binds:
        print("No bindings found.")
        return
        
    max_key_len = max(len(k) for k in merged_binds.keys())
    max_desc_len = max(len(v['description']) for v in merged_binds.values())
    
    max_key_len = max(max_key_len + 2, 20)
    max_desc_len = max(max_desc_len + 2, 40)
    
    for key, val in sorted(merged_binds.items()):
        key_col = key.ljust(max_key_len)
        desc_col = val['description'].ljust(max_desc_len)
        action_col = val['action']
        print(f"{key_col} │ {desc_col} │ {action_col}")

if __name__ == '__main__':
    main()
