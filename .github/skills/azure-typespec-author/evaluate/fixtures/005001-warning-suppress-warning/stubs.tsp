import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

// Resource definitions for types referenced in models.tsp.
// Based on specification/cognitiveservices/CognitiveServices.Management.

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Account
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@parentResource(Account)
model Deployment is Azure.ResourceManager.ProxyResource<DeploymentProperties> {
  ...ResourceNameParameter<
    Resource = Deployment,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Account)
model CommitmentPlan
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CommitmentPlanProperties> {
  ...ResourceNameParameter<
    Resource = CommitmentPlan,
    KeyName = "commitmentPlanName",
    SegmentName = "commitmentPlans",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
}

@parentResource(CommitmentPlan)
model CommitmentPlanAccountAssociation
  is Azure.ResourceManager.ProxyResource<CommitmentPlanAccountAssociationProperties> {
  ...ResourceNameParameter<
    Resource = CommitmentPlanAccountAssociation,
    KeyName = "commitmentPlanAssociationName",
    SegmentName = "accountAssociations",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model EncryptionScope
  is Azure.ResourceManager.ProxyResource<EncryptionScopeProperties> {
  ...ResourceNameParameter<
    Resource = EncryptionScope,
    KeyName = "encryptionScopeName",
    SegmentName = "encryptionScopes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model RaiPolicy is Azure.ResourceManager.ProxyResource<RaiPolicyProperties> {
  ...ResourceNameParameter<
    Resource = RaiPolicy,
    KeyName = "raiPolicyName",
    SegmentName = "raiPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model RaiBlocklist
  is Azure.ResourceManager.ProxyResource<RaiBlocklistProperties> {
  ...ResourceNameParameter<
    Resource = RaiBlocklist,
    KeyName = "raiBlocklistName",
    SegmentName = "raiBlocklists",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(RaiBlocklist)
model RaiBlocklistItem
  is Azure.ResourceManager.ProxyResource<RaiBlocklistItemProperties> {
  ...ResourceNameParameter<
    Resource = RaiBlocklistItem,
    KeyName = "raiBlocklistItemName",
    SegmentName = "raiBlocklistItems",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model RaiTopic is Azure.ResourceManager.ProxyResource<RaiTopicProperties> {
  ...ResourceNameParameter<
    Resource = RaiTopic,
    KeyName = "raiTopicName",
    SegmentName = "raitopics",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model RaiToolLabel
  is Azure.ResourceManager.ProxyResource<RaiToolLabelProperties> {
  ...ResourceNameParameter<
    Resource = RaiToolLabel,
    KeyName = "raiToolConnectionName",
    SegmentName = "raiToolLabels",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tags?: Record<string>;
}

@subscriptionResource
@parentResource(SubscriptionLocationResource)
model RaiContentFilter
  is Azure.ResourceManager.ProxyResource<RaiContentFilterProperties> {
  ...ResourceNameParameter<
    Resource = RaiContentFilter,
    KeyName = "filterName",
    SegmentName = "raiContentFilters",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

@subscriptionResource
model RaiExternalSafetyProviderSchema
  is Azure.ResourceManager.ProxyResource<RaiExternalSafetyProviderSchemaProperties> {
  ...ResourceNameParameter<
    Resource = RaiExternalSafetyProviderSchema,
    KeyName = "safetyProviderName",
    SegmentName = "raiExternalSafetyProviders",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@parentResource(Account)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "nspConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = "^.*$"
  >;
}

@parentResource(Account)
model DefenderForAISetting
  is Azure.ResourceManager.ProxyResource<DefenderForAISettingProperties> {
  ...ResourceNameParameter<
    Resource = DefenderForAISetting,
    KeyName = "defenderForAISettingName",
    SegmentName = "defenderForAISettings",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@parentResource(Account)
model ConnectionPropertiesV2BasicResource
  is Azure.ResourceManager.ProxyResource<ConnectionPropertiesV2, false> {
  ...ResourceNameParameter<
    Resource = ConnectionPropertiesV2BasicResource,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@parentResource(Account)
model CapabilityHost
  is Azure.ResourceManager.ProxyResource<CapabilityHostProperties, false> {
  ...ResourceNameParameter<
    Resource = CapabilityHost,
    KeyName = "capabilityHostName",
    SegmentName = "capabilityHosts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@parentResource(Project)
model ProjectCapabilityHost
  is Azure.ResourceManager.ProxyResource<
    ProjectCapabilityHostProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ProjectCapabilityHost,
    KeyName = "capabilityHostName",
    SegmentName = "capabilityHosts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Account)
model Project
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ProjectProperties> {
  ...ResourceNameParameter<
    Resource = Project,
    KeyName = "projectName",
    SegmentName = "projects",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@subscriptionResource
model QuotaTier is Azure.ResourceManager.ProxyResource<QuotaTierProperties> {
  ...ResourceNameParameter<
    Resource = QuotaTier,
    KeyName = "default",
    SegmentName = "quotaTiers",
    NamePattern = ""
  >;
}

@parentResource(Project)
model AgentApplication
  is Azure.ResourceManager.ProxyResource<AgenticApplicationProperties, false> {
  ...ResourceNameParameter<
    Resource = AgentApplication,
    KeyName = "name",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

@parentResource(Project)
model AgentDeployment
  is Azure.ResourceManager.ProxyResource<AgentDeploymentProperties, false> {
  ...ResourceNameParameter<
    Resource = AgentDeployment,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;
}

@parentResource(ManagedNetworkSettingsPropertiesBasicResource)
model OutboundRuleBasicResource
  is Azure.ResourceManager.ProxyResource<OutboundRule, false> {
  ...ResourceNameParameter<
    Resource = OutboundRuleBasicResource,
    KeyName = "ruleName",
    SegmentName = "outboundRules",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@parentResource(Account)
model ManagedNetworkSettingsPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<ManagedNetworkSettingsProperties> {
  ...ResourceNameParameter<
    Resource = ManagedNetworkSettingsPropertiesBasicResource,
    KeyName = "managedNetworkName",
    SegmentName = "managedNetworks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@parentResource(Account)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}
