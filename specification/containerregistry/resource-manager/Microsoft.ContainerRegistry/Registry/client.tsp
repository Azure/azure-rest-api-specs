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

// C# client naming: match legacy ModelFactory signatures
@@clientName(ProvisioningState, "ContainerRegistryProvisioningState", "csharp");
@@clientName(ConnectionState, "ConnectedRegistryConnectionState", "csharp");
@@clientName(ActivationStatus, "ConnectedRegistryActivationStatus", "csharp");
@@clientName(ParentProperties, "ConnectedRegistryParent", "csharp");
@@clientName(LoginServerProperties, "ConnectedRegistryLoginServer", "csharp");
@@clientName(LoggingProperties, "ConnectedRegistryLogging", "csharp");
@@clientName(StatusDetailProperties, "ConnectedRegistryStatusDetail", "csharp");
@@clientName(ImportSource, "ContainerRegistryImportSource", "csharp");
@@clientName(ImportSourceCredentials,
  "ContainerRegistryImportSourceCredentials",
  "csharp"
);

// C# ARM resource renames: preserve old "ContainerRegistry" prefix
@@clientName(Registry, "ContainerRegistry", "csharp");
@@clientName(CacheRule, "ContainerRegistryCacheRule", "csharp");
@@clientName(CredentialSet, "ContainerRegistryCredentialSet", "csharp");
@@clientName(Replication, "ContainerRegistryReplication", "csharp");
@@clientName(Token, "ContainerRegistryToken", "csharp");
@@clientName(Webhook, "ContainerRegistryWebhook", "csharp");
@@clientName(PrivateEndpointConnection,
  "ContainerRegistryPrivateEndpointConnection",
  "csharp"
);

// C# model renames: prepend RP prefix (from autorest prepend-rp-prefix)
@@clientName(AuthCredential, "ContainerRegistryAuthCredential", "csharp");
@@clientName(CertificateType, "ContainerRegistryCertificateType", "csharp");
@@clientName(CredentialHealth, "ContainerRegistryCredentialHealth", "csharp");
@@clientName(CredentialHealthStatus,
  "ContainerRegistryCredentialHealthStatus",
  "csharp"
);
@@clientName(CredentialName, "ContainerRegistryCredentialName", "csharp");
@@clientName(EncryptionStatus, "ContainerRegistryEncryptionStatus", "csharp");
@@clientName(ExportPolicyStatus, "ContainerRegistryExportPolicyStatus", "csharp");
@@clientName(IPRule, "ContainerRegistryIPRule", "csharp");
@@clientName(ImportMode, "ContainerRegistryImportMode", "csharp");
@@clientName(KeyVaultProperties, "ContainerRegistryKeyVaultProperties", "csharp");
@@clientName(NetworkRuleSet, "ContainerRegistryNetworkRuleSet", "csharp");
@@clientName(PasswordName, "ContainerRegistryPasswordName", "csharp");
@@clientName(Policies, "ContainerRegistryPolicies", "csharp");
@@clientName(PolicyStatus, "ContainerRegistryPolicyStatus", "csharp");
@@clientName(PublicNetworkAccess, "ContainerRegistryPublicNetworkAccess", "csharp");
@@clientName(RetentionPolicy, "ContainerRegistryRetentionPolicy", "csharp");
@@clientName(TlsCertificateProperties,
  "ContainerRegistryTlsCertificateProperties",
  "csharp"
);
@@clientName(TlsProperties, "ContainerRegistryTlsProperties", "csharp");
@@clientName(TlsStatus, "ContainerRegistryTlsStatus", "csharp");
@@clientName(TokenCertificate, "ContainerRegistryTokenCertificate", "csharp");
@@clientName(TokenCertificateName,
  "ContainerRegistryTokenCertificateName",
  "csharp"
);
@@clientName(TokenCredentialsProperties,
  "ContainerRegistryTokenCredentials",
  "csharp"
);
@@clientName(TokenPassword, "ContainerRegistryTokenPassword", "csharp");
@@clientName(TokenPasswordName, "ContainerRegistryTokenPasswordName", "csharp");
@@clientName(TokenStatus, "ContainerRegistryTokenStatus", "csharp");
@@clientName(TrustPolicy, "ContainerRegistryTrustPolicy", "csharp");
@@clientName(TrustPolicyType, "ContainerRegistryTrustPolicyType", "csharp");
@@clientName(WebhookAction, "ContainerRegistryWebhookAction", "csharp");
@@clientName(WebhookStatus, "ContainerRegistryWebhookStatus", "csharp");
@@clientName(ZoneRedundancy, "ContainerRegistryZoneRedundancy", "csharp");

// C# model renames: from autorest rename-mapping
@@clientName(Action, "ContainerRegistryIPRuleAction", "csharp");
@@clientName(EncryptionProperty, "ContainerRegistryEncryption", "csharp");
@@clientName(NetworkRuleBypassOptions,
  "ContainerRegistryNetworkRuleBypassOption",
  "csharp"
);
@@clientName(DefaultAction, "ContainerRegistryNetworkRuleDefaultAction", "csharp");
@@clientName(RoleAssignmentMode,
  "ContainerRegistryRoleAssignmentMode",
  "csharp"
);
@@clientName(ConnectionStatus,
  "ContainerRegistryPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(Status, "ContainerRegistryResourceStatus", "csharp");
@@clientName(RegistryUsage, "ContainerRegistryUsage", "csharp");
@@clientName(RegistryUsageUnit, "ContainerRegistryUsageUnit", "csharp");
@@clientName(RegistryUsageListResult,
  "ContainerRegistryUsageListResult",
  "csharp"
);
@@clientName(RegistryPassword, "ContainerRegistryPassword", "csharp");
@@clientName(RegistryListCredentialsResult,
  "ContainerRegistryListCredentialsResult",
  "csharp"
);
@@clientName(RegistryNameCheckRequest,
  "ContainerRegistryNameAvailabilityContent",
  "csharp"
);
@@clientName(RegistryNameStatus,
  "ContainerRegistryNameAvailableResult",
  "csharp"
);
@@clientName(RegistryUpdateParameters, "ContainerRegistryPatch", "csharp");
@@clientName(ImportImageParameters,
  "ContainerRegistryImportImageContent",
  "csharp"
);
@@clientName(RegenerateCredentialParameters,
  "ContainerRegistryCredentialRegenerateContent",
  "csharp"
);
@@clientName(GenerateCredentialsParameters,
  "ContainerRegistryGenerateCredentialsContent",
  "csharp"
);
@@clientName(GenerateCredentialsResult,
  "ContainerRegistryGenerateCredentialsResult",
  "csharp"
);

// C# webhook event model renames
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
@@clientName(CallbackConfig, "ContainerRegistryWebhookCallbackConfig", "csharp");
@@clientName(Source, "ContainerRegistryWebhookEventSource", "csharp");
@@clientName(Target, "ContainerRegistryWebhookEventTarget", "csharp");
@@clientName(Request, "ContainerRegistryWebhookEventRequestContent", "csharp");
@@clientName(WebhookCreateParameters,
  "ContainerRegistryWebhookCreateOrUpdateContent",
  "csharp"
);

// C# connected registry model renames
@@clientName(SyncProperties, "ConnectedRegistrySyncProperties", "csharp");
@@clientName(SyncUpdateProperties,
  "ConnectedRegistrySyncUpdateProperties",
  "csharp"
);
@@clientName(AuditLogStatus, "ConnectedRegistryAuditLogStatus", "csharp");
@@clientName(LogLevel, "ConnectedRegistryLogLevel", "csharp");

// C# other renames from autorest rename-mapping
@@clientName(AzureADAuthenticationAsArmPolicyStatus,
  "AadAuthenticationAsArmPolicyStatus",
  "csharp"
);
@@clientName(ActionsRequired,
  "ActionsRequiredForPrivateLinkServiceConsumer",
  "csharp"
);

// C# property renames
@@clientName(RegistryNameStatus.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(RegistryProperties.adminUserEnabled, "IsAdminUserEnabled", "csharp");
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
@@clientName(RegistryPropertiesUpdateParameters.adminUserEnabled, "IsAdminUserEnabled", "csharp");
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
@@clientName(ReplicationProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@clientName(ReplicationUpdateParametersProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@clientName(KeyVaultProperties.keyRotationEnabled,
  "IsKeyRotationEnabled",
  "csharp"
);
@@clientName(ScopeMapProperties.type, "ScopeMapType", "csharp");
@@clientName(StatusDetailProperties.type, "StatusDetailType", "csharp");
@@clientName(TlsCertificateProperties.location, "CertificateLocation", "csharp");
@@clientName(ConnectedRegistryProperties.clientTokenIds, "ClientTokenIds", "csharp");
@@clientName(ConnectedRegistryUpdateProperties.clientTokenIds, "ClientTokenIds", "csharp");

// C# type correctness: match API surface before migration to Typespec (Guid? CorrelationId)
@@alternateType(StatusDetailProperties.correlationId, uuid, "csharp");

// C# type correctness: ARM resource ID properties
@@alternateType(ConnectedRegistryProperties.clientTokenIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(ConnectedRegistryUpdateProperties.clientTokenIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(ParentProperties.id, armResourceIdentifier, "csharp");
@@alternateType(CacheRuleProperties.credentialSetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CacheRuleUpdateProperties.credentialSetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TokenProperties.scopeMapId, armResourceIdentifier, "csharp");
@@alternateType(TokenUpdateProperties.scopeMapId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SyncProperties.tokenId, armResourceIdentifier, "csharp");
@@alternateType(GenerateCredentialsParameters.tokenId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ImportSource.resourceId, armResourceIdentifier, "csharp");

// C# type correctness: Uri properties
@@alternateType(WebhookPropertiesCreateParameters.serviceUri, url, "csharp");
@@alternateType(WebhookPropertiesUpdateParameters.serviceUri, url, "csharp");
@@alternateType(CallbackConfig.serviceUri, url, "csharp");
@@alternateType(EventRequestMessage.requestUri, url, "csharp");
@@alternateType(Target.url, url, "csharp");

// C# type correctness: Guid properties
@@alternateType(EventContent.id, uuid, "csharp");
@@alternateType(EventInfo.id, uuid, "csharp");
@@alternateType(Request.id, uuid, "csharp");

// C# property renames: expiry -> ExpireOn
@@clientName(TokenCertificate.expiry, "ExpireOn", "csharp");
@@clientName(TokenPassword.expiry, "ExpireOn", "csharp");
@@clientName(GenerateCredentialsParameters.expiry, "ExpireOn", "csharp");

// C# property renames: disambiguation
@@clientName(TrustPolicy.type, "PolicyType", "csharp");
@@clientName(TlsCertificateProperties.type, "CertificateType", "csharp");
@@clientName(NetworkRuleSet.ipRules, "IPRules", "csharp");
@@clientName(Request.useragent, "UserAgent", "csharp");

// C# property renames: Source.instanceID -> InstanceId (match old casing)
@@clientName(Source.instanceID, "InstanceId", "csharp");

// C# property renames: PrivateEndpointConnection
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// C# type correctness: WebhookCreateOrUpdateContent.location -> AzureLocation
@@alternateType(WebhookCreateParameters.location, azureLocation, "csharp");

// C# operation rename: CheckNameAvailability -> CheckContainerRegistryNameAvailability
@@clientName(Registries.checkNameAvailability,
  "CheckContainerRegistryNameAvailability",
  "csharp"
);

// C# type correctness: PrivateEndpointId as armResourceIdentifier
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
