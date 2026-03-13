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
@@clientName(ImportSource.registryUri, "RegistryAddress", "csharp");

// C# type correctness: match API surface before migration to Typespec (Guid? CorrelationId)
@@alternateType(StatusDetailProperties.correlationId, uuid, "csharp");
// C# type correctness: match API surface before migration to Typespec (ResourceIdentifier resourceId)
@@alternateType(ImportSource.resourceId, armResourceIdentifier, "csharp");

// C# client naming: restore ContainerRegistry prefix for backward compatibility with v1.x API surface

// Registry models
@@clientName(IPRule, "ContainerRegistryIPRule", "csharp");
@@clientName(ImportImageParameters,
  "ContainerRegistryImportImageContent",
  "csharp"
);
@@clientName(ImportMode, "ContainerRegistryImportMode", "csharp");
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
@@clientName(RegistryListCredentialsResult,
  "ContainerRegistryListCredentialsResult",
  "csharp"
);
@@clientName(RegistryPassword, "ContainerRegistryPassword", "csharp");
@@clientName(RegistryNameCheckRequest,
  "ContainerRegistryNameAvailabilityContent",
  "csharp"
);
@@clientName(RegistryNameStatus,
  "ContainerRegistryNameAvailableResult",
  "csharp"
);
@@clientName(RegistryUpdateParameters, "ContainerRegistryPatch", "csharp");
@@clientName(RegistryUsage, "ContainerRegistryUsage", "csharp");
@@clientName(RegistryUsageUnit, "ContainerRegistryUsageUnit", "csharp");
@@clientName(NetworkRuleSet, "ContainerRegistryNetworkRuleSet", "csharp");
@@clientName(NetworkRuleBypassOptions,
  "ContainerRegistryNetworkRuleBypassOption",
  "csharp"
);
@@clientName(Policies, "ContainerRegistryPolicies", "csharp");
@@clientName(PolicyStatus, "ContainerRegistryPolicyStatus", "csharp");
@@clientName(RetentionPolicy, "ContainerRegistryRetentionPolicy", "csharp");
@@clientName(TrustPolicy, "ContainerRegistryTrustPolicy", "csharp");
@@clientName(TrustPolicyType, "ContainerRegistryTrustPolicyType", "csharp");
@@clientName(ExportPolicyStatus,
  "ContainerRegistryExportPolicyStatus",
  "csharp"
);
@@clientName(EncryptionProperty, "ContainerRegistryEncryption", "csharp");
@@clientName(EncryptionStatus, "ContainerRegistryEncryptionStatus", "csharp");
@@clientName(KeyVaultProperties,
  "ContainerRegistryKeyVaultProperties",
  "csharp"
);
@@clientName(PublicNetworkAccess,
  "ContainerRegistryPublicNetworkAccess",
  "csharp"
);
@@clientName(RoleAssignmentMode,
  "ContainerRegistryRoleAssignmentMode",
  "csharp"
);
@@clientName(Status, "ContainerRegistryResourceStatus", "csharp");
@@clientName(DefaultAction,
  "ContainerRegistryNetworkRuleDefaultAction",
  "csharp"
);
@@clientName(Action, "ContainerRegistryIPRuleAction", "csharp");

// Replication models
@@clientName(ReplicationUpdateParameters,
  "ContainerRegistryReplicationPatch",
  "csharp"
);

// Token models
@@clientName(TokenUpdateParameters, "ContainerRegistryTokenPatch", "csharp");
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

// CacheRule models
@@clientName(CacheRuleUpdateParameters,
  "ContainerRegistryCacheRulePatch",
  "csharp"
);

// CredentialSet models
@@clientName(CredentialSetUpdateParameters,
  "ContainerRegistryCredentialSetPatch",
  "csharp"
);
@@clientName(AuthCredential, "ContainerRegistryAuthCredential", "csharp");
@@clientName(CredentialHealth, "ContainerRegistryCredentialHealth", "csharp");
@@clientName(CredentialHealthStatus,
  "ContainerRegistryCredentialHealthStatus",
  "csharp"
);
@@clientName(CredentialName, "ContainerRegistryCredentialName", "csharp");

// Webhook models
@@clientName(WebhookCreateParameters,
  "ContainerRegistryWebhookCreateOrUpdateContent",
  "csharp"
);
@@clientName(WebhookUpdateParameters,
  "ContainerRegistryWebhookPatch",
  "csharp"
);
@@clientName(WebhookAction, "ContainerRegistryWebhookAction", "csharp");
@@clientName(WebhookStatus, "ContainerRegistryWebhookStatus", "csharp");
@@clientName(CallbackConfig,
  "ContainerRegistryWebhookCallbackConfig",
  "csharp"
);
@@clientName(EventInfo, "ContainerRegistryWebhookEventInfo", "csharp");
@@clientName(Event, "ContainerRegistryWebhookEvent", "csharp");
@@clientName(EventContent, "ContainerRegistryWebhookEventContent", "csharp");
@@clientName(EventRequestMessage,
  "ContainerRegistryWebhookEventRequestMessage",
  "csharp"
);
@@clientName(EventResponseMessage,
  "ContainerRegistryWebhookEventResponseMessage",
  "csharp"
);
@@clientName(Request, "ContainerRegistryWebhookEventRequestContent", "csharp");
@@clientName(Source, "ContainerRegistryWebhookEventSource", "csharp");
@@clientName(Target, "ContainerRegistryWebhookEventTarget", "csharp");

// ConnectedRegistry models
@@clientName(SyncProperties, "ConnectedRegistrySyncProperties", "csharp");
@@clientName(SyncUpdateProperties,
  "ConnectedRegistrySyncUpdateProperties",
  "csharp"
);
@@clientName(AuditLogStatus, "ConnectedRegistryAuditLogStatus", "csharp");
@@clientName(CertificateType, "ContainerRegistryCertificateType", "csharp");
@@clientName(LogLevel, "ConnectedRegistryLogLevel", "csharp");
@@clientName(TlsCertificateProperties,
  "ContainerRegistryTlsCertificateProperties",
  "csharp"
);
@@clientName(TlsProperties, "ContainerRegistryTlsProperties", "csharp");
@@clientName(TlsStatus, "ContainerRegistryTlsStatus", "csharp");
@@clientName(TriggerStatus, "ContainerRegistryTriggerStatus", "csharp");

// PrivateEndpointConnection models
@@clientName(ConnectionStatus,
  "ContainerRegistryPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(ActionsRequired,
  "ActionsRequiredForPrivateLinkServiceConsumer",
  "csharp"
);

// Miscellaneous renames
@@clientName(PasswordName, "ContainerRegistryPasswordName", "csharp");
@@clientName(ZoneRedundancy, "ContainerRegistryZoneRedundancy", "csharp");
@@clientName(AzureADAuthenticationAsArmPolicyStatus,
  "AadAuthenticationAsArmPolicyStatus",
  "csharp"
);
