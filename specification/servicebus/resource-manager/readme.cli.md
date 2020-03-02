<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata


``` yaml
# Migrated from Powershell's readme
clicommon:
    cli-directive:
      - select: 'operation'
        where:
            operation: '(authorization_rule(s)?$|keys$|name_availability$)'
        hidden: true
      - select: 'parameter'
        where:
            parameter: authorization_rule_name
        alias: AuthorizationRule
      - select: 'parameter'
        where:
            operation: 'authorization_rule(s)?$'
            parameter: authorization_rule_name
        name: name
      - select: 'property'
        where:
            objectSchema: 'SB_authorization_rule'
            property: 'rights'
        set:
            name: 'access_right'
            alias:
              - Right
              - Rights
      - select: 'operationGroup'
        where:
            operationGroup: 'disaster_recovery_configs'
        set:
            name: 'disaster_recovery_configurations'
      - select: 'parameter'
        where:
            operationGroup: 'disaster_recovery_configs'
            parameter: 'alias'
        set:
            name: 'name'
            alias:
                - Alias
                - AliasName
                - DisasterRecoveryConfiguration
      - select: 'operation'
        where:
            operationGroup: 'disaster_recovery_configs'
            operation: 'break_pairing'
        set:
            name: 'disable_pairing'
      - select: 'parameter'
        where:
            operationGroup: 'disaster_recovery_configs$|'
      - select: 'operationGroup'
        where:
            operationGroup: 'migration_configs'
        set:
            name: migration
      - select: 'operation'
        where:
            operationGroup: 'migration_configs'
            operation: 'revert'
        set:
            name: 'stop'
      - select: 'parameter'
        where:
            parameter: 'namespace_name'
        set:
            alias: Namespace
      - select: 'parameter'
        where:
            operationGroup: 'migration_configs'
            parameter: 'namespace_name'
        set:
            alias: Name
      - select: 'parameter'
        where:
            parameter: 'topic_name'
        set:
            alias: 'Topic'
      - select: 'parameter'
        where:
            parameter: 'queue_name'
        set:
            alias: Queue
      - select: 'parameter'
        where:
            operation: '_keys$'
            parameter: 'authorization_rule_name'
        set:
            alias: Name
```
