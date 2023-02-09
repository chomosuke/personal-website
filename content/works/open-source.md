# Open Source Contributions
2022-2023

## Summary
Contributed to various open source projects

## Description
- During the summer holiday from 2022 Dec to 2023 Jan, I decided to fix a number of bugs and deficiencies in the various open source projects I use.
- The notable contributions include:
	- [logiops](https://github.com/PixlOne/logiops)
		- logiops is an unofficial Linux driver for Logitech mice and keyboard written in [C++](../skills/cpp.md).
		- The mouse gesture behavior on the driver was suboptimal compared to the official Logitech software on Windows in a number of ways.
		- I was able to improve the gesture behavior to match the official software after some refactoring.
		- Unfortunately, the maintainer has stopped maintaining the project since the beginning of 2022. While there are some talks of [getting additional maintainers for the project](https://github.com/PixlOne/logiops/issues/348), those talk has not resulted in any actions. As a result, my [Pull Request](https://github.com/PixlOne/logiops/pull/343) has not yet been merged as of writing.
	- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
		- nvim-tree is a file explorer plugin for NeoVim written in [Lua](../skills/lua.md).
		- It displays various attributes for files and their parent directories such as git status, diagnostics, and whether the file is currently opened.
		- To improve user experience, I added the option to [only display attributes on parent directories when they're closed](https://github.com/nvim-tree/nvim-tree.lua/pull/1778).
		- I also added an option to [indicate whether a file has unsaved changes](https://github.com/nvim-tree/nvim-tree.lua/pull/1835).
		- My changes received positive feedbacks from project maintainers and users.
	- [Neovide](https://github.com/neovide/neovide)
		- Neovide is a GUI frontend for NeoVim written in [Rust](../skills/rust.md).
		- I submitted several [bug fixes](https://github.com/neovide/neovide/pulls?q=is%3Apr+author%3Achomosuke+).
- A complete list of all my contributions can be found on my [GitHub profile](https://github.com/chomosuke#pull-requests).
- Not only was contributing to open source rewarding and fulfilling, it also made me better at navigating unfamiliar code bases and [collaborating](../skills/collaboration.md) with others.
