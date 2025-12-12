The new age of auto tab renaming

### Demo:
![demo](./demo.gif)

### Install:

- using [Zinit](https://github.com/zdharma-continuum/zinit):

```zsh
zinit load ingenarel/zsh-better-tabs
```

- or just install the file manually

### Known problems:

- Zellij:
    - Zellij will only rename the current pane that the user is in:

        Zellij doesn't currently have a way to expose specific stuff like current session and window name in the CLI,
        nor does it take those as inputs for the `rename-tab` action, thus this script can rename the wrong pane for
        specific commands/executables which gets replaces by other commands/executables or quits after a certain time.

        Fixes:
            - If Zellij enables them in the CLI in future, open an issue.
            - If I learn Rust and the Zellij SDK, I'll fix it myself.
            - If you know Rust and the Zellij SDK, fix it yourself and open a PR :3

### Todo:
- Add this plugin to:
    - AUR
    - Guru
- Config options?
- More icons :3
