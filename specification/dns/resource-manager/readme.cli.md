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
            operationGroup: 'recordSets'
            parameter: 'parameters'
        set:
            name: 'record_set'
            required: true
      - select: 'parameter'
        where:
            operationGroup: 'recordSets'
            parameter: 'relativeRecordSetName'
        set:
            name: 'name'
            alias: relative_record_set_name
      - select: 'parameter'
        where:
            operationGroup: 'recordSets'
            parameter: '(recordsetnamesuffix|recordSetNameSuffix)'
        set:
            name: 'name_suffix'
      - select: 'operation'
        where:
            operationGroup: 'recordSets'
            operation: '^(createOrUpdate|update)$'
        hidden: true
      - select: 'parameter'
        where:
            operationGroup: 'dnsResourceReference'
            parameter: 'parameters'
        set:
            name: 'resource_reference'
      - select: 'operation'
        where:
            operationGroup: 'dnsResourceReference'
            operation: 'getByTargetResources'
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
            operation: 'createOrUpdate'
        hidden: true
```
