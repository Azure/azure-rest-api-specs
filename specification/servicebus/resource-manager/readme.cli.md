<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata


``` yaml
# Migrated from Powershell's readme
cli:
    cli-directive:
      - select: 'operation'
        where:
            operation: '(authorizationRule(s)?$|keys$|nameAvailability$)'
        hidden: true
      - select: 'parameter'
        where:
            parameter: authorizationRuleName
        alias: authorization_rule
      - select: 'parameter'
        where:
            operation: 'authorizationRule(s)?$'
            parameter: authorizationRuleName
        name: name
      - select: 'property'
        where:
            objectSchema: 'SBAuthorizationRule-properties'
            property: 'rights'
        set:
            name: 'access_right'
            alias:
              - right
              - rights
      - select: 'operationGroup'
        where:
            operationGroup: 'disasterRecoveryConfigs'
        set:
            name: 'disaster_recovery_configurations'
      - select: 'parameter'
        where:
            operationGroup: 'disasterRecoveryConfigs'
            parameter: 'alias'
        set:
            name: 'name'
            alias:
                - 'alias'
                - 'alias_name'
                - 'disaster_recovery_configuration'
      - select: 'operation'
        where:
            operationGroup: 'disasterRecoveryConfigs'
            operation: 'breakPairing'
        set:
            name: 'disablePairing'
      - select: 'operationGroup'
        where:
            operationGroup: 'migrationConfigs'
        set:
            name: migration
      - select: 'operation'
        where:
            operationGroup: 'migrationConfigs'
            operation: 'revert'
        set:
            name: 'stop'
      - select: 'parameter'
        where:
            parameter: 'namespaceName'
        set:
            alias: 'namespace'
      - select: 'parameter'
        where:
            operationGroup: 'migrationConfigs'
            parameter: 'namespaceName'
        set:
            alias: 'name'
      - select: 'parameter'
        where:
            parameter: 'topicName'
        set:
            alias: 'topic'
      - select: 'parameter'
        where:
            parameter: 'queueName'
        set:
            alias: 'queue'
      - select: 'parameter'
        where:
            operation: 'Keys$'
            parameter: 'authorizationRuleName'
        set:
            alias: 'name'
```
