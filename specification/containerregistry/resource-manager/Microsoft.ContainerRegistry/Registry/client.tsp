import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryManagementClient",
  "javascript,python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "java,python"
);

@@clientName(IPRule, "IpRule", "java");
@@clientName(IPRule.value, "ipAddressOrRange", "java");
@@clientName(Source.instanceID, "instanceId", "java");

@@alternateType(RegistryNameCheckRequest.type,
  "Microsoft.ContainerRegistry/registries",
  "java,go"
);

@@usage(Webhook, Usage.input | Usage.output, "java");

@@clientName(MyPrivateLinkResource, "PrivateLinkResource", "java");

@@clientName(IPRule.value, "$DO_NOT_NORMALIZE$iPAddressOrRange", "javascript");

// C# configurations for backward compatibility and naming conventions.
// These settings restore the public API surface of the previous autorest-based SDK to avoid breaking changes.

// ContainerRegistryResourceTypeExtensible is a custom extensible union wrapping the original enum,
// allowing the RegistryNameCheckRequest.type property to accept both known enum values and arbitrary strings,
// which matches the behavior of the previous SDK where the type was represented as a plain string.
namespace Microsoft.ContainerRegistry {
  /** Extensible union for ContainerRegistryResourceType to accept both known enum values and arbitrary strings. */
  union ContainerRegistryResourceTypeExtensible {
    ContainerRegistryResourceType,
    string,
  }
}
// Hide the original enum from the public surface; clients should use ContainerRegistryResourceTypeExtensible instead.
@@access(ContainerRegistryResourceType, Access.internal, "csharp");

@@alternateType(ArchivePackageSourceProperties.url, url, "csharp");
@@alternateType(CacheRule.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(CacheRuleProperties.credentialSetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CacheRuleUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(CacheRuleUpdateProperties.credentialSetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CallbackConfig.serviceUri, url, "csharp");
@@alternateType(ConnectedRegistryProperties.clientTokenIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(ConnectedRegistryUpdateProperties.clientTokenIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(CredentialSet.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(CredentialSetUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(EventContent.id, uuid, "csharp");
@@alternateType(EventInfo.id, uuid, "csharp");
@@alternateType(EventRequestMessage.requestUri, url, "csharp");
@@alternateType(ExportPipeline.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ExportPipeline.location, azureLocation, "csharp");
@@alternateType(ExportPipelineTargetProperties.keyVaultUri, url, "csharp");
@@alternateType(ExportPipelineTargetProperties.uri, url, "csharp");
@@alternateType(GenerateCredentialsParameters.tokenId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImportPipeline.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ImportPipeline.location, azureLocation, "csharp");
@@alternateType(ImportPipelineSourceProperties.keyVaultUri, url, "csharp");
@@alternateType(ImportPipelineSourceProperties.uri, url, "csharp");
@@alternateType(ImportSource.registryUri, url, "csharp");
@@alternateType(ImportSource.resourceId, armResourceIdentifier, "csharp");
@@alternateType(ParentProperties.id, armResourceIdentifier, "csharp");
@@alternateType(PipelineRunRequest.pipelineResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(Registry.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(RegistryNameCheckRequest.type,
  Microsoft.ContainerRegistry.ContainerRegistryResourceTypeExtensible,
  "csharp"
);
@@alternateType(RegistryUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Request.id, uuid, "csharp");
@@alternateType(StatusDetailProperties.correlationId, uuid, "csharp");
@@alternateType(SyncProperties.tokenId, armResourceIdentifier, "csharp");
@@alternateType(Target.url, url, "csharp");
@@alternateType(TokenProperties.scopeMapId, armResourceIdentifier, "csharp");
@@alternateType(TokenUpdateProperties.scopeMapId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(WebhookCreateParameters.location, azureLocation, "csharp");
@@alternateType(WebhookPropertiesCreateParameters.serviceUri, url, "csharp");
@@alternateType(WebhookPropertiesUpdateParameters.serviceUri, url, "csharp");

@@clientName(Action, "ContainerRegistryIPRuleAction", "csharp");
@@clientName(ActivationStatus, "ConnectedRegistryActivationStatus", "csharp");
@@clientName(ActionsRequired,
  "ActionsRequiredForPrivateLinkServiceConsumer",
  "csharp"
);
@@clientName(Archive, "ContainerRegistryArchive", "csharp");
@@clientName(ArchivePackageSourceProperties,
  "ContainerRegistryArchivePackageSourceProperties",
  "csharp"
);
@@clientName(ArchivePackageSourceProperties.type, "SourceType", "csharp");
@@clientName(ArchivePackageSourceProperties.url, "Uri", "csharp");
@@clientName(ArchiveVersion, "ContainerRegistryArchiveVersion", "csharp");
@@clientName(AuditLogStatus, "ConnectedRegistryAuditLogStatus", "csharp");
@@clientName(AuthCredential, "ContainerRegistryAuthCredential", "csharp");
@@clientName(AzureADAuthenticationAsArmPolicyStatus,
  "AadAuthenticationAsArmPolicyStatus",
  "csharp"
);
@@clientName(CacheRule, "ContainerRegistryCacheRule", "csharp");
@@clientName(CallbackConfig,
  "ContainerRegistryWebhookCallbackConfig",
  "csharp"
);
@@clientName(CertificateType, "ContainerRegistryCertificateType", "csharp");
@@clientName(ConnectedRegistryMode, "ConnectedRegistryMode", "csharp");
@@clientName(ConnectedRegistryProperties.clientTokenIds,
  "ClientTokenIds",
  "csharp"
);
@@clientName(ConnectedRegistryProperties.mode, "Mode", "csharp");
@@clientName(ConnectedRegistryUpdateProperties.clientTokenIds,
  "ClientTokenIds",
  "csharp"
);
@@clientName(ConnectionState, "ConnectedRegistryConnectionState", "csharp");
@@clientName(ConnectionStatus,
  "ContainerRegistryPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(ContainerRegistryResourceType,
  "ContainerRegistryResourceTypeValue",
  "csharp"
);
@@clientName(CredentialHealth, "ContainerRegistryCredentialHealth", "csharp");
@@clientName(CredentialHealthStatus,
  "ContainerRegistryCredentialHealthStatus",
  "csharp"
);
@@clientName(CredentialName, "ContainerRegistryCredentialName", "csharp");
@@clientName(CredentialSet, "ContainerRegistryCredentialSet", "csharp");
@@clientName(DefaultAction,
  "ContainerRegistryNetworkRuleDefaultAction",
  "csharp"
);
@@clientName(EncryptionProperty, "ContainerRegistryEncryption", "csharp");
@@clientName(EncryptionStatus, "ContainerRegistryEncryptionStatus", "csharp");
@@clientName(EndpointProtocol, "ContainerRegistryEndpointProtocol", "csharp");
@@clientName(Event, "ContainerRegistryWebhookEvent", "csharp");
@@clientName(EventContent, "ContainerRegistryWebhookEventContent", "csharp");
@@clientName(EventInfo, "ContainerRegistryWebhookEventInfo", "csharp");
@@clientName(EventRequestMessage,
  "ContainerRegistryWebhookEventRequestMessage",
  "csharp"
);
@@clientName(EventResponseMessage,
  "ContainerRegistryWebhookEventResponseMessage",
  "csharp"
);
@@clientName(ExportPipeline, "ContainerRegistryExportPipeline", "csharp");
@@clientName(ExportPipelineTargetProperties,
  "ContainerRegistryExportPipelineTargetProperties",
  "csharp"
);
@@clientName(ExportPipelineTargetProperties.keyVaultUri,
  "KeyVaultUri",
  "csharp"
);
@@clientName(ExportPipelineTargetProperties.type,
  "ExportPipelineTargetPropertiesType",
  "csharp"
);
@@clientName(ExportPipelineTargetProperties.uri, "Uri", "csharp");
@@clientName(ExportPolicyStatus,
  "ContainerRegistryExportPolicyStatus",
  "csharp"
);
@@clientName(GenerateCredentialsParameters,
  "ContainerRegistryGenerateCredentialsContent",
  "csharp"
);
@@clientName(GenerateCredentialsParameters.expiry, "ExpireOn", "csharp");
@@clientName(GenerateCredentialsResult,
  "ContainerRegistryGenerateCredentialsResult",
  "csharp"
);
@@clientName(IPRule, "ContainerRegistryIPRule", "csharp");
@@clientName(ImportImageParameters,
  "ContainerRegistryImportImageContent",
  "csharp"
);
@@clientName(ImportMode, "ContainerRegistryImportMode", "csharp");
@@clientName(ImportPipeline, "ContainerRegistryImportPipeline", "csharp");
@@clientName(ImportPipelineSourceProperties,
  "ContainerRegistryImportPipelineSourceProperties",
  "csharp"
);
@@clientName(ImportPipelineSourceProperties.keyVaultUri,
  "KeyVaultUri",
  "csharp"
);
@@clientName(ImportPipelineSourceProperties.type, "SourceType", "csharp");
@@clientName(ImportPipelineSourceProperties.uri, "Uri", "csharp");
@@clientName(ImportSource, "ContainerRegistryImportSource", "csharp");
@@clientName(ImportSourceCredentials,
  "ContainerRegistryImportSourceCredentials",
  "csharp"
);
@@clientName(KeyVaultProperties,
  "ContainerRegistryKeyVaultProperties",
  "csharp"
);
@@clientName(KeyVaultProperties.keyRotationEnabled,
  "IsKeyRotationEnabled",
  "csharp"
);
@@clientName(LogLevel, "ConnectedRegistryLogLevel", "csharp");
@@clientName(LoggingProperties, "ConnectedRegistryLogging", "csharp");
@@clientName(LoginServerProperties, "ConnectedRegistryLoginServer", "csharp");
@@clientName(MetadataSearch, "ContainerRegistryMetadataSearch", "csharp");
@@clientName(Microsoft.ContainerRegistry.ContainerRegistryResourceTypeExtensible,
  "ContainerRegistryResourceType",
  "csharp"
);
@@clientName(NetworkRuleBypassOptions,
  "ContainerRegistryNetworkRuleBypassOption",
  "csharp"
);
@@clientName(NetworkRuleSet, "ContainerRegistryNetworkRuleSet", "csharp");
@@clientName(NetworkRuleSet.ipRules, "IPRules", "csharp");
@@clientName(PackageSourceType, "ContainerRegistryPackageSourceType", "csharp");
@@clientName(ParentProperties, "ConnectedRegistryParent", "csharp");
@@clientName(PasswordName, "ContainerRegistryPasswordName", "csharp");
@@clientName(PipelineOptions, "PipelineOption", "csharp");
@@clientName(PipelineRun, "ContainerRegistryPipelineRun", "csharp");
@@clientName(PipelineRunRequest,
  "ContainerRegistryPipelineRunContent",
  "csharp"
);
@@clientName(PipelineRunRequest.pipelineResourceId,
  "PipelineResourceId",
  "csharp"
);
@@clientName(PipelineRunResponse,
  "ContainerRegistryPipelineRunResult",
  "csharp"
);
@@clientName(PipelineRunResponse.importedArtifacts,
  "ImportedArtifacts",
  "csharp"
);
@@clientName(PipelineRunSourceProperties,
  "ContainerRegistryPipelineRunSourceProperties",
  "csharp"
);
@@clientName(PipelineRunSourceProperties.type, "SourceType", "csharp");
@@clientName(PipelineRunSourceType,
  "ContainerRegistryPipelineRunSourceType",
  "csharp"
);
@@clientName(PipelineRunTargetProperties,
  "ContainerRegistryPipelineRunTargetProperties",
  "csharp"
);
@@clientName(PipelineRunTargetProperties.type, "TargetType", "csharp");
@@clientName(PipelineRunTargetType,
  "ContainerRegistryPipelineRunTargetType",
  "csharp"
);
@@clientName(PipelineSourceTriggerDescriptor.timestamp,
  "SourceTriggerTimestamp",
  "csharp"
);
@@clientName(PipelineSourceTriggerProperties.status, "Status", "csharp");
@@clientName(PipelineTriggerDescriptor.sourceTrigger, "Source", "csharp");
@@clientName(PipelineSourceType,
  "ContainerRegistryPipelineSourceType",
  "csharp"
);
@@clientName(Policies, "ContainerRegistryPolicies", "csharp");
@@clientName(PolicyStatus, "ContainerRegistryPolicyStatus", "csharp");
@@clientName(PrivateEndpointConnection,
  "ContainerRegistryPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(MyPrivateLinkResource,
  "ContainerRegistryPrivateLinkResource",
  "csharp"
);
@@clientName(ProvisioningState, "ContainerRegistryProvisioningState", "csharp");
@@clientName(PublicNetworkAccess,
  "ContainerRegistryPublicNetworkAccess",
  "csharp"
);
@@clientName(RegenerateCredentialParameters,
  "ContainerRegistryCredentialRegenerateContent",
  "csharp"
);
@@clientName(RegionalEndpoints, "RegionalEndpoint", "csharp");
@@clientName(Registries.checkNameAvailability,
  "CheckContainerRegistryNameAvailability",
  "csharp"
);
@@clientName(Registry, "ContainerRegistry", "csharp");
@@clientName(RegistryListCredentialsResult,
  "ContainerRegistryListCredentialsResult",
  "csharp"
);
@@clientName(RegistryNameCheckRequest,
  "ContainerRegistryNameAvailabilityContent",
  "csharp"
);
@@clientName(RegistryNameCheckRequest.type, "ResourceType", "csharp");
@@clientName(RegistryNameStatus,
  "ContainerRegistryNameAvailableResult",
  "csharp"
);
@@clientName(RegistryNameStatus.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(RegistryPassword, "ContainerRegistryPassword", "csharp");
@@clientName(RegistryProperties.adminUserEnabled,
  "IsAdminUserEnabled",
  "csharp"
);
@@clientName(RegistryProperties.anonymousPullEnabled,
  "IsAnonymousPullEnabled",
  "csharp"
);
@@clientName(RegistryProperties.dataEndpointEnabled,
  "IsDataEndpointEnabled",
  "csharp"
);
@@clientName(RegistryProperties.networkRuleBypassAllowedForTasks,
  "IsNetworkRuleBypassAllowedForTasks",
  "csharp"
);
@@clientName(RegistryPropertiesUpdateParameters.adminUserEnabled,
  "IsAdminUserEnabled",
  "csharp"
);
@@clientName(RegistryPropertiesUpdateParameters.anonymousPullEnabled,
  "IsAnonymousPullEnabled",
  "csharp"
);
@@clientName(RegistryPropertiesUpdateParameters.dataEndpointEnabled,
  "IsDataEndpointEnabled",
  "csharp"
);
@@clientName(RegistryPropertiesUpdateParameters.networkRuleBypassAllowedForTasks,
  "IsNetworkRuleBypassAllowedForTasks",
  "csharp"
);
@@clientName(RegistrySyncResult, "ContainerRegistrySyncResult", "csharp");
@@clientName(RegistryUpdateParameters, "ContainerRegistryPatch", "csharp");
@@clientName(RegistryUsage, "ContainerRegistryUsage", "csharp");
@@clientName(RegistryUsageListResult,
  "ContainerRegistryUsageListResult",
  "csharp"
);
@@clientName(RegistryUsageUnit, "ContainerRegistryUsageUnit", "csharp");
@@clientName(Replication, "ContainerRegistryReplication", "csharp");
@@clientName(ReplicationProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@clientName(ReplicationUpdateParametersProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@clientName(Request, "ContainerRegistryWebhookEventRequestContent", "csharp");
@@clientName(Request.useragent, "UserAgent", "csharp");
@@clientName(RetentionPolicy, "ContainerRegistryRetentionPolicy", "csharp");
@@clientName(RoleAssignmentMode,
  "ContainerRegistryRoleAssignmentMode",
  "csharp"
);
@@clientName(ScopeMapProperties.type, "ScopeMapType", "csharp");
@@clientName(SoftDeletePolicy, "ContainerRegistrySoftDeletePolicy", "csharp");
@@clientName(Source, "ContainerRegistryWebhookEventSource", "csharp");
@@clientName(Source.instanceID, "InstanceId", "csharp");
@@clientName(Status, "ContainerRegistryResourceStatus", "csharp");
@@clientName(StatusDetailProperties, "ConnectedRegistryStatusDetail", "csharp");
@@clientName(StatusDetailProperties.type, "StatusDetailType", "csharp");
@@clientName(StorageAccessMode, "ContainerRegistryStorageAccessMode", "csharp");
@@clientName(SyncProperties, "ConnectedRegistrySyncProperties", "csharp");
@@clientName(SyncState, "ContainerRegistrySyncState", "csharp");
@@clientName(SyncTrigger, "ContainerRegistrySyncTrigger", "csharp");
@@clientName(SyncUpdateProperties,
  "ConnectedRegistrySyncUpdateProperties",
  "csharp"
);
@@clientName(Target, "ContainerRegistryWebhookEventTarget", "csharp");
@@clientName(TlsCertificateProperties,
  "ContainerRegistryTlsCertificateProperties",
  "csharp"
);
@@clientName(TlsCertificateProperties.location,
  "CertificateLocation",
  "csharp"
);
@@clientName(TlsCertificateProperties.type, "CertificateType", "csharp");
@@clientName(TlsProperties, "ContainerRegistryTlsProperties", "csharp");
@@clientName(TlsStatus, "ContainerRegistryTlsStatus", "csharp");
@@clientName(Token, "ContainerRegistryToken", "csharp");
@@clientName(TokenCertificate, "ContainerRegistryTokenCertificate", "csharp");
@@clientName(TokenCertificate.expiry, "ExpireOn", "csharp");
@@clientName(TokenCertificateName,
  "ContainerRegistryTokenCertificateName",
  "csharp"
);
@@clientName(TokenCredentialsProperties,
  "ContainerRegistryTokenCredentials",
  "csharp"
);
@@clientName(TokenPassword, "ContainerRegistryTokenPassword", "csharp");
@@clientName(TokenPassword.expiry, "ExpireOn", "csharp");
@@clientName(TokenPasswordName, "ContainerRegistryTokenPasswordName", "csharp");
@@clientName(TokenStatus, "ContainerRegistryTokenStatus", "csharp");
@@clientName(TriggerStatus, "ContainerRegistryTriggerStatus", "csharp");
@@clientName(TrustPolicy, "ContainerRegistryTrustPolicy", "csharp");
@@clientName(TrustPolicy.type, "PolicyType", "csharp");
@@clientName(TrustPolicyType, "ContainerRegistryTrustPolicyType", "csharp");
@@clientName(Webhook, "ContainerRegistryWebhook", "csharp");
@@clientName(WebhookAction, "ContainerRegistryWebhookAction", "csharp");
@@clientName(WebhookCreateParameters,
  "ContainerRegistryWebhookCreateOrUpdateContent",
  "csharp"
);
@@clientName(WebhookStatus, "ContainerRegistryWebhookStatus", "csharp");
@@clientName(ZoneRedundancy, "ContainerRegistryZoneRedundancy", "csharp");

// ArchiveVersion and WebhookProperties are used only as output in the TypeSpec model but were
// also writable in the previous SDK; mark them as input to preserve the existing usage pattern.
@@usage(ArchiveVersion, Usage.input, "csharp");
@@usage(WebhookProperties, Usage.input, "csharp");
@@usage(Webhook, Usage.input, "csharp");

// flattenProperty restores the flat property layout produced by the previous autorest-based SDK,
// where resource properties were exposed directly on the resource class rather than through a nested object.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Archive.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArchiveVersion.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CacheRule.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectedRegistry.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CredentialSet.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExportPipeline.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImportPipeline.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PipelineRun.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Registry.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Replication.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScopeMap.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Token.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Webhook.properties,
  "csharp"
);
// markAsPageable restores the pageable return type for listUsages, matching the previous SDK behavior
// where the result was surfaced as a pageable collection rather than a single response.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Registries.listUsages,
  "csharp"
);
