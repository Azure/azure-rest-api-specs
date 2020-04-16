## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: logic
  namespace: azure.mgmt.logic
  package-name: azure-mgmt-logic
az-output-folder: $(azure-cli-extension-folder)/src/logic
python-sdk-output-folder: "$(az-output-folder)/azext_logic/vendored_sdks/logic"

# uncomment following to use json instead of flatten
#cli:
#    cli-directive:
#       - where:
#            group: 'Workflows'
#            op: 'CreateOrUpdate'
#            param: 'workflow'
#         json: true
#       - where:
#            type: 'workflow'
#            prop: 'properties'
#         flatten: false

```
