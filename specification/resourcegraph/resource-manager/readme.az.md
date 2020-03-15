## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: resourcegraph
  namespace: azure.mgmt.resourcegraph
  package-name: azure-mgmt-resourcegraph
python-sdk-output-folder: "$(output-folder)/src/resourcegraph/azext_resourcegraph/vendored_sdks/resourcegraph"
  
cli:
    cli-directive:
       - where:
             param: 'query'
         name: resource_query
        # uncomment below if json is wanted instead of flatten
#       - where:
#            group: Resources
#            param: query
#         json: true

```
