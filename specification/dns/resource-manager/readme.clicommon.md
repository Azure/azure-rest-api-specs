<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata
``` yaml
# Migrated from Powershell's readme

title: Dns
```

``` yaml
# Migrated from Powershell's readme

clicommon:
    cli-directive:
      - select: 'parameter'  
        where:
            operationGroup: 'record_sets'
            parameter: 'parameters'
        set:
            name: 'record_set'
      - select: 'parameter'
        where:
            operationGroup: 'record_sets'
            parameter: 'relative_record_set_name'
        set:
            name: 'Name'
            alias: RelativeRecordSetName
      - select: 'parameter'
        where:
            operationGroup: 'record_sets'
            parameter: '(recordsetnamesuffix|record_set_name_suffix)'
        set:
            name: 'name_suffix'
      - select: 'operation'
        where:
            operationGroup: 'record_sets'
            operation: '^(create_or_update|update)$'
        set:
            hide: true
      - select: 'parameter'
        where:
            operationGroup: 'dns_resource_reference'
            parameter: 'parameters'
        set:
            name: 'resource_reference'
      - select: 'operation'
        where:
            operationGroup: 'dns_resource_reference'
            operation: 'get_by_target_resources'
        set:
            hide: true
      - select: 'operation'
        where:
            operationGroup: 'zones'
            operation: 'update'
        set:
            remove: true
      - select: 'parameter'
        where:
            operationGroup: 'zones'
            parameter: 'parameters'
        set:
            name: 'zone'
      - select: 'operation'
        where:
            operationGroup: 'zones'
            operation: 'create_or_update'
        set:
            hide: true
```
