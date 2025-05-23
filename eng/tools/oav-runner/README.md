# `oav-runner`

This is a simple wrapper script around the `oav` tool. It utilizes shared js code code modules from `.github/shared` to
determine a list of swagger specs that should be processed.

## Invocation shortcut

```
npm ci
npm exec --no -- oav-runner <repo root path>
npm install && npm exec --no -- oav-runner ~/repo/azure-rest-api-specs
```