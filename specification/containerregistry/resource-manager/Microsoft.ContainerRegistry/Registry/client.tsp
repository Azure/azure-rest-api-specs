import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryManagementClient",
  "javascript"
);

@@clientName(Microsoft.ContainerRegistry.PrivateEndpointConnection, "ContainerRegistryPrivateEndpointConnectionData", "csharp");
@@clientName(Action, "ContainerRegistryIPRuleAction", "csharp");
@@clientName(ActionsRequired, "ActionsRequiredForPrivateLinkServiceConsumer", "csharp");
@@clientName(ActivationProperties, "ConnectedRegistryActivation", "csharp");
@@clientName(ActivationStatus, "ConnectedRegistryActivationStatus", "csharp");
@@clientName(Actor, "ContainerRegistryWebhookEventActor", "csharp");
@@clientName(Archive, "ContainerRegistryArchive", "csharp");
@@clientName(ArchiveVersion, "ContainerRegistryArchiveVersion", "csharp");
@@clientName(AuditLogStatus, "ConnectedRegistryAuditLogStatus", "csharp");
@@clientName(AuthCredential, "ContainerRegistryAuthCredential", "csharp");
@@clientName(AzureADAuthenticationAsArmPolicyStatus, "AadAuthenticationAsArmPolicyStatus", "csharp");
@@clientName(CacheRule, "ContainerRegistryCacheRule", "csharp");
@@clientName(CallbackConfig, "ContainerRegistryWebhookCallbackConfig", "csharp");
@@clientName(CertificateType, "ContainerRegistryCertificateType", "csharp");
@@alternateType(CredentialSet.identity, ManagedServiceIdentity, "csharp");
@@clientName(ConnectionState, "ConnectedRegistryConnectionState", "csharp");
@@clientName(ConnectionStatus, "ContainerRegistryPrivateLinkServiceConnectionStatus", "csharp");
@@alternateType(ConnectedRegistryProperties.clientTokenIds, armResourceIdentifier[], "csharp");
@@clientName(CredentialHealth, "ContainerRegistryCredentialHealth", "csharp");
@@clientName(CredentialHealthStatus, "ContainerRegistryCredentialHealthStatus", "csharp");
@@clientName(CredentialName, "ContainerRegistryCredentialName", "csharp");
@@clientName(CredentialSet, "ContainerRegistryCredentialSet", "csharp");
@@clientName(DefaultAction, "ContainerRegistryNetworkRuleDefaultAction", "csharp");
@@clientName(Microsoft.ContainerRegistry.EncryptionProperty, "ContainerRegistryEncryption", "csharp");
@@clientName(EncryptionStatus, "ContainerRegistryEncryptionStatus", "csharp");
@@clientName(Event, "ContainerRegistryWebhookEvent", "csharp");
@@clientName(EventContent, "ContainerRegistryWebhookEventContent", "csharp");
@@clientName(EventInfo, "ContainerRegistryWebhookEventInfo", "csharp");
@@clientName(EventListResult, "ContainerRegistryWebhookEventListResult", "csharp");
@@clientName(EventRequestMessage, "ContainerRegistryWebhookEventRequestMessage", "csharp");
@@clientName(EventResponseMessage, "ContainerRegistryWebhookEventResponseMessage", "csharp");
@@clientName(ExportPolicy, "ContainerRegistryExportPolicy", "csharp");
@@clientName(ExportPolicyStatus, "ContainerRegistryExportPolicyStatus", "csharp");
@@clientName(GenerateCredentialsParameters, "ContainerRegistryGenerateCredentialsContent", "csharp");
@@clientName(GenerateCredentialsResult, "ContainerRegistryGenerateCredentialsResult", "csharp");
@@clientName(IPRule, "ContainerRegistryIPRule", "csharp");
@@clientName(ImportImageParameters, "ContainerRegistryImportImageParameters", "csharp");
@@clientName(ImportMode, "ContainerRegistryImportMode", "csharp");
@@clientName(ImportSource, "ContainerRegistryImportSource", "csharp");
@@clientName(ImportSource.registryUri, "RegistryAddress", "csharp");
@@clientName(ImportSourceCredentials, "ContainerRegistryImportSourceCredentials", "csharp");
@@clientName(KeyVaultProperties, "ContainerRegistryKeyVaultProperties", "csharp");
@@clientName(KeyVaultProperties.keyRotationEnabled, "IsKeyRotationEnabled", "csharp");
@@clientName(LogLevel, "ConnectedRegistryLogLevel", "csharp");
@@clientName(LoggingProperties, "ConnectedRegistryLogging", "csharp");
@@clientName(LoginServerProperties, "ConnectedRegistryLoginServer", "csharp");
@@clientName(NetworkRuleBypassOptions, "ContainerRegistryNetworkRuleBypassOption", "csharp");
@@clientName(NetworkRuleSet, "ContainerRegistryNetworkRuleSet", "csharp");
@@clientName(ParentProperties, "ConnectedRegistryParent", "csharp");
@@clientName(PasswordName, "ContainerRegistryPasswordName", "csharp");
@@clientName(Policies, "ContainerRegistryPolicies", "csharp");
@@clientName(PolicyStatus, "ContainerRegistryPolicyStatus", "csharp");
@@clientName(ProvisioningState, "ContainerRegistryProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "ContainerRegistryPublicNetworkAccess", "csharp");
@@clientName(QuarantinePolicy, "ContainerRegistryQuarantinePolicy", "csharp");
@@clientName(RegenerateCredentialParameters, "ContainerRegistryCredentialRegenerateContent", "csharp");
@@clientName(Registry, "ContainerRegistry", "csharp");
@@alternateType(Registry.identity, ManagedServiceIdentity, "csharp");
@@clientName(RegistryListCredentialsResult, "ContainerRegistryListCredentialsResult", "csharp");
@@clientName(RegistryListResult, "ContainerRegistryListResult", "csharp");
@@clientName(RegistryNameCheckRequest, "ContainerRegistryNameAvailabilityContent", "csharp");
@@clientName(RegistryNameStatus, "ContainerRegistryNameAvailableResult", "csharp");
@@clientName(RegistryNameStatus.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(RegistryPassword, "ContainerRegistryPassword", "csharp");
@@clientName(RegistryUpdateParameters, "ContainerRegistryPatch", "csharp");
@@clientName(RegistryUsage, "ContainerRegistryUsage", "csharp");
@@clientName(RegistryUsageListResult, "ContainerRegistryUsageListResult", "csharp");
@@clientName(RegistryUsageUnit, "ContainerRegistryUsageUnit", "csharp");
@@clientName(Replication, "ContainerRegistryReplication", "csharp");
@@clientName(ReplicationListResult, "ContainerRegistryReplicationListResult", "csharp");
@@clientName(Request, "ContainerRegistryWebhookEventRequestContent", "csharp");
@@clientName(RetentionPolicy, "ContainerRegistryRetentionPolicy", "csharp");
@@clientName(RoleAssignmentMode, "ContainerRegistryRoleAssignmentMode", "csharp");
@@clientName(Source, "ContainerRegistryWebhookEventSource", "csharp");
@@clientName(Status, "ContainerRegistryResourceStatus", "csharp");
@@clientName(StatusDetailProperties, "ConnectedRegistryStatusDetail", "csharp");
@@clientName(StatusDetailProperties.type, "StatusDetailType", "csharp");
@@clientName(SyncProperties, "ConnectedRegistrySyncProperties", "csharp");
@@clientName(SyncUpdateProperties, "ConnectedRegistrySyncUpdateProperties", "csharp");
@@clientName(Target, "ContainerRegistryWebhookEventTarget", "csharp");
@@clientName(TlsCertificateProperties, "ContainerRegistryTlsCertificateProperties", "csharp");
@@clientName(TlsCertificateProperties.location, "CertificateLocation", "csharp");
@@clientName(TlsProperties, "ContainerRegistryTlsProperties", "csharp");
@@clientName(TlsStatus, "ContainerRegistryTlsStatus", "csharp");
@@clientName(Token, "ContainerRegistryToken", "csharp");
@@clientName(TokenCertificate, "ContainerRegistryTokenCertificate", "csharp");
@@clientName(TokenCertificateName, "ContainerRegistryTokenCertificateName", "csharp");
@@clientName(TokenCredentialsProperties, "ContainerRegistryTokenCredentials", "csharp");
@@clientName(TokenListResult, "ContainerRegistryTokenListResult", "csharp");
@@clientName(TokenPassword, "ContainerRegistryTokenPassword", "csharp");
@@clientName(TokenPasswordName, "ContainerRegistryTokenPasswordName", "csharp");
@@clientName(TokenStatus, "ContainerRegistryTokenStatus", "csharp");
@@clientName(TokenUpdateParameters, "ContainerRegistryTokenPatch", "csharp");
@@clientName(TriggerStatus, "ContainerRegistryTriggerStatus", "csharp");
@@clientName(TrustPolicy, "ContainerRegistryTrustPolicy", "csharp");
@@clientName(TrustPolicyType, "ContainerRegistryTrustPolicyType", "csharp");
@@clientName(Webhook, "ContainerRegistryWebhook", "csharp");
@@clientName(WebhookAction, "ContainerRegistryWebhookAction", "csharp");
@@clientName(WebhookListResult, "ContainerRegistryWebhookListResult", "csharp");
@@clientName(WebhookStatus, "ContainerRegistryWebhookStatus", "csharp");
@@clientName(ZoneRedundancy, "ContainerRegistryZoneRedundancy", "csharp");

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectedRegistry.properties, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CacheRule.properties, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CredentialSet.properties, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Registry.properties, "csharp");

@@clientName(Registries.checkNameAvailability,
  "CheckContainerRegistryNameAvailability",
  "csharp"
);

/*
prepend-rp-prefix:
  - AgentPool
  - AgentPoolListResult
  - AgentPoolQueueStatus
  - AgentProperties
  - BaseImageDependency
  - BaseImageDependencyType
  - BaseImageTrigger
  - BaseImageTriggerType
  - Credentials
  - DockerBuildStep
  - EncodedTaskStep
  - FileTaskStep
  - ImageDescriptor
  - ImageUpdateTrigger
  - OverrideTaskStepProperties
  - PlatformProperties
  - Run
  - RunGetLogResult
  - RunListResult
  - RunStatus
  - RunType
  - SecretObject
  - SecretObjectType
  - SourceTrigger
  - SourceTriggerDescriptor
  - SourceTriggerEvent
  - Task
  - TaskListResult
  - TaskRun
  - TaskRunListResult
  - TaskStatus
  - TaskStepProperties
  - TimerTrigger
  - TimerTriggerDescriptor
  - TriggerProperties
  - UpdateTriggerPayloadType

rename-mapping:
    Architecture: ContainerRegistryOSArchitecture
    Argument: ContainerRegistryRunArgument
    AuthInfo: SourceCodeRepoAuthInfo
    AuthInfo.expiresIn: ExpireInSeconds
    AuthInfoUpdateParameters: SourceCodeRepoAuthInfoUpdateContent
    BaseImageTriggerUpdateParameters: ContainerRegistryBaseImageTriggerUpdateContent
    ConnectedRegistry.properties.clientTokenIds: -|arm-id
    ConnectedRegistryUpdateParameters.properties.clientTokenIds: -|arm-id
    DockerBuildRequest: ContainerRegistryDockerBuildContent
    DockerBuildRequest.timeout: TimeoutInSeconds
    DockerBuildStepUpdateParameters: ContainerRegistryDockerBuildStepUpdateContent
    EncodedTaskRunRequest: ContainerRegistryEncodedTaskRunContent
    EncodedTaskRunRequest.timeout: TimeoutInSeconds
    EncodedTaskStepUpdateParameters: ContainerRegistryEncodedTaskStepUpdateContent
    EventContent.id: -|uuid
    EventInfo.id: -|uuid
    FileTaskRunRequest: ContainerRegistryFileTaskRunContent
    FileTaskRunRequest.timeout: TimeoutInSeconds
    FileTaskStepUpdateParameters: ContainerRegistryFileTaskStepUpdateContent
    ImageUpdateTrigger.id: -|uuid
    OS: ContainerRegistryOS
    ParentProperties.id: -|arm-id
    PlatformUpdateParameters: ContainerRegistryPlatformUpdateContent
    Registry.properties.adminUserEnabled: IsAdminUserEnabled
    Registry.properties.anonymousPullEnabled: IsAnonymousPullEnabled
    Registry.properties.dataEndpointEnabled: IsDataEndpointEnabled
    Registry.properties.networkRuleBypassAllowedForTasks: IsNetworkRuleBypassAllowedForTasks
    RegistryUpdateParameters.properties.adminUserEnabled: IsAdminUserEnabled
    RegistryUpdateParameters.properties.anonymousPullEnabled: IsAnonymousPullEnabled
    RegistryUpdateParameters.properties.dataEndpointEnabled: IsDataEndpointEnabled
    RegistryUpdateParameters.properties.networkRuleBypassAllowedForTasks: IsNetworkRuleBypassAllowedForTasks
    Replication.properties.regionEndpointEnabled: IsRegionEndpointEnabled
    ReplicationUpdateParameters.properties.regionEndpointEnabled: IsRegionEndpointEnabled
    Request.id: -|uuid
    Run.properties.createTime: CreatedOn
    RunRequest: ContainerRegistryRunContent
    ScopeMap.properties.type: ScopeMapType
    SetValue: ContainerRegistryTaskOverridableValue
    SourceProperties: SourceCodeRepoProperties
    SourceTriggerDescriptor.id: -|uuid
    SourceTriggerUpdateParameters: ContainerRegistrySourceTriggerUpdateContent
    SourceUpdateParameters: SourceCodeRepoUpdateContent
    StatusDetailProperties.correlationId: -|uuid
    StepType: ContainerRegistryTaskStepType
    Task.properties.timeout: TimeoutInSeconds
    TaskRunRequest: ContainerRegistryTaskRunContent
    TaskStepProperties.type: ContainerRegistryTaskStepType
    TaskStepUpdateParameters: ContainerRegistryTaskStepUpdateContent
    TaskUpdateParameters.properties.timeout: TimeoutInSeconds
    TimerTriggerUpdateParameters: ContainerRegistryTimerTriggerUpdateContent
    TokenType: SourceCodeRepoAuthTokenType
    TriggerUpdateParameters: ContainerRegistryTriggerUpdateContent
    Variant: ContainerRegistryCpuVariant
*/
