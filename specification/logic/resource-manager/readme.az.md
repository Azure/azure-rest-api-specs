## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: logic
  namespace: azure.mgmt.logic
  package-name: azure-mgmt-logic
python-sdk-output-folder: "$(output-folder)/src/logic/azext_logic/vendored_sdks/logic"

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
