## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: datafactory
  namespace: azure.mgmt.datafactory
  package-name: azure-mgmt-datafactory
az-output-folder: $(azure-cli-extension-folder)/src/datafactory
python-sdk-output-folder: "$(az-output-folder)/azext_datafactory/vendored_sdks/datafactory"

cli:
    cli-directive:
    # directive on operationGroup
      - select: 'operationGroup'
        where:
            operationGroup: 'Operations'
            operation: 'List'
        hidden: true
      - where:
            op: CreateOrUpdate
            param: If.?Match
        hidden: true
      - where:
            type: 'FactoryGitHubConfiguration'
        name: 'github_configuration'
      - where:
            type: 'FactoryVstsConfiguration'
        name: 'vsts_configuration'

```
