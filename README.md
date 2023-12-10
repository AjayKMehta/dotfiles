![Latest commit](https://img.shields.io/github/last-commit/AjayKMehta/dotfiles?style=plastic)

My dotfiles managed by [chezmoi].

Install them with:

```shell
chezmoi init --apply AjayKMehta
```

Subsequently, use this to get latest changes from this repo:

```shell
chezmoi update
```

If you just want to pull latest changes and see what happens:

```shell
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

If the changes are OK, you can then:

```shell
chezmoi apply
```

Check config:

```shell
chezmoi dump-config
```

[chezmoi]: https://github.com/twpayne/chezmoi
