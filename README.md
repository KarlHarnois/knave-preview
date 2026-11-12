# knave-preview

[![CI](https://github.com/KarlHarnois/knave-preview/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/KarlHarnois/knave-preview/actions/workflows/ci.yml)
[![Knave v0.14.21](https://img.shields.io/badge/knave-v0.14.21-blue.svg)](https://github.com/knave-lang/knave/releases/tag/v0.14.21)
[![Nix flake](https://img.shields.io/badge/nix-flake-5277C3.svg?logo=nixos&logoColor=white)](flake.nix)

A [Knave](https://github.com/knave-lang/knave) library that serves a built directory on `127.0.0.1` and rebuilds it when a watched file changes. Refresh the page to see the new build.

## Use

Add the library to your `project.knv`:

```lisp
(defproject my-site
  (libraries
    (knave-preview :git "https://github.com/KarlHarnois/knave-preview"
                   :rev "<commit>")))
```

Call `serve` with the settings and your build function:

```lisp
(use knave-preview ->preview serve)

(deftask preview ()
  "Serves the site at http://127.0.0.1:8000 and rebuilds it on change."
  (serve
    (->preview :directory (str "public")
               :port 8000
               :watched (vec (str "content") (str "templates")))
    build-site))
```

The build function takes no arguments and returns a `result`.

## Develop

Run `direnv allow` once to load the [Nix](https://nixos.org/download/) dev shell, then use these commands:

```sh
knave test
knave fmt
knave task check-file-lengths
```
