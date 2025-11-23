# marcusaandahl-nvim
## TODO
- [ ] Fix grn renaming to also follow uses in other files in CWD
- [ ] Add harpoon-like C-n/C-N with visuals
- [ ] Surround-like intellij (v word and press parenthesis)
- [ ] Remove autopair in favor of intellij like autopair (better deletion at least)
- [ ] Overseer task management
- [ ] IPYNB support
- [ ] Telescope extensions
- [ ] Debugger
- [ ] Tester???
- [ ] Improve window management mappings (creation/movement/sizing)
- [ ] Improve code-actions-completion keymappings
- [ ] Git-signs better keymaps
- [ ] Git undo selected changes support
- [ ] Git merge/rebase/cherry-pick support
- [ ] Clean unused keymappings
- [ ] Fix word search keymappings
- [ ] Improve error diagnostics key mappings
- [ ] Fix snippets not always working + overload
- [ ] Improve neovim status bar
- [ ] Improve terminal for neovim
- [ ] Setup startup page to go to projects
- [ ] Prevent automatic telescope opening when changing projects
- [ ] Buffer better keymappings/management

### Optional
- [ ] Markdown/pdf preview support
- [ ] nvim-search-and-replace ??? 

### Potential
- [ ] Fine-tune keymappings (fx oil, refactor)
- [ ] Create own snippets
- [ ] Improve open project management splash screen

Files auto-save using auto commands (see `autocmds.lua`).

## Configuration structure
In the root, there is an `init.lua` file.
In it, you can require the profile you want to use.
These profiles are in the `lua` directory.
Currently, the default, main and only one is `marcusaandahl`.

In the `lua/marcusaandahl` directory is the main configuration profile.
The entry file is `init.lua`, which maps the leader key `Space`, and requires other files, which in all make up the configuration.

### lazy_init.lua
This file sets up the package manager `lazy`. It defines the `/lazy` directory as the one containing the plugins.

### set.lua
This file defines standard vim configurations, such as tab spaces, text warp, and more notibly, the `treesitter` plugin configuration (see the plugins section).

### keys.lua
This file sets the primary keymappings, along with any setup which might need changing in the future.

### autocmds.lua
This file sets auto-commands. The most notable auto-command is the one which automatically saves files.

### colors.lua
This file sets the colorscheme.

### after.lua
This file sets up the LSP configuration and linting.

## Plugins
### overseer.nvim
Used for run configuration management.
Run configurations are per-project, which are stored in the project's `.nvim/run_configs.json` file.

### autopair.nvim
Autopairs brackets. So if one types `(`, and equivalent `)` will be inserted.

### conform.nvim
Code formatter. Use keymap `=` in visual mode to format the selection.
Its configuration is in the `after.lua` directory.

### neo-tree.nvim
Enables visualisation of file tree. Usefuly for when an overview of the project is needed.
It also includes other minor plugins, mainly for libraries and icons.

### nvim-cmp
Enables autocompletion. See the files in the `/cmp` directory to see the configuration.

I am slightly unsure how it is configured, but i think that it requires 2 steps to add autocompletion for a language:
1. Adding it to the `lazy/nvim-cmp.lua` files under `Completion Sources`.
2. Adding it to the `cmp/sources.lua` file.

### nvim.dap
Used for enabling debugging.

### project.nvim
Used for project management.
It is set to manual mode, to explicitely add/remove projects.

### telescope.nvim
Used for file/word/project search.
Run configuration mapping can be edited in there.

### todo-comments.nvim
Used for highlighting comments with certain keywords such as `TODO` or `INFO`.

### tokyonight.nvim
Used colorscheme.

### nvim-treesitter
Provides text highlighting. In the `set.lua` file, the path to the treesitter configuration is defined (by default the `treesitter-config.lua` file).

In the `treesitter-config.lua` file, languages can be added for syntax highlighting.

### undotree
Provides undotree for managing undos in a git-style.
It can be in other words be described as a local version control for the edits you are making.

### which-key.nvim
Provides grouping for keymappings. Useful for when learning commands.

### mason.nvim
### mason-lspconfig.nvim

## Keys
### Files
| Context | Mode | Key          | Result                                                                               |
| ----    | ---- | ------------ | ------------------------------------------------------------------------------------ |
| Any     | n    | `<leader>fa` | List all files in current directory                                                  |
| Any     | n    | `<leader>fg` | List all git files in current directory (ignore .gitignore-d files)                  |
| Any     | n    | `<leader>fp` | List all previously opened files                                                     |
| File    | n    | `<leader>ft` | Toggles file tree for current directory                                              |
| Any     | n    | `<leader>d`  | Opens oil file tree (OFT) in main windows using `oil.nvim` plugin (for file editing) |
| OFT     |      | `Backspace`  | Goes to parent directory                                                             |
| OFT     |      | `Enter`      | Goes to selected directory                                                           |
| OFT     |      | `h`          | Toggles showing hidden files                                                         |
| OFT     |      | `<leader>s`  | Saves changes made                                                                   |
| OFT     |      | `<leader>q`  | Quites OFT without saving changes made                                               |

### Words
| Context | Mode | Key          | Result                                                             |
| ------- | ---- | ------------ | ------------------------------------------------------------------ |
| General |      | `<leader>wl` | Live search of words in files of current directory                 |
| Editing | v    | `<leader>s`  | Live search of current selected word in files of current directory |

### Autocompletion
| Context                          | Mode | Key          | Result                                                                                 |
| -------------------------------- | ---- | ------------ | -------------------------------------------------------------------------------------- |
| Autocompletion suggestions shown |      | `Down`       | Goes down one suggestion                                                               |
| Autocompletion suggestions shown |      | `Up`         | Goes up one suggestion                                                                 |
| Autocompletion suggestions shown |      | `Tab`        | Selects and inputs the selected suggestion. If none selected, will input the first one |
| Autocompletion suggestions shown |      | `Escape`     | Hides suggestions                                                                      |

### Project Management
| Context            | Mode | Key          | Result                      |
| ------------------ | ---- | ------------ | --------------------------- |
| General            |      | `<leader>pl` | Lists all projects          |
| General            |      | `<leader>pa` | Add current dir to projects |
| Projects List View |      | `Shift-D`    | Deletes selected project    |

### Run Configurations
| Context                      | Mode | Key          | Result                                      |
| ---------------------------- | ---- | ------------ | ------------------------------------------- |
| Editing                      | n    | `Shift-D`    | Adds debug point                            |
| General                      |      | `<leader>rl` | Lists all run configurations                |
| General                      |      | `<leader>rn` | Re-runs last configurations in normal mode  |
| General                      |      | `<leader>rd` | Re-runs last configurations in debug mode   |
| General                      |      | `<leader>ra` | Adds a new run configuration                |
| Run Configurations List View |      | `Shift-A`    | Adds a new run configuration                |
| Run Configurations List View |      | `n`          | Run selected in normal mode                 |
| Run Configurations List View |      | `d`          | Run selected in debug mode                  |
| Run Configurations List View |      | `Shift-D`    | Deletes selected configuration              |
| Run Configurations List View |      | `Shift-C`    | Change selected configuration               |

### Git
| Context                      | Mode | Key          | Result                                      |
| ---------------------------- | ---- | ------------ | ------------------------------------------- |
| General                      | n    | `<leader>gs`    | Opens Git Status (GS) mode to manage changes                            |
| Editing                      | n    | `<leader>gvd`    | Opens a vertical pane showing the differences between current file, and original file                            |

### Others
| Context | Mode | Key          | Result         |
| ------- | ---- | ------------ | -------------- |
| Editing | n    | `<leader>u`  | Opens undotree |

### VIM native
* `.` runs last motion
* `Ctrl-V` visualises in block mode.
This can be combined with `j`|`k` up and down motions to select multiple lines, and press `I` to insert at multiple lines.
Once finished, press `Escape` to manifest the changes.
* `Ctrl-W J` moves window to left side.
* `Ctrl-W L` moves window to right side.
* `Ctrl-W K` moves window to upper side.
* `Ctrl-W J` moves window to down side.
* `Ctrl-W j` move to window on the left side.
* `Ctrl-W l` move to window on the right side.
* `Ctrl-W k` move to window on the upper side.
* `Ctrl-W j` move to window on the down side.
* `Ctrl-w v` creates a vertical window
* `Ctrlw- q` quits window

LSP-specific can be found at [https://vonheikemen.github.io/learn-nvim/feature/lsp-setup.html]
* `K` applies hover => used to get documentation - requires LSP
* `gc` in visual mode toggles comments
* `grn` renames references (intellij refactor) - sloppy across files
* `gra` shows code actions if error is shown
* `grr` shows in a new tab references of the given reference
* `gri` shows code implementations???
* `gO` shows all symbols in current buffer
* `Ctrl-s` in insert mode shows function signature for current function

This file will have things added to it as more useful motions are discovered.
