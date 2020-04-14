## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: hardwaresecuritymodules
  namespace: azure.mgmt.hardwaresecuritymodules
  package-name: azure-mgmt-hardwaresecuritymodules
python-sdk-output-folder: "$(output-folder)/azext_hardwaresecuritymodules/vendored_sdks/hardwaresecuritymodules"

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
