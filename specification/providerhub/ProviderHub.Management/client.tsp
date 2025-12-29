import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

@@clientName(Microsoft.ProviderHub, "ProviderHubMgmtClient", "python");

@@clientLocation(ProviderRegistrations.checkinManifest, "Client", "go");
@@clientLocation(ProviderRegistrations.generateManifest, "Client", "go");
@@clientName(SkuCapacity, "SKUSettingCapacity", "go");
@@clientName(ResourceTypeSku, "SKUResourceProperties", "go");
@@clientName(IdentityManagementProperties, "ResourceTypeRegistrationPropertiesIdentityManagement", "go");
@@clientName(ResourceTypeRegistrationProperties, "ResourceTypeRegistrationProperties", "go");
@@clientName(ResourceMovePolicy, "ResourceTypeRegistrationPropertiesResourceMovePolicy", "go");
@@clientName(ResourceGraphConfiguration, "ResourceTypeRegistrationPropertiesResourceGraphConfiguration", "go");
@@clientName(OperationsContentProperties, "OperationsPutContentProperties", "go");
@@clientName(ThirdPartyProviderAuthorization, "MetadataThirdPartyProviderAuthorization", "go");
@@clientName(PrivateResourceProviderConfiguration, "ProviderRegistrationPropertiesPrivateResourceProviderConfiguration", "go");
@@clientName(LoggingHiddenPropertyPath, "LoggingRuleHiddenPropertyPaths", "go");
@@clientName(ManifestLevelPropertyBag, "FrontloadPayloadPropertiesOverrideManifestLevelFields", "go");
@@clientName(ResourceTypeEndpointBase, "FrontloadPayloadPropertiesOverrideEndpointLevelFields", "go");
@@clientName(ExpeditedRolloutDefinition, "DefaultRolloutSpecificationExpeditedRollout", "go");
@@clientName(DefaultRolloutStatus, "DefaultRolloutPropertiesStatus", "go");
@@clientName(TrafficRegions, "CustomRolloutSpecificationCanary", "go");
@@clientName(IdentityManagement, "ResourceTypeIdentityManagement", "go");
@@clientName(CheckNameAvailabilitySpecifications, "ResourceTypeRegistrationPropertiesCheckNameAvailabilitySpecifications", "go");
@@clientName(ReRegisterSubscriptionMetadata, "ResourceProviderManifestReRegisterSubscriptionMetadata", "go");
@@clientName(ExtensionOptions, "ResourceTypeExtensionOptionsResourceCreationBegin", "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeEndpointBaseFeaturesRule {
  requiredFeaturesPolicy: FeaturesPolicy;
}
@@alternateType(ResourceTypeEndpointBase.featuresRule, ResourceTypeEndpointBaseFeaturesRule, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationCanary is CanaryTrafficRegionRolloutConfiguration;
@@alternateType(DefaultRolloutSpecification.canary, DefaultRolloutSpecificationCanary, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionEn is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionEs is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionCs is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionDe is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionDefault is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionFr is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionHu is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionIt is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionJa is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionKo is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionNl is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionPl is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionPtBR is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionRu is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionSv is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionZhHans is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionZhHant is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDisplayDefinitionPt is OperationsDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocalizedOperationDefinitionDisplay is LocalizedOperationDisplayDefinition;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationsDefinitionDisplay is OperationsDisplayDefinition;

@@alternateType(OperationsDefinition.display, OperationsDefinitionDisplay, "go");
@@alternateType(LocalizedOperationDefinition.display, LocalizedOperationDefinitionDisplay, "go");
@@alternateType(LocalizedOperationDisplayDefinition.en, LocalizedOperationDisplayDefinitionEn, "go");
@@alternateType(LocalizedOperationDisplayDefinition.es, LocalizedOperationDisplayDefinitionEs, "go");
@@alternateType(LocalizedOperationDisplayDefinition.cs, LocalizedOperationDisplayDefinitionCs, "go");
@@alternateType(LocalizedOperationDisplayDefinition.de, LocalizedOperationDisplayDefinitionDe, "go");
@@alternateType(LocalizedOperationDisplayDefinition.default, LocalizedOperationDisplayDefinitionDefault, "go");
@@alternateType(LocalizedOperationDisplayDefinition.fr, LocalizedOperationDisplayDefinitionFr, "go");
@@alternateType(LocalizedOperationDisplayDefinition.hu, LocalizedOperationDisplayDefinitionHu, "go");
@@alternateType(LocalizedOperationDisplayDefinition.it, LocalizedOperationDisplayDefinitionIt, "go");
@@alternateType(LocalizedOperationDisplayDefinition.ja, LocalizedOperationDisplayDefinitionJa, "go");
@@alternateType(LocalizedOperationDisplayDefinition.ko, LocalizedOperationDisplayDefinitionKo, "go");
@@alternateType(LocalizedOperationDisplayDefinition.nl, LocalizedOperationDisplayDefinitionNl, "go");
@@alternateType(LocalizedOperationDisplayDefinition.pl, LocalizedOperationDisplayDefinitionPl, "go");
@@alternateType(LocalizedOperationDisplayDefinition.ptBR, LocalizedOperationDisplayDefinitionPtBR, "go");
@@alternateType(LocalizedOperationDisplayDefinition.ru, LocalizedOperationDisplayDefinitionRu, "go");
@@alternateType(LocalizedOperationDisplayDefinition.sv, LocalizedOperationDisplayDefinitionSv, "go");
@@alternateType(LocalizedOperationDisplayDefinition.zhHans, LocalizedOperationDisplayDefinitionZhHans, "go");
@@alternateType(LocalizedOperationDisplayDefinition.zhHant, LocalizedOperationDisplayDefinitionZhHant, "go");
@@alternateType(LocalizedOperationDisplayDefinition.ptPT, LocalizedOperationDisplayDefinitionPt, "go");
@@clientName(LocalizedOperationDefinitionDisplay.ptPT, "pt", "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesTemplateDeploymentPolicy is TemplateDeploymentPolicy;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeTemplateDeploymentPolicy is TemplateDeploymentPolicy;

@@alternateType(ResourceTypeRegistrationProperties.templateDeploymentPolicy, ResourceTypeRegistrationPropertiesTemplateDeploymentPolicy, "go");
@@alternateType(ResourceType.templateDeploymentPolicy, ResourceTypeTemplateDeploymentPolicy, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesTemplateDeploymentOptions is TemplateDeploymentOptions;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesTemplateDeploymentOptions is TemplateDeploymentOptions;

@@alternateType(ResourceTypeRegistrationProperties.templateDeploymentOptions, ResourceTypeRegistrationPropertiesTemplateDeploymentOptions, "go");
@@alternateType(ProviderRegistrationProperties.templateDeploymentOptions, ResourceProviderManifestPropertiesTemplateDeploymentOptions, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications is SubscriptionLifecycleNotificationSpecifications;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications is SubscriptionLifecycleNotificationSpecifications;

@@alternateType(ResourceTypeRegistrationProperties.subscriptionLifecycleNotificationSpecifications,
  ResourceTypeRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications,
  "go"
);
@@alternateType(ProviderRegistrationProperties.subscriptionLifecycleNotificationSpecifications,
  ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications,
  "go"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesRequestHeaderOptions is RequestHeaderOptions;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRequestHeaderOptions is RequestHeaderOptions;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestRequestHeaderOptions is RequestHeaderOptions;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesRequestHeaderOptions is RequestHeaderOptions;

@@alternateType(ResourceTypeRegistrationProperties.requestHeaderOptions, ResourceTypeRegistrationPropertiesRequestHeaderOptions, "go");
@@alternateType(ResourceType.requestHeaderOptions, ResourceTypeRequestHeaderOptions, "go");
@@alternateType(ResourceProviderManifest.requestHeaderOptions, ResourceProviderManifestRequestHeaderOptions, "go");
@@alternateType(ProviderRegistrationProperties.requestHeaderOptions, ResourceProviderManifestPropertiesRequestHeaderOptions, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesManagement is ResourceProviderManagement;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestManagement is ResourceProviderManagement;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesManagement is ResourceProviderManagement;

@@alternateType(ResourceTypeRegistrationProperties.management, ResourceTypeRegistrationPropertiesManagement, "go");
@@alternateType(ResourceProviderManifest.management, ResourceProviderManifestManagement, "go");
@@alternateType(ProviderRegistrationProperties.management, ResourceProviderManifestPropertiesManagement, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesFeaturesRule is FeaturesRule;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeEndpointFeaturesRule is FeaturesRule;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeFeaturesRule is FeaturesRule;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestFeaturesRule is FeaturesRule;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderEndpointFeaturesRule is FeaturesRule;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesFeaturesRule is FeaturesRule;

@@alternateType(ResourceTypeRegistrationProperties.featuresRule, ResourceTypeRegistrationPropertiesFeaturesRule, "go");
@@alternateType(ResourceTypeEndpoint.featuresRule, ResourceTypeEndpointFeaturesRule, "go");
@@alternateType(ResourceType.featuresRule, ResourceTypeFeaturesRule, "go");
@@alternateType(ResourceProviderManifest.featuresRule, ResourceProviderManifestFeaturesRule, "go");
@@alternateType(ResourceProviderEndpoint.featuresRule, ResourceProviderEndpointFeaturesRule, "go");
@@alternateType(ProviderRegistrationProperties.featuresRule, ResourceProviderManifestPropertiesFeaturesRule, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesExtensionOptions is ResourceTypeExtensionOptions;
@@alternateType(ResourceTypeRegistrationProperties.extensionOptions, ResourceTypeRegistrationPropertiesExtensionOptions, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeRegistrationPropertiesDstsConfiguration is DstsConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeEndpointBaseDstsConfiguration is DstsConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceTypeEndpointDstsConfiguration is DstsConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesDstsConfiguration is DstsConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FanoutLinkedNotificationRuleDstsConfiguration is DstsConfiguration;

@@alternateType(ResourceTypeRegistrationProperties.dstsConfiguration, ResourceTypeRegistrationPropertiesDstsConfiguration, "go");
@@alternateType(ResourceTypeEndpointBase.dstsConfiguration, ResourceTypeEndpointBaseDstsConfiguration, "go");
@@alternateType(ResourceTypeEndpoint.dstsConfiguration, ResourceTypeEndpointDstsConfiguration, "go");
@@alternateType(ProviderRegistrationProperties.dstsConfiguration, ResourceProviderManifestPropertiesDstsConfiguration, "go");
@@alternateType(FanoutLinkedNotificationRule.dstsConfiguration, FanoutLinkedNotificationRuleDstsConfiguration, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestProviderAuthentication is ResourceProviderAuthentication;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceProviderManifestPropertiesProviderAuthentication is ResourceProviderAuthentication;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MetadataProviderAuthentication is ResourceProviderAuthentication;

@@alternateType(ResourceProviderManifest.providerAuthentication, ResourceProviderManifestProviderAuthentication, "go");
@@alternateType(ProviderRegistrationProperties.providerAuthentication, ResourceProviderManifestPropertiesProviderAuthentication, "go");
@@alternateType(ProviderHubMetadata.providerAuthentication, MetadataProviderAuthentication, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProviderRegistrationPropertiesProviderHubMetadata is ProviderHubMetadata;
@@alternateType(ProviderRegistrationProperties.providerHubMetadata, ProviderRegistrationPropertiesProviderHubMetadata, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutPropertiesSpecification is DefaultRolloutSpecification;
@@alternateType(DefaultRolloutProperties.specification, DefaultRolloutPropertiesSpecification, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutStatusManifestCheckinStatus is CheckinManifestInfo;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomRolloutStatusManifestCheckinStatus is CheckinManifestInfo;

@@alternateType(DefaultRolloutStatus.manifestCheckinStatus, DefaultRolloutStatusManifestCheckinStatus, "go");
@@alternateType(CustomRolloutStatus.manifestCheckinStatus, CustomRolloutStatusManifestCheckinStatus, "go");

namespace Microsoft.ProviderHub {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model DefaultRolloutSpecificationProviderRegistration is ProviderRegistration;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model CustomRolloutSpecificationProviderRegistration is ProviderRegistration;
}

@@alternateType(DefaultRolloutSpecification.providerRegistration, DefaultRolloutSpecificationProviderRegistration, "go");
@@alternateType(CustomRolloutSpecification.providerRegistration, CustomRolloutSpecificationProviderRegistration, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomRolloutPropertiesStatus is CustomRolloutStatus;
@@alternateType(CustomRolloutProperties.status, CustomRolloutPropertiesStatus, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomRolloutPropertiesSpecification is CustomRolloutSpecification;
@@alternateType(CustomRolloutProperties.specification, CustomRolloutPropertiesSpecification, "go");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationRestOfTheWorldGroupTwo is TrafficRegionRolloutConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationRestOfTheWorldGroupOne is TrafficRegionRolloutConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationMediumTraffic is TrafficRegionRolloutConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationLowTraffic is TrafficRegionRolloutConfiguration;
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DefaultRolloutSpecificationHighTraffic is TrafficRegionRolloutConfiguration;

@@alternateType(DefaultRolloutSpecification.restOfTheWorldGroupTwo, DefaultRolloutSpecificationRestOfTheWorldGroupTwo, "go");
@@alternateType(DefaultRolloutSpecification.restOfTheWorldGroupOne, DefaultRolloutSpecificationRestOfTheWorldGroupOne, "go");
@@alternateType(DefaultRolloutSpecification.mediumTraffic, DefaultRolloutSpecificationMediumTraffic, "go");
@@alternateType(DefaultRolloutSpecification.lowTraffic, DefaultRolloutSpecificationLowTraffic, "go");
@@alternateType(DefaultRolloutSpecification.highTraffic, DefaultRolloutSpecificationHighTraffic, "go");
