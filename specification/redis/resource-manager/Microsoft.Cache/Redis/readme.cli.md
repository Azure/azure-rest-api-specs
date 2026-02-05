## CLI

These settings don't need to apply `--cli` on the command line.

``` yaml
cli:
  cli-name: redis
  package-name: azure-mgmt-redis
  namespace: azure.mgmt.redis
  test-scenario:
    - name: /Redis/put/RedisCacheCreate
    - name: /PatchSchedules/put/RedisCachePatchSchedulesCreateOrUpdate
      disabled: true
    - name: /FirewallRules/put/RedisCacheFirewallRuleCreate
    - name: /LinkedServer/put/LinkedServer_Create
      disabled: true
    - name: /LinkedServer/get/LinkedServer_Get
      disabled: true
    - name: /FirewallRules/get/RedisCacheFirewallRuleGet
    - name: /PatchSchedules/get/RedisCachePatchSchedulesGet
      disabled: true
    - name: /Redis/get/RedisCacheGet
      disabled: true
    - name: /PatchSchedules/get/RedisCachePatchSchedulesList
    - name: /FirewallRules/get/RedisCacheFirewallRulesList
    - name: /LinkedServer/get/LinkedServer_List
    - name: /Redis/get/RedisCacheGet
      disabled: true
    - name: /Redis/get/RedisCacheListByResourceGroup
    - name: /Redis/get/RedisCacheList
    - name: /Operations/get/Operations_List
    - name: /Redis/post/RedisCacheRegenerateKey
    - name: /Redis/post/RedisCacheForceReboot
    - name: /Redis/post/RedisCacheListKeys
    - name: /Redis/post/RedisCacheImport
      disabled: true
    - name: /Redis/post/RedisCacheExport
      disabled: true
    - name: /Redis/patch/RedisCacheUpdate
    - name: /Redis/post/RedisCacheList
    - name: /LinkedServer/delete/LinkedServerDelete
      disabled: true
    - name: /FirewallRules/delete/RedisCacheFirewallRuleDelete
    - name: /PatchSchedules/delete/RedisCachePatchSchedulesDelete
      disabled: true
    - name: /Redis/delete/RedisCacheDelete
  
```