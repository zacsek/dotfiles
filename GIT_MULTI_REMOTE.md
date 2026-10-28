# Keeping multiple git remotes in sync

This repo has two remotes:

| Remote    | URL                                                  |
|-----------|------------------------------------------------------|
| `forgejo` | `ssh://git@git.zacsek.net:2222/zacsek/dotfiles.git`  |
| `github`  | `git@github.com:zacsek/dotfiles.git`                 |

## Option 1: an `all` remote with several push URLs (used here)

One `git push` updates both remotes. `git remote set-url` only works on an existing remote, so create `all` first:

```bash
# Create the remote. This URL becomes its fetch URL.
git remote add all ssh://git@git.zacsek.net:2222/zacsek/dotfiles.git

# Add both push URLs. Once a push URL is set, git no longer pushes to the
# fetch URL, so the first remote has to be listed here too.
git remote set-url --add --push all ssh://git@git.zacsek.net:2222/zacsek/dotfiles.git
git remote set-url --add --push all git@github.com:zacsek/dotfiles.git
```

Usage:

```bash
git push all main      # push to both
git push -u all main   # also make a plain `git push` go to both
```

`all` fetches from Forgejo only. The `forgejo` and `github` remotes are unchanged, so you can still push to or fetch from either one on its own.

## Option 2: an alias that pushes to every remote

```bash
git config --global alias.pushall '!git remote | xargs -L1 git push --all'
git pushall
```

Add `--tags` to the push if you use tags. If you also have the `all` remote, this pushes to each server twice, which is harmless.

To fetch from every remote:

```bash
git fetch --all   # or: git remote update
```

## Option 3: let the server mirror it

Forgejo can push to GitHub after every push: **Repository → Settings → Mirror settings → Push mirror**. Then you only push to Forgejo.

## If a push is rejected

All of these assume nobody commits directly to only one remote. If someone does, the push to that remote is rejected as non-fast-forward. Fix it like this:

```bash
git fetch --all
git merge github/main   # or rebase onto it
git push all main
```

Don't use `--force` unless you're sure the other remote has nothing you need.
