<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata


``` yaml
# Migrated from Powershell's readme
cli:
    cli-name: servicebus 
    package-name: azure-mgmt-servicebus
    namespace: azure.mgmt.servicebus
    test-scenario:
      - name: /Namespaces/put/NameSpaceCreate
      - name: /Topics/put/TopicCreate
      - name: /Queues/put/QueueCreate
      - name: /DisasterRecoveryConfigs/put/SBAliasCreate
      - name: /MigrationConfigs/put/MigrationConfigurationsStartMigration
      - name: /Namespaces/put/NameSpaceNetworkRuleSetCreate
      - name: /Namespaces/put/NameSpaceAuthorizationRuleCreate
      - name: /Subscriptions/put/SubscriptionCreate
      - name: /Queues/put/QueueAuthorizationRuleCreate
      - name: /Topics/put/TopicAuthorizationRuleCreate
      - name: /Rules/put/RulesCreateCorrelationFilter
      - name: /Rules/put/RulesCreateSqlFilter
      - name: /Rules/put/RulesCreateOrUpdate
      - name: /DisasterRecoveryConfigs/get/DisasterRecoveryConfigsAuthorizationRuleGet
      - name: /Rules/get/RulesGet
      - name: /Topics/get/TopicAuthorizationRuleGet
      - name: /Queues/get/QueueAuthorizationRuleGet
      - name: /Rules/get/RulesListBySubscriptions
      - name: /Subscriptions/get/SubscriptionGet
      - name: /Subscriptions/get/SubscriptionListByTopic
      - name: /DisasterRecoveryConfigs/get/NameSpaceAuthorizationRuleListAll
      - name: /Namespaces/get/NameSpaceAuthorizationRuleGet
      - name: /Namespaces/get/NameSpaceNetworkRuleSetGet
      - name: /Topics/get/TopicAuthorizationRuleListAll
      - name: /Queues/get/QueueAuthorizationRuleListAll
      - name: /MigrationConfigs/get/MigrationConfigurationsGet
      - name: /DisasterRecoveryConfigs/get/SBAliasGet
      - name: /DisasterRecoveryConfigs/get/SBAliasList
      - name: /Queues/get/QueueGet
      - name: /Topics/get/TopicGet
      - name: /MigrationConfigs/get/MigrationConfigurationsList
      - name: /Namespaces/get/NameSpaceAuthorizationRuleListAll
      - name: /Namespaces/get/NameSpaceNetworkRuleSetList
      - name: /EventHubs/get/RulesCreateOrUpdate
      - name: /Topics/get/TopicGet
      - name: /Queues/get/QueueListByNameSpace
      - name: /Namespaces/get/NameSpaceGet
      - name: /Namespaces/get/NameSpaceListByResourceGroup
      - name: /PremiumMessagingRegions/get/PremiumMessagingRegionsList
      - name: /Regions/get/RegionsListBySku
      - name: /Namespaces/get/NameSpaceList
      - name: /Operations/get/OperationsList
      - name: /DisasterRecoveryConfigs/post/DisasterRecoveryConfigsAuthorizationRuleListKey
      - name: /Topics/post/TopicAuthorizationRuleRegenerateKey
      - name: /Queues/post/QueueAuthorizationRuleRegenerateKey
      - name: /Topics/post/TopicAuthorizationRuleListKey
      - name: /Queues/post/QueueAuthorizationRuleListKey
      - name: /Namespaces/post/NameSpaceAuthorizationRuleRegenerateKey
      - name: /DisasterRecoveryConfigs/post/AliasNameAvailability
      - name: /Namespaces/post/NameSpaceAuthorizationRuleListKey
      - name: /MigrationConfigs/post/MigrationConfigurationsCompleteMigration
      - name: /MigrationConfigs/post/MigrationConfigurationsRevert
      - name: /DisasterRecoveryConfigs/post/SBEHAliasBreakPairing
      - name: /DisasterRecoveryConfigs/post/SBAliasFailOver
      - name: /Namespaces/post/NameSpaceUpdate
      - name: /Namespaces/patch/NameSpaceUpdate
      - name: /Namespaces/post/NameSpaceCheckNameAvailability
      - name: /Rules/delete/RulesDelete
      - name: /Queues/delete/QueueAuthorizationRuleDelete
      - name: /Topics/delete/TopicAuthorizationRuleDelete
      - name: /Subscriptions/delete/SubscriptionDelete
      - name: /Namespaces/delete/NameSpaceAuthorizationRuleDelete
      - name: /MigrationConfigs/delete/MigrationConfigurationsDelete
      - name: /DisasterRecoveryConfigs/delete/SBAliasDelete
      - name: /Topics/delete/TopicDelete
      - name: /Queues/delete/QueueDelete
      - name: /Namespaces/delete/NameSpaceDelete
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
