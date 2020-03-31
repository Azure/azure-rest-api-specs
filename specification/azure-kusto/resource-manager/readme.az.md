## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: kusto
  namespace: azure.mgmt.kusto
  package-name: azure-mgmt-kusto
python-sdk-output-folder: "$(output-folder)/src/kusto/azext_kusto/vendored_sdks/kusto"


```
