# NvChad Keymappings

This document lists all the active keymappings in your Neovim setup, combining NvChad default mappings with your custom mappings from `lua/mappings.lua`.

## 📝 Basic & General

 | Mode   | Key                  | Action                             | Source   |
 | ------ | -----                | --------                           | -------- |
 | `i`    | `jj`                 | Exit insert mode (`<ESC>`)         | Custom   |
 | `i`    | `<C-b>`              | Move beginning of line             | NvChad   |
 | `i`    | `<C-e>`              | Move end of line                   | NvChad   |
 | `i`    | `<C-h>`              | Move left                          | NvChad   |
 | `i`    | `<C-l>`              | Move right                         | NvChad   |
 | `i`    | `<C-j>`              | Move down                          | NvChad   |
 | `i`    | `<C-k>`              | Move up                            | NvChad   |
 | `n`    | `<Esc>`              | Clear highlights                   | NvChad   |
 | `n`    | `<C-s>`, `<leader>w` | Save file                          | Mixed    |
 | `n`    | `w!!`                | Save file even when forgot to sudo | Custom   |
 | `n`    | `<C-c>`              | Copy whole file                    | NvChad   |
 | `n`    | `<leader>n`          | Toggle line number                 | NvChad   |
 | `n`    | `<leader>rn`         | Toggle relative number             | NvChad   |
 | `n/x`  | `<leader>fm`         | Format file (Conform fallback)     | NvChad   |
 | `n`    | `<F3>`               | Toggle search highlight            | Custom   |
 | `n`    | `<F4>`               | Toggle line wrapping               | Custom   |
 | `n`    | `<F5>`               | Toggle list whitespace             | Custom   |
 | `n`    | `<F8>`               | Toggle paste mode                  | Custom   |
 | `n`    | `gv`                 | Select previous pasted text        | Custom   |
 | `n`    | `n`                  | Center in page: next search item   | Custom   |
 | `n`    | `N`                  | Center in page: prev search item   | Custom   |
 | `n`    | `;`                  | Enter command mode (`:`)           | Custom   |
 | `n`    | `<leader>ch`         | Toggle NvCheatsheet                | NvChad   |

## 🪟 Window & Buffer Management

*Note: Your custom mappings for `<Tab>` and `<S-Tab>` override the default NvChad buffer cycling in favor of cycling windows.*

 | Mode   | Key          | Action                            | Source   |
 | ------ | -----        | --------                          | -------- |
 | `n`    | `qq`         | Quit all (`:qa`)                  | Custom   |
 | `n`    | `<C-h>`      | Switch window left                | NvChad   |
 | `n`    | `<C-l>`      | Switch window right               | NvChad   |
 | `n`    | `<C-j>`      | Switch window down                | NvChad   |
 | `n`    | `<C-k>`      | Switch window up                  | NvChad   |
 | `n`    | `<C-Left>`   | Move focus to the left window     | Custom   |
 | `n`    | `<C-Right>`  | Move focus to the right window    | Custom   |
 | `n`    | `<C-Down>`   | Move focus to the lower window    | Custom   |
 | `n`    | `<C-Up>`     | Move focus to the upper window    | Custom   |
 | `n`    | `<Tab>`      | Move focus to the next window     | Custom   |
 | `n`    | `<S-Tab>`    | Move focus to the previous window | Custom   |
 | `n`    | `<leader>b`  | New buffer                        | NvChad   |
 | `n`    | `<leader>x`  | Close current buffer              | NvChad   |
 | `n`    | `<leader>cx` | Close all buffers                 | Custom   |

## 🧠 LSP & Diagnostics

*Note: Your custom mapping `<leader>e` for Diagnostic Error messages overrides the default NvChad NvimTree focus mapping.*

 | Mode   | Key          | Action                         | Source   |
 | ------ | -----        | --------                       | -------- |
 | `n`    | `gD`         | Go to declaration              | Custom   |
 | `n`    | `gd`         | Go to definition               | Custom   |
 | `n`    | `K`          | Open hover menu                | Custom   |
 | `n`    | `gi`         | Go to implementation           | Custom   |
 | `n`    | `<leader>ls` | Show signature help            | Custom   |
 | `n`    | `<leader>D`  | Type definition                | Custom   |
 | `n`    | `<leader>ra` | Open renamer                   | Custom   |
 | `n/v`  | `<leader>ca` | LSP code action                | Custom   |
 | `n`    | `gr`         | LSP references                 | Custom   |
 | `n`    | `g,`         | Jump back to previous location | Custom   |
 | `n`    | `<leader>wa` | Add workspace folder           | Custom   |
 | `n`    | `<leader>wr` | Remove workspace folder        | Custom   |
 | `n`    | `<leader>wl` | List workspace folders         | Custom   |
 | `n`    | `<leader>e`  | Show diagnostic error messages | Custom   |
 | `n`    | `<leader>q`  | Open diagnostic quickfix list  | Custom   |
 | `n`    | `<leader>td` | Toggle diagnostics             | Custom   |
 | `n`    | `<leader>ds` | LSP diagnostic loclist         | NvChad   |
 | `n`    | `<leader>lf` | Floating diagnostic            | Custom   |

## 🔭 Telescope & Trouble (Search/Find)

 | Mode   | Key          | Action                            | Source   |
 | ------ | -----        | --------                          | -------- |
 | `n`    | `<leader>fw` | Telescope: Live grep              | NvChad   |
 | `n`    | `<leader>ff` | Telescope: Find files             | NvChad   |
 | `n`    | `<leader>fa` | Telescope: Find all files         | NvChad   |
 | `n`    | `<leader>fb` | Telescope: Find buffers           | NvChad   |
 | `n`    | `<leader>fh` | Telescope: Help page              | NvChad   |
 | `n`    | `<leader>ma` | Telescope: Find marks             | NvChad   |
 | `n`    | `<leader>fo` | Telescope: Find oldfiles          | NvChad   |
 | `n`    | `<leader>fz` | Telescope: Find in current buffer | NvChad   |
 | `n`    | `<leader>pt` | Telescope: Pick hidden term       | NvChad   |
 | `n`    | `<leader>th` | Telescope: NvChad themes          | NvChad   |
 | `n`    | `<leader>qx` | Trouble: Open Trouble             | Custom   |
 | `n`    | `<leader>qw` | Trouble: Workspace diagnostics    | Custom   |
 | `n`    | `<leader>qd` | Trouble: Document diagnostics     | Custom   |
 | `n`    | `<leader>qq` | Trouble: Quickfix list            | Custom   |
 | `n`    | `<leader>ql` | Trouble: Location list            | Custom   |
 | `n`    | `<leader>ft` | Trouble: Find Todo (Telescope)    | Custom   |
 | `n`    | `<leader>qt` | Trouble: Open Todo Trouble        | Custom   |

## 💻 Terminal

 | Mode   | Key         | Action                     | Source   |
 | ------ | -----       | --------                   | -------- |
 | `t`    | `<C-x>`     | Escape terminal mode       | NvChad   |
 | `n`    | `<leader>h` | New horizontal terminal    | NvChad   |
 | `n`    | `<leader>v` | New vertical terminal      | NvChad   |
 | `n/t`  | `<A-v>`     | Toggle vertical terminal   | NvChad   |
 | `n/t`  | `<A-h>`     | Toggle horizontal terminal | NvChad   |
 | `n/t`  | `<A-i>`     | Toggle floating terminal   | NvChad   |
 | `n/t`  | `<C-]>`     | Toggle vertical terminal   | Custom   |
 | `n/t`  | `<C-">`     | Toggle horizontal terminal | Custom   |
 | `n/t`  | `<C-f>`     | Toggle floating terminal   | Custom   |

## 🌿 Git

*Note: Custom mapping `<leader>gt` overrides NvChad's Telescope Git Status for Diffview File History.*

 | Mode   | Key          | Action                      | Source   |
 | ------ | -----        | --------                    | -------- |
 | `n`    | `<leader>cm` | Telescope: Git commits      | NvChad   |
 | `n`    | `<leader>gt` | Diffview File History       | Custom   |
 | `n`    | `<leader>gl` | Git Log (Flog)              | Custom   |
 | `n`    | `<leader>gf` | Git File History (Diffview) | Custom   |
 | `n`    | `<leader>gc` | Git Last Commit (Diffview)  | Custom   |

## 🧪 Tests & Debugging

 | Mode   | Key          | Action                      | Source   |
 | ------ | -----        | --------                    | -------- |
 | `n`    | `<leader>tt` | Run nearest test (Neotest)  | Custom   |
 | `n`    | `<leader>tf` | Run file test (Neotest)     | Custom   |
 | `n`    | `<leader>to` | Show test output (Neotest)  | Custom   |
 | `n`    | `<leader>ts` | Show test summary (Neotest) | Custom   |
 | `n`    | `<leader>du` | Toggle Debug UI (DAP)       | Custom   |
 | `n`    | `<leader>db` | Toggle Breakpoint (DAP)     | Custom   |
 | `n`    | `<leader>ds` | Start Debugging (DAP)       | Custom   |
 | `n`    | `<leader>dn` | Step Over (DAP)             | Custom   |

## 🧩 Plugins (Other)

 | Mode  | Key                       | Action                              | Source          |
 | ----- | ------------------------- | ----------------------------------- | --------------- |
 | `n/v` | `<leader>/`               | Toggle comment                      | NvChad          |
 | `n`   | `<C-n>`                   | Toggle NvimTree window              | NvChad          |
 | `n`   | `<leader>wK`              | WhichKey: Show all keymaps          | NvChad          |
 | `n`   | `<leader>wk`              | WhichKey: Query lookup              | NvChad          |
 | `n`   | `ys{motion}{char}`        | Add surrounding                     | `nvim-surround` |
 | `n`   | `ds{char}`                | Delete surrounding                  | `nvim-surround` |
 | `n`   | `cs{target}{replacement}` | Change surrounding                  | `nvim-surround` |
 | `v`   | `S{char}`                 | Add surrounding to visual selection | `nvim-surround` |
