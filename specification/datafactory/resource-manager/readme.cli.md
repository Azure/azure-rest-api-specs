## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.datafactory
  flatten-all: true
  test-scenario:
    - name: Factories_CreateOrUpdate
    #- name: Datasets_Create
    #- name: Datasets_Update
    #- name: Triggers_Update
    #- name: Triggers_Create
    #- name: DataFlows_Update
    #- name: Pipelines_Create
    #- name: DataFlows_Create
    #- name: Pipelines_Update
    #- name: LinkedServices_Create
    #- name: LinkedServices_Update
    #- name: IntegrationRuntimes_Create
    #- name: RerunTriggers_Create
    #- name: IntegrationRuntimeNodes_Get
    #- name: IntegrationRuntimes_Get
    #- name: RerunTriggers_ListByTrigger
    #- name: LinkedServices_Get
    #- name: PipelineRuns_Get
    #- name: Pipelines_Get
    #- name: DataFlows_Get
    #- name: Datasets_Get
    #- name: Triggers_Get
    #- name: IntegrationRuntimes_ListByFactory
    #- name: LinkedServices_ListByFactory
    #- name: DataFlows_ListByFactory
    #- name: Pipelines_ListByFactory
    #- name: Triggers_ListByFactory
    #- name: Datasets_ListByFactory
    #- name: Factories_Get
    #- name: Factories_ListByResourceGroup
    #- name: Factories_List
    #- name: Operations_List
    #- name: IntegrationRuntimeNodes_GetIpAddress
    #- name: IntegrationRuntimes_CreateLinkedIntegrationRuntime
    #- name: RerunTriggers_Cancel
    #- name: RerunTriggers_Start
    #- name: IntegrationRuntimeNodes_Update
    #- name: IntegrationRuntimeObjectMetadata_Refresh
    #- name: RerunTriggers_Stop
    #- name: IntegrationRuntimes_RegenerateAuthKey
    #- name: Triggers_Rerun
    #- name: IntegrationRuntimeObjectMetadata_Get
    #- name: IntegrationRuntimes_GetConnectionInfo
    #- name: IntegrationRuntimes_SyncCredentials
    #- name: IntegrationRuntimes_GetMonitoringData
    #- name: IntegrationRuntimes_ListAuthKeys
    #- name: IntegrationRuntimes_Upgrade
    #- name: IntegrationRuntimes_GetStatus
    #- name: IntegrationRuntimes_Upgrade
    #- name: IntegrationRuntimes_Start
    #- name: IntegrationRuntimes_Stop
    #- name: Triggers_GetEventSubscriptionStatus
    #- name: ActivityRuns_QueryByPipelineRun
    #- name: IntegrationRuntimes_Update
    #- name: Triggers_UnsubscribeFromEvents
    #- name: Triggers_SubscribeToEvents
    #- name: PipelineRuns_Cancel
    #- name: Pipelines_CreateRun
    #- name: Triggers_Start
    #- name: Triggers_Stop
    #- name: DataFlowDebugSession_ExecuteCommand
    #- name: DataFlowDebugSession_Delete
    #- name: DataFlowDebugSession_Create
    #- name: DataFlowDebugSession_QueryByFactory
    #- name: DataFlowDebugSession_AddDataFlow
    #- name: Factories_GetGitHubAccessToken
    #- name: Factories_GetDataPlaneAccess
    #- name: PipelineRuns_QueryByFactory
    #- name: TriggerRuns_QueryByFactory
    #- name: ExposureControl_GetFeatureValueByFactory
    #- name: Factories_Update
    #- name: Factories_ConfigureFactoryRepo
    #- name: ExposureControl_GetFeatureValue
    #- name: IntegrationRuntimesNodes_Delete
    #- name: IntegrationRuntimes_Delete
    #- name: LinkedServices_Delete
    #- name: Pipelines_Delete
    #- name: DataFlows_Delete
    #- name: Datasets_Delete
    #- name: Triggers_Delete
    #- name: Factories_Delete
```
