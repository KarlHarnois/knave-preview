# knave-preview

[![CI](https://github.com/KarlHarnois/knave-preview/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/KarlHarnois/knave-preview/actions/workflows/ci.yml)

A [Knave](https://github.com/knave-lang/knave) library that serves a built directory at `127.0.0.1` and rebuilds it when its sources change.

The server answers `GET` requests only, one at a time. It sends `Cache-Control: no-store`, so a refresh shows the latest build. The server does not reload the browser.

## Install

Add the library to the `libraries` of your `project.knv`:

```lisp
(defproject my-site
  (libraries
    (knave-preview :git "https://github.com/KarlHarnois/knave-preview"
                   :rev "<commit>")))
```

## Use

Pass `serve` the settings and your build function:

```lisp
(use knave-preview ->preview serve)

(deftask serve ()
  "Serves the site at http://127.0.0.1:8000 and rebuilds it on change."
  (serve (->preview :directory (str "public")
                    :port 8000
                    :watched (vec (str "content") (str "templates")))
         build-site))
```

| Setting | Meaning |
| --- | --- |
| `:directory` | The build output that the server answers from |
| `:port` | The port on `127.0.0.1` |
| `:watched` | The source directories to watch |

The build function takes no arguments and returns a `result` whose error can be displayed. `serve` runs it once at start, then again each time a file under `:watched` changes. It prints whether each build succeeded or failed.

A URL that ends in `/` serves that directory's `index.html`. A URL that contains `..` gets a 404.

## Develop

Run `direnv allow` once to load the [Nix](https://nixos.org/download/) dev shell, then use these commands:

```sh
knave test
knave fmt
knave task check-file-lengths
```
