<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata
``` yaml
# Migrated from Powershell's readme

title: Dns

cli:
    cli-directive:
      - select: 'parameter'  
        where:
            operationGroup: 'record_sets'
            parameter: 'parameters'
        set:
            name: 'record_set'
            required: true
      - select: 'parameter'
        where:
            operationGroup: 'record_sets'
            parameter: 'relative_record_set_name'
        set:
            name: 'Name'
            alias: relative_record_set_name
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
        hidden: true
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
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'zones'
            operation: 'update'
        removed: true
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
        hidden: true
```
