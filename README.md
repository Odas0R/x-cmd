# x-cmd

Have you ever tried the `npm completion` of bash?

It's horribly slow.

I'm used to <tab> to autocomplete scripts, thus creating `nr`.
It's a simple wrapper for the command `npm run` that uses the
`jq` program to process the `package.json` files for scripts.

Instead of using `npm run`, use `nr` 🍭

## Autocompletion

Just source this on your `.bashrc`:

```bash
if [[ -x "$(command -v nr)" ]]; then
  complete -C nr nr
fi
```

**Note:** You'll need to have `nr` globally accessible, must be
accessible through your `$PATH`.

## Dependencies

* `jq`: <https://stedolan.github.io/jq/>
