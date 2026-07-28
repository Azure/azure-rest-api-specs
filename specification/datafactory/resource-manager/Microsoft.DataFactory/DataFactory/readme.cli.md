## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.datafactory
  test-scenario:
    - name: Factories_CreateOrUpdate
    - name: Factories_Update
    - name: LinkedServices_Create
    - name: LinkedServices_Update
    - name: Datasets_Create
    - name: Datasets_Update
    - name: Pipelines_Create
    - name: Pipelines_Update
    - name: Triggers_Create
    - name: Triggers_Update
    - name: IntegrationRuntimes_Create
    - name: IntegrationRuntimes_Update
    - name: IntegrationRuntimes_CreateLinkedIntegrationRuntime
    - name: Pipelines_CreateRun
    - name: IntegrationRuntimes_Get
    - name: RerunTriggers_ListByTrigger
    - name: LinkedServices_Get
    - name: PipelineRuns_Get
    - name: Pipelines_Get
    - name: Datasets_Get
    - name: Triggers_Get
    - name: IntegrationRuntimes_ListByFactory
    - name: LinkedServices_ListByFactory
    - name: Pipelines_ListByFactory
    - name: Triggers_ListByFactory
    - name: Datasets_ListByFactory
    - name: Factories_Get
    - name: Factories_ListByResourceGroup
    - name: Factories_List
    - name: Operations_List
    - name: RerunTriggers_Cancel
    - name: RerunTriggers_Start
    - name: RerunTriggers_Stop
    - name: IntegrationRuntimes_RegenerateAuthKey
    - name: TriggerRuns_Rerun
    - name: IntegrationRuntimes_GetConnectionInfo
    - name: IntegrationRuntimes_SyncCredentials
    - name: IntegrationRuntimes_GetMonitoringData
    - name: IntegrationRuntimes_ListAuthKeys
    - name: IntegrationRuntimes_Upgrade
    - name: IntegrationRuntimes_GetStatus
    - name: IntegrationRuntimes_Start
    - name: IntegrationRuntimes_Stop
    - name: Triggers_GetEventSubscriptionStatus
    - name: ActivityRuns_QueryByPipelineRun
    - name: Triggers_UnsubscribeFromEvents
    - name: Triggers_SubscribeToEvents
    - name: Triggers_Start
    - name: Triggers_Stop
    - name: Factories_GetGitHubAccessToken
    - name: Factories_GetDataPlaneAccess
    - name: PipelineRuns_QueryByFactory
    - name: PipelineRuns_Cancel
    - name: TriggerRuns_QueryByFactory
    - name: Factories_ConfigureFactoryRepo
    - name: IntegrationRuntimes_Delete
    - name: Triggers_Delete
    - name: Pipelines_Delete
    - name: Datasets_Delete
    - name: LinkedServices_Delete
    - name: Factories_Delete
```
