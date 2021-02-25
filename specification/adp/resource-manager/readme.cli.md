## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml $(azure-cli-extension-folder) != ''
directive:
- from: swagger-document
  where: $.definitions.DataPoolLocation
  transform: >
    $.properties.encryption["x-ms-client-flatten"] = true;
```
