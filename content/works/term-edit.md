# term-edit.nvim
2023

[Source Code](https://github.com/chomosuke/term-edit.nvim)

## Summary
A NeoVim plugin that implement Vim keybindings for the built-in terminal buffer of NeoVim.

## Description
- [NeoVim](https://neovim.io/) is a terminal based text editor optimized for fast source code editing. Instead of using arrow keys or the mouse to navigate, it uses hjkl which is much faster to type as it's on the home row.
- However, for the built-in terminal buffer in NeoVim, because NeoVim send all the keystroke to the shell, we can not use hjkl and various other convenient vim keybindings to navigate and edit.
- To solve this issue, I decided to create a plugin that would make NeoVim's terminal buffer behave like rest of NeoVim.
- By using various methods to measures the cursor before user enter terminal mode, I was able to programmatically emit left and right arrow to the shell that would move the user's cursor to the expected position.
- I also had to invent various heuristics to guess if all keys emitted has been processed by the shell and reflected in the cursor's position.
- In the end, I was able to make NeoVim's terminal buffer behave almost identical to the rest of NeoVim.
- I announced my plugin on Reddit and received positive [reviews](https://www.reddit.com/r/neovim/comments/10h01dw/termeditnvim_making_vim_key_bindings_work_in/).
- The plugin also received more than **70 stars** on GitHub.
