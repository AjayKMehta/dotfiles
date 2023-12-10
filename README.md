![Latest commit](https://img.shields.io/github/last-commit/AjayKMehta/dotfiles?style=plastic)

My dotfiles managed by [chezmoi].

Install them with:

```shell
chezmoi init --apply AjayKMehta
```

## Workflow

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

To see difference between source and target directories: `chezmoi diff`.

To add changes from target directory, use `chezmoi add`

```shell
# Need --template here because source file is template using variables!
chezmoi add --template ~/.gitconfig
```

After reviewing changes, please feel free to commit changes.

## Troubleshooting

Check config:

```shell
chezmoi dump-config
```

Verify template:

```shell
cat ~/.local/share/chezmoi/.chezmoi.toml.tmpl | chezmoi execute-template --init --promptString gpgrecipient='TEST'
```

See data:

```shell
chezmoi data
```

[chezmoi]: https://github.com/twpayne/chezmoi
