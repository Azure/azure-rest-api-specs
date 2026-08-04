## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: redisenterprise
  test-scenario:
    redisenterprise_scenario1:
      - name: /RedisEnterprise/put/RedisEnterpriseCreate
      - name: /RedisEnterprise/get/RedisEnterpriseGet
      - name: /RedisEnterprise/get/RedisEnterpriseList
      - name: /RedisEnterprise/get/RedisEnterpriseListByResourceGroup
      - name: /Databases/get/RedisEnterpriseDatabasesGet
      - name: /Databases/get/RedisEnterpriseDatabasesListByCluster
      - name: /Databases/post/RedisEnterpriseDatabasesListKeys
      - name: /Databases/post/RedisEnterpriseDatabasesRegenerateKey
      - name: /RedisEnterprise/delete/RedisEnterpriseDelete
    redisenterprise_scenario2:
      - name: /RedisEnterprise/put/RedisEnterpriseCreate
      - name: /RedisEnterprise/get/RedisEnterpriseGet
      - name: /RedisEnterprise/get/RedisEnterpriseList
      - name: /RedisEnterprise/get/RedisEnterpriseListByResourceGroup
      - name: /Databases/put/RedisEnterpriseDatabasesCreate
      - name: /Databases/get/RedisEnterpriseDatabasesGet
      - name: /Databases/get/RedisEnterpriseDatabasesListByCluster
      - name: /Databases/post/RedisEnterpriseDatabasesListKeys
      - name: /Databases/post/RedisEnterpriseDatabasesRegenerateKey
      - name: /Databases/delete/RedisEnterpriseDatabasesDelete
      - name: /RedisEnterprise/delete/RedisEnterpriseDelete
```
