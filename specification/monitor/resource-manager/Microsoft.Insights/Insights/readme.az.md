## AZ

These settings apply only when `--az` is specified on the command line.
``` yaml $(az)
batch:
    - AMCS: true
```

``` yaml $(az) && $(AMCS)
az:
    extensions: monitor-control-service
    parent-extension: monitor
    namespace: azure.mgmt.amcs
    package-name: azure-mgmt-amcs
az-output-folder: $(azure-cli-extension-folder)/src/monitor-control-service
python-sdk-output-folder: "$(az-output-folder)/azext_amcs/vendored_sdks/amcs"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```

# Az.AMCS
This directory contains the CLI common model for the Azure Monitor Control Service (AMCS).

> Metadata
``` yaml $(AMCS)

extension-mode: stable

directive:

  - where:
      group: monitor monitor-control-service data-collection-rule
    set:
      group: monitor data-collection-rule
  - where:
      group: monitor data-collection-rule
    set:
      group: monitor data-collection rule

  - where:
      group: monitor monitor-control-service data-collection-rule-association
    set:
      group: monitor data-collection-rule-association
  - where:
      group: monitor data-collection-rule-association
    set:
      group: monitor data-collection rule-association
  - where:
      group: monitor data-collection rule-association
    set:
      group: monitor data-collection rule association
  
  - where:
      group: monitor monitor-control-service data-collection-endpoint
    set:
      group: monitor data-collection-endpoint
  - where:
      group: monitor data-collection-endpoint
    set:
      group: monitor data-collection endpoint

cli:
    cli-directive:
# -------- data-collection endpoint --------
      - where:
          group: DataCollectionEndpoints
          param: dataCollectionEndpointName
        alias:
          - name
          - n
      - where:
          group: DataCollectionEndpoints
          op: Create
        hidden: True
      - where:
          group: DataCollectionEndpoints
          op: Update
        hidden: True

# -------- data-collection rule --------
      - where:
          group: DataCollectionRules
          param: dataCollectionRuleName
        alias:
          - name
          - n
      - where:
          group: DataCollectionRules
          op: Create
        hidden: True
      - where:
          group: DataCollectionRules
          op: Update
        hidden: True

# -------- data-collection rule association --------
      - where:
          group: DataCollectionRuleAssociations
          param: resourceUri
        alias:
          - resource
      - where:
          group: DataCollectionRuleAssociations
          param: dataCollectionRuleName
        alias:
          - rule_name
      - where:
          group: DataCollectionRuleAssociations
          param: associationName
        alias:
          - name
          - n
      - where:
          group: DataCollectionRuleAssociations
          op: Create
        hidden: True
```
