# nvim-tree.lua force push recovery
2023

[Issue](https://github.com/nvim-tree/nvim-tree.lua/issues/1906)

## Summary
Helped the maintainer of nvim-tree.lua recover some commits that was lost due to an accidental force push.

## Description
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) is a [NeoVim](https://neovim.io/) file explorer that I've contributed to significantly. The project uses [Git](../skills/git.md).
- I discovered that the project was force pushed when I was working on a pull request and notices that my master branch has diverged from the remote.
- I was able to identify the pull request where the force push happened, and I commented below in an effort to notify the maintainer.
- An [issue](https://github.com/nvim-tree/nvim-tree.lua/issues/1906) was raise on the next day about the force push which the maintainer responded to.
- The immediate cause of action that the maintainer took was to merge all the lost commits back to the master branch and put out a notice on the project's README notifying users about the force push.
- However, this solution was not ideal. Many users use a package manager called [packer.nvim](https://github.com/wbthomason/packer.nvim) which is known to throw errors when the git history of the package is rewritten.
- I asked the maintainer to do another force push to restore the git history back to the point right before the accidental force pushed happened. However, we couldn't do that because while the most recent commit exists on GitHub, it couldn't retrieve it via git pull as it wasn't reachable by any branches.
- I was able to bring the lost commits back by creating a branch pointed towards it via [GitHub's API](https://docs.github.com/en/rest/git/refs?apiVersion=2022-11-28#create-a-reference).
- In the end, we were able to restore the git history in a way as if the force pushed has never happened. By doing that, we avoided having thousands (the package around 30000 unique cloners every 10 days) of users encountering error when they try to update the package.
