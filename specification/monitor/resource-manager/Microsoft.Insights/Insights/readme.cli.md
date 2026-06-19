<!-- region Generated -->
# Dns
This directory contains the Cli common model for the Dns service.

> Metadata


``` yaml
# Migrated from Powershell's readme
title: Monitor
cli:
    cli-directive:
      - select: 'choiceValue'
        where:
            enum: 'comparisonOperationType'
            value: 'equals'
        set:
            name: 'equal'
      - select: 'choiceValue'
        where:
            enum: 'comparisonOperationType'
            value: 'notEquals'
        set:
            name: 'not_equal'
      - select: 'property'
        where:
            schemaObject: 'activityLogAlertLeafCondition'
            property: 'equals'
        set:
            name: 'equal'
      - select: 'operationGroup'
        where:
            operationGroup: 'metricAlertsStatus'
        set:
            name: 'metric_alert_status'
      - select: 'operation'
        where:
            operationGroup: 'activityLogAlerts'
            operation: 'update'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'metricAlerts'
            operation: '^(createOrUpdate|update)$'
        hidden: true
      - select: 'parameter'
        where:
            operationGroup: '^(metricAlerts|alertRules|alertRuleIncidents)$'
            parameter: 'ruleName'
        set:
            name: name
      - select: 'property'
        where:
            objectSchema: '^(AlertRule)$'
            property: 'isEnabled'
        set:
            name: 'enabled'
      - select: 'operation'
        where:
            operationGroup: 'alertRules'
            operation: '^(createOrUpdate|delete|update)$'
        hidden: true
      - select: 'operation'
        where:
            operationGroup: 'logProfiles'
            operation: '^(createOrUpdate|update)$'
        hidden: true
      - select: 'property'
        where:
            objectSchema: '^(AutoscaleSetting)$'
            property: 'targetResourceUri'
        set:
            name: 'target_resource_id'
      - where:
            objectSchema: '^(actionGroup)$'
            property: 'groupShortName'
        name: 'short_name'
      - where:
            operationGroup: 'actionGroups'
            operation: 'update'
        removed: true
      - where:
            operationGroup: 'metrics'
            parameter: 'interval'
        alias: time_grain
      - where:
            operationGroup: 'metrics'
            parameter: 'resourceUri'
        name: 'resource_id'
      - where:
            operationGroup: 'metricDefinitions'
            operation: 'list'
        hidden: true
      - where:
            operationGroup: 'scheduledQueryRules'
            parameter: 'ruleName'
        name: name
      - where:
            operationGroup: 'scheduledQueryRules'
            operation: '^(createOrUpdate|update)$'
        hidden: true
      - where:
            operationGroup: 'diagnosticSettingsCategory'
            parameter: 'resourceUri'
        name: 'resource_id'
      - where:
            operationGroup: 'baselines'
            operation: 'list'
        removed: true
```