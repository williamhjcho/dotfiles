# Clojure nvim

`conjure` plugin default keybinds

```
<leader>ee  = eval
<leader>er  = eval root
<leader>ef  = eval file
<leader>eb  = eval buffer

<leader>l   = log keybinds
<leader>ls  = log buffer split below
<leader>lv  = log buffer split right
<leader>lr  = reset log soft
<leader>lR  = reset log hard

<leader>t   = test keybinds
<leader>tc  = run test under cursor
<leader>tn  = run loaded tests under namespace
```

## Usage examples in a repo

Run the `nrepl`, ex:

```sh
$ clj -M:dev:test-env:nrepl
```

> See the repo's `deps.edn` aliases

- open a file and load it to the repl with `<leader>ef` or `<leader>eb`
- run tests:
    - load the file first (`<leader>ef`)
    - run the test under the cursor with `<leader>tc`
    - run all test in this namespace `<leader>tn`

## REPL specific tricks

- `*1` -> see last eval
- `*2` -> see the eval before last
- `*e` -> see last exception

