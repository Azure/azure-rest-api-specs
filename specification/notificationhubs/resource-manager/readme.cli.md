## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.notificationhubs
  test-scenario:
    - name: NameSpaceCreate
    - name: NotificationHubCreate
    - name: NameSpaceAuthorizationRuleCreate
    - name: NotificationHubAuthorizationRuleCreate
    - name: NotificationHubAuthorizationRuleGet
    - name: NotificationHubAuthorizationRuleListAll
    - name: NameSpaceAuthorizationRuleGet
    - name: NotificationHubGet
    - name: NameSpaceAuthorizationRuleListAll
    - name: NotificationHubListByNameSpace
    - name: NameSpaceGet
    - name: NameSpaceListByResourceGroup
    - name: NameSpaceList
    - name: OperationsList
    - name: NotificationHubAuthorizationRuleRegenrateKey
    - name: NotificationHubAuthorizationRuleListKey
    - name: NameSpaceAuthorizationRuleRegenerateKey
    - name: notificationHubPnsCredentials
    - name: NameSpaceAuthorizationRuleListKey
    - name: debugsend
    - name: NotificationHubPatch
    - name: notificationHubCheckNameAvailability
    - name: NameSpaceUpdate
    - name: NameSpaceCheckNameAvailability
    - name: NotificationHubAuthorizationRuleDelete
    - name: NameSpaceAuthorizationRuleDelete
    - name: NotificationHubDelete
    - name: NameSpaceDelete
```
