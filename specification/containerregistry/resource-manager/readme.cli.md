 CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: containerregistry
  package-name: azure-mgmt-containerregistry
  namespace: azure.mgmt.containerregistry
  test-scenario:
    - name: /Registries/put/RegistryCreate
    - name: /Tasks/put/Tasks_Create_WithUserIdentities_WithSystemIdentity
    - name: /Tasks/put/Tasks_Create_WithSystemAndUserIdentities
    - name: /Tasks/put/Tasks_Create
    - name: /Tasks/put/Tasks_Create_WithUserIdentities
    - name: /Tokens/put/TokenCreate
    - name: /Webhooks/put/WebhookCreate
    - name: /TaskRuns/put/TaskRuns_Create
    - name: /ScopeMaps/put/ScopeMapCreate
    - name: /AgentPools/put/AgentPools_Create
    - name: /Replications/put/ReplicationCreate
    - name: /PipelineRuns/put/PipelineRunCreate_Import
    - name: /PipelineRuns/put/PipelineRunCreate_Export
    - name: /ExportPipelines/put/ExportPipelineCreate
    - name: /ImportPipelines/put/ImportPipelineCreate
    - name: /PrivateEndpointConnections/put/PrivateEndpointConnectionCreateOrUpdate
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnectionGet
    - name: /ImportPipelines/get/ImportPipelineGet
    - name: /ExportPipelines/get/ExportPipelineGet
    - name: /PipelineRuns/get/PipelineRunGet
    - name: /Replications/get/ReplicationGet
    - name: /AgentPools/get/AgentPools_Get
    - name: /ScopeMaps/get/ScopeMapGet
    - name: /TaskRuns/get/TaskRuns_Get
    - name: /Webhooks/get/WebhookGet
    - name: /PrivateEndpointConnections/get/PrivateEndpointConnectionList
    - name: /Tokens/get/TokenGet
    - name: /Tasks/get/Tasks_Get
    - name: /Registries/get/RegistryListPrivateLinkResources
    - name: /Runs/get/Runs_Get
    - name: /ImportPipelines/get/ImportPipelineList
    - name: /ExportPipelines/get/ExportPipelineList
    - name: /PipelineRuns/get/PipelineRunList
    - name: /Replications/get/ReplicationList
    - name: /Registries/get/RegistryListUsages
    - name: /AgentPools/get/AgentPools_List
    - name: /ScopeMaps/get/ScopeMapList
    - name: /TaskRuns/get/TaskRuns_List
    - name: /Webhooks/get/WebhookList
    - name: /Tokens/get/TokenList
    - name: /Tasks/get/Tasks_List
    - name: /Runs/get/Runs_List
    - name: /Registries/get/RegistryGet
    - name: /Registries/get/RegistryListByResourceGroup
    - name: /Registries/get/RegistryList
    - name: /Operations/get/Operations_List
    - name: /AgentPools/post/AgentPools_GetQueueStatus
    - name: /Webhooks/post/WebhookGetCallbackConfig
    - name: /TaskRuns/post/TaskRuns_GetDetails
    - name: /Webhooks/post/WebhookListEvents
    - name: /Replications/patch/ReplicationUpdate
    - name: /Tasks/post/Tasks_GetDetails
    - name: /AgentPools/patch/AgentPools_Update
    - name: /Webhooks/post/WebhookPing
    - name: /Runs/post/Runs_GetLogSasUrl
    - name: /ScopeMaps/patch/ScopeMapUpdate
    - name: /TaskRuns/patch/TaskRuns_Update
    - name: /Webhooks/patch/WebhookUpdate
    - name: /Registries/post/Registries_GetBuildSourceUploadUrl
    - name: /Runs/post/Runs_Cancel
    - name: /Tokens/patch/TokenUpdate
    - name: /Tasks/patch/Tasks_Update
    - name: /Tasks/patch/Tasks_Update_WithKeyVaultCustomCredentials
    - name: /Tasks/patch/Tasks_Update_WithMSICustomCredentials
    - name: /Tasks/patch/Tasks_Update_WithOpaqueCustomCredentials
    - name: /Registries/post/RegistryRegenerateCredential
    - name: /Registries/post/RegistryGenerateCredentials
    - name: /Runs/patch/Runs_Update
    - name: /Registries/post/RegistryListCredentials
    - name: /Registries/post/ImportImageByManifestDigest
    - name: /Registries/post/ImportImageByTag
    - name: /Registries/post/Registries_ScheduleRun_EncodedTaskRun
    - name: /Registries/post/Registries_ScheduleRun
    - name: /Registries/post/Registries_ScheduleRun_Task_WithCustomCredentials
    - name: /Registries/post/Registries_ScheduleRun_WithCustomCredentials
    - name: /Registries/post/Registries_ScheduleRun_FileTaskRun
    - name: /Registries/post/ImportImageFromPublicRegistry
    - name: /Registries/post/Registries_ScheduleRun_Task
    - name: /Registries/patch/RegistryUpdate
    - name: /Registries/post/RegistryCheckNameAvailable
    - name: /Registries/post/RegistryCheckNameNotAvailable
    - name: /PrivateEndpointConnections/delete/PrivateEndpointConnectionDelete
    - name: /ExportPipelines/delete/ExportPipelineDelete
    - name: /ImportPipelines/delete/ImportPipelineDelete
    - name: /PipelineRuns/delete/PipelineRunDelete
    - name: /Replications/delete/ReplicationDelete
    - name: /AgentPools/delete/AgentPools_Delete
    - name: /ScopeMaps/delete/ScopeMapDelete
    - name: /TaskRuns/delete/TaskRuns_Delete
    - name: /Webhooks/delete/WebhookDelete
    - name: /Tokens/delete/TokenDelete
    - name: /Tasks/delete/Tasks_Delete
    - name: /Registries/delete/RegistryDelete

```