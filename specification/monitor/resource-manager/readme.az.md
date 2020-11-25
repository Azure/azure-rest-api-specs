## AZ

These settings apply only when `--az` is specified on the command line.
``` yaml $(az)
batch:
    - AMCS: true
```

``` yaml $(az) && $(AMCS)
az:
    extensions: data-collection
    parent-extension: monitor
    namespace: azure.mgmt.amcs
    package-name: azure-mgmt-amcs
az-output-folder: $(azure-cli-extension-folder)/src/monitor-control-service
python-sdk-output-folder: "$(az-output-folder)/azext_amcs/vendored_sdks/amcs"
# add additinal configuration here specific for Azure CLI
# refer to the faq.md for more details
```

# Az.AMCS
This directory contains the CLI common model for the Azure Monitor Control Service (AMCS).

> Metadata
``` yaml $(AMCS)

extension-mode: preview

directive:
  - where:
      group: monitor data-collection data-collection-rule
    set:
      group: monitor data-collection rule
  - where:
      group: monitor data-collection data-collection-rule-association
    set:
      group: monitor data-collection rule-association
  - where:
      group: monitor data-collection rule-association
    set:
      group: monitor data-collection rule association

cli:
    cli-directive:
# -------- data-collection rule --------
      - where:
          group: DataCollectionRules
          param: dataCollectionRuleName
        name: name
        alias:
          - name
          - n
    #   - where:
    #       group: DataCollectionRules
    #       op: Create
    #     hide: True
    #   - where:
    #       group: DataCollectionRules
    #       op: Update
    #     hide: True

      - where:
          group: DataCollectionRules
          param: windowsEventLogs
        set:
         alias: windows_event_log
      - where:
          group: DataCollectionRules
          param: performanceCounters
        set:
         alias: performance_counter
      - where:
          group: DataCollectionRules
          param: syslog
        set:
         alias: syslog
      - where:
          group: DataCollectionRules
          param: extension
        set:
         alias: extension
      - where:
          group: DataCollectionRules
          param: destinations
        set:
          alias: destination
      - where:
          group: DataCollectionRules
          param: streams
        set:
          alias: stream

# -------- data-collection rule association --------
      - where:
          group: DataCollectionRuleAssociations
          param: resourceUri
        name: resource
      - where:
          group: DataCollectionRuleAssociations
          param: dataCollectionRuleName
        name: rule_name
      - where:
          group: DataCollectionRuleAssociations
          param: associationName
        name: name
        alias:
          - name
          - n
      - where:
          group: DataCollectionRuleAssociations
          op: Create
          param: dataCollectionRuleId
        name: rule_id


```
