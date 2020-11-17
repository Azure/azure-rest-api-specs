## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli) && $(package-migrate)
cli:
  cli-name: migrate
  package-name: azure-mgmt-migrate
  namespace: azure.mgmt.migrate
```

``` yaml $(cli) && $(package-offazure)
cli:
  cli-name: offazure
  package-name: azure-mgmt-offazure
  namespace: azure.mgmt.offazure
```