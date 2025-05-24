# `oav-runner`

This is a simple wrapper script around the `oav` tool. It utilizes shared js code code modules from `.github/shared` to
determine a list of swagger specs that should be processed, processes them, then outputs necessary detailed run
information.

## Invocation shortcuts

```
cd <repo root>
npm ci && npm exec --no -- oav-runner <targetdir> <"specs"/"examples">
```