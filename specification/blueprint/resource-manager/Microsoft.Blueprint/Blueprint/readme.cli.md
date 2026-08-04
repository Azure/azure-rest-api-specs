## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.blueprint
  flatten-all: true
  cmd-override:
    "^.*assignment-operation.*$": "-"
```
