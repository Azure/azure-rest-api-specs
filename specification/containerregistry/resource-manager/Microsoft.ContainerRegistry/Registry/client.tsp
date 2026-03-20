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

@@clientName(IPRule.value, "$DO_NOT_NORMALIZE$iPAddressOrRange", "javascript");

// C# configurations for backward compatibility and naming conventions
namespace Microsoft.ContainerRegistry {
  /** Extensible union for ContainerRegistryResourceType to maintain backward compatibility. */
  union ContainerRegistryResourceTypeExtensible {
    ContainerRegistryResourceType,
    string,
  }
}
@@access(ContainerRegistryResourceType, Access.internal, "csharp");
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
@@alternateType(ExportPipeline.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(GenerateCredentialsParameters.tokenId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImportPipeline.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ImportSource.registryUri, url, "csharp");
@@alternateType(ImportSource.resourceId, armResourceIdentifier, "csharp");
@@alternateType(CallbackConfig.serviceUri, url, "csharp");
@@alternateType(EventRequestMessage.requestUri, url, "csharp");
@@alternateType(ParentProperties.id, armResourceIdentifier, "csharp");
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
@@clientName(ConnectionState, "ConnectedRegistryConnectionState", "csharp");
@@clientName(ConnectionStatus,
  "ContainerRegistryPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(ConnectedRegistryProperties.clientTokenIds,
  "ClientTokenIds",
  "csharp"
);
@@clientName(ConnectedRegistryUpdateProperties.clientTokenIds,
  "ClientTokenIds",
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
@@clientName(LoggingProperties, "ConnectedRegistryLogging", "csharp");
@@clientName(LogLevel, "ConnectedRegistryLogLevel", "csharp");
@@clientName(LoginServerProperties, "ConnectedRegistryLoginServer", "csharp");
@@clientName(Microsoft.ContainerRegistry.ContainerRegistryResourceTypeExtensible,
  "ContainerRegistryResourceType",
  "csharp"
);
@@clientName(Microsoft.ContainerRegistry.PrivateLinkResource.name,
  "groupName",
  "csharp"
);
@@clientName(NetworkRuleBypassOptions,
  "ContainerRegistryNetworkRuleBypassOption",
  "csharp"
);
@@clientName(NetworkRuleSet, "ContainerRegistryNetworkRuleSet", "csharp");
@@clientName(NetworkRuleSet.ipRules, "IPRules", "csharp");
@@clientName(ParentProperties, "ConnectedRegistryParent", "csharp");
@@clientName(PasswordName, "ContainerRegistryPasswordName", "csharp");
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
@@clientName(PrivateLinkResource,
  "ContainerRegistryPrivateLinkResource",
  "csharp"
);
@@clientName(ContainerRegistryResourceType,
  "ContainerRegistryResourceTypeValue",
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
@@clientName(Source, "ContainerRegistryWebhookEventSource", "csharp");
@@clientName(Source.instanceID, "InstanceId", "csharp");
@@clientName(Status, "ContainerRegistryResourceStatus", "csharp");
@@clientName(StatusDetailProperties, "ConnectedRegistryStatusDetail", "csharp");
@@clientName(StatusDetailProperties.type, "StatusDetailType", "csharp");
@@clientName(SyncProperties, "ConnectedRegistrySyncProperties", "csharp");
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
@@usage(WebhookProperties, Usage.input, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Registries.listUsages,
  "csharp"
);
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties,
  "csharp"
);
