import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

@@clientName(Microsoft.ProviderHub, "ProviderHubMgmtClient", "python");

@@clientLocation(ProviderRegistrations.checkinManifest, "Client", "go");
@@clientLocation(ProviderRegistrations.generateManifest, "Client", "go");

@@clientName(LocalizedOperationDefinitionDisplay.ptPT, "pt", "go,java");
@@clientName(LocalizedOperationDisplayDefinitionPtPT,
  "LocalizedOperationDisplayDefinitionPt",
  "go,java"
);

@@alternateType(AuthorizedApplication.name, Azure.Core.uuid, "java");
@@clientName(SubscriptionLifecycleNotificationSpecifications.softDeleteTTL,
  "softDeleteTtl",
  "java"
);

@@clientName(AdditionalAuthorization, "ProviderAdditionalAuthorization", "csharp");
@@clientName(AdditionalOptions, "AdditionalOptionResourceType", "csharp");
@@clientName(AdditionalOptionsAsyncOperation, "AdditionalOptionAsyncOperation", "csharp");
@@clientName(AdditionalOptionsResourceTypeRegistration, "AdditionalOptionResourceTypeRegistration", "csharp");
@@clientName(ApiProfile, "ResourceTypeRegistrationApiProfile", "csharp");
@@clientName(AuthenticationScheme, "ProviderAuthenticationScheme", "csharp");
@@clientName(AuthorizedApplication, "ProviderAuthorizedApplication", "csharp");
@@clientName(AuthorizedApplicationProperties, "ProviderAuthorizedApplicationProperties", "csharp");
@@alternateType(CanaryTrafficRegionRolloutConfiguration.regions, Azure.Core.azureLocation[], "csharp");
@@alternateType(CanaryTrafficRegionRolloutConfiguration.skipRegions, Azure.Core.azureLocation[], "csharp");
@@clientName(CapacityPolicy, "ResourceTypeRegistrationCapacityPolicy", "csharp");
@@clientName(CheckinManifestParams, "CheckinManifestContent", "csharp");
@@alternateType(CheckinManifestParams.baselineArmManifestLocation, Azure.Core.azureLocation, "csharp");
@@clientName(CheckNameAvailabilitySpecifications.enableDefaultValidation, "IsDefaultValidationEnabled", "csharp");
@@clientName(CustomRolloutArrayResponseWithContinuation, "CustomRolloutListResult", "csharp");
@@clientName(CustomRolloutSpecificationAutoProvisionConfig, "CustomRolloutAutoProvisionConfig", "csharp");
@@clientName(CustomRolloutSpecificationAutoProvisionConfig.resourceGraph, "IsResourceGraphEnabled", "csharp");
@@clientName(CustomRolloutSpecificationAutoProvisionConfig.storage, "IsStorageEnabled", "csharp");
@@alternateType(CustomRolloutStatus.completedRegions, Azure.Core.azureLocation[], "csharp");
@@clientName(DataBoundary, "ResourceTypeDataBoundary", "csharp");
@@clientName(DefaultRolloutArrayResponseWithContinuation, "DefaultRolloutListResult", "csharp");
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig, "DefaultRolloutAutoProvisionConfig", "csharp");
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig.resourceGraph, "IsResourceGraphEnabled", "csharp");
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig.storage, "IsStorageEnabled", "csharp");
@@clientName(DeleteDependency, "ResourceTypeRegistrationDeleteDependency", "csharp");
@@clientName(DstsConfiguration, "ProviderDstsConfiguration", "csharp");
@@clientName(EndpointInformation, "ProviderEndpointInformation", "csharp");
@@clientName(EndpointType, "ProviderEndpointType", "csharp");
@@clientName(EndpointTypeResourceType, "ProviderEndpointTypeResourceType", "csharp");
@@clientName(ExpeditedRolloutDefinition.enabled, "IsExpeditedRolloutEnabled", "csharp");
@@clientName(ExtendedLocationOptions.supportedPolicy, "SupportedLocationPolicy", "csharp");
@@clientName(ExtendedLocationOptions.type, "LocationType", "csharp");
@@clientName(ExtendedLocationType, "ProviderExtendedLocationType", "csharp");
@@clientName(ExtensionCategory, "ResourceTypeExtensionCategory", "csharp");
@@clientName(FeaturesRule, "ProviderFeaturesRule", "csharp");
@@clientName(FilterOption, "ProviderResourceQueryFilterOption", "csharp");
@@clientName(FilterRule, "ProviderFilterRule", "csharp");
@@clientName(FrontloadPayload, "ProviderFrontloadPayload", "csharp");
@@clientName(FrontloadPayloadProperties, "ProviderFrontloadPayloadProperties", "csharp");
@@clientName(Intent, "AllowedUnauthorizedActionIntent", "csharp");
@@clientName(Intent.LOW_PRIVILEGE, "LowPrivilege", "csharp");
@@clientName(Intent.NOT_SPECIFIED, "NotSpecified", "csharp");
@@clientName(LegacyOperation, "ProviderLegacyOperation", "csharp");
@@clientName(LocationQuotaRule, "ProviderLocationQuotaRule", "csharp");
@@alternateType(LocationQuotaRule.location, Azure.Core.azureLocation, "csharp");
@@clientName(LoggingHiddenPropertyPath, "LoggingHiddenPropertyPaths", "csharp");
@@clientName(Notification, "ProviderNotification", "csharp");
@@alternateType(NotificationEndpoint.locations, Azure.Core.azureLocation[], "csharp");
@@alternateType(NotificationEndpoint.notificationDestination, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(NotificationEndpointType, "ProviderNotificationEndpointType", "csharp");
@@clientName(NotificationOptions, "ProviderNotificationOption", "csharp");
@@clientName(NotificationRegistrationArrayResponseWithContinuation, "NotificationRegistrationListResult", "csharp");
@@clientName(NotificationType, "ProviderNotificationType", "csharp");
@@clientName(OpenApiValidation.allowNoncompliantCollectionResponse, "IsNoncompliantCollectionResponseAllowed", "csharp");
@@clientName(Policy, "ResourceConcurrencyPolicy", "csharp");
@@clientName(ProviderRegistrationArrayResponseWithContinuation, "ProviderRegistrationListResult", "csharp");
@@clientName(QuotaPolicy, "ProviderQuotaPolicy", "csharp");
@@clientName(QuotaRule, "ProviderQuotaRule", "csharp");
@@clientName(Readiness, "ServiceTreeReadiness", "csharp");
@@clientName(Regionality, "ResourceTypeRegistrationRegionality", "csharp");
@@clientName(ReRegisterSubscriptionMetadata.enabled, "IsEnabled", "csharp");
@@clientName(RequestHeaderOptions, "ProviderRequestHeaderOptions", "csharp");
@@clientName(ResourceGraphConfiguration.enabled, "IsEnabled", "csharp");
@@clientName(ResourceMovePolicy.crossResourceGroupMoveEnabled, "IsCrossResourceGroupMoveEnabled", "csharp");
@@clientName(ResourceMovePolicy.crossSubscriptionMoveEnabled, "IsCrossSubscriptionMoveEnabled", "csharp");
@@clientName(ResourceMovePolicy.validationRequired, "IsValidationRequired", "csharp");
@@clientName(ResourceProviderAuthorizationManagedByAuthorization, "ResourceProviderManagedByAuthorization", "csharp");
@@clientName(ResourceProviderAuthorizationManagedByAuthorization.allowManagedByInheritance, "DoesAllowManagedByInheritance", "csharp");
@@clientName(ResourceProviderEndpoint.enabled, "IsEnabled", "csharp");
@@alternateType(ResourceProviderEndpoint.locations, Azure.Core.azureLocation[], "csharp");
@@clientName(ResourceProviderManagement.pcCode, "ProfitCenterCode", "csharp");
@@clientName(ResourceProviderManagement.resourceAccessRoles, "ResourceAccessRoleList", "csharp");
@@clientName(ResourceProviderManagementErrorResponseMessageOptions, "ResourceProviderErrorResponseMessageOptions", "csharp");
@@clientName(ResourceProviderManagementExpeditedRolloutMetadata, "ExpeditedRolloutMetadata", "csharp");
@@clientName(ResourceProviderManagementExpeditedRolloutMetadata.enabled, "IsEnabled", "csharp");
@@clientName(ResourceProviderManifest.enableTenantLinkedNotification, "IsTenantLinkedNotificationEnabled", "csharp");
@@clientName(ResourceProviderManifestPropertiesNotificationSettings, "ResourceProviderManifestNotificationSettings", "csharp");
@@clientName(ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove, "ResourceProviderManifestResourceGroupLockOptionDuringMove", "csharp");
@@clientName(ResourceProviderManifestPropertiesResponseOptions, "ResourceProviderManifestResponseOptions", "csharp");
@@clientName(ResourceSubType, "ProviderResourceSubType", "csharp");
@@clientName(ResourceType, "ProviderResourceType", "csharp");
@@clientName(ResourceTypeEndpoint.enabled, "IsEnabled", "csharp");
@@alternateType(ResourceTypeEndpoint.locations, Azure.Core.azureLocation[], "csharp");
@@clientName(ResourceTypeRegistrationArrayResponseWithContinuation, "ResourceTypeRegistrationListResult", "csharp");
@@clientName(ResourceTypeRegistrationProperties.addResourceListTargetLocations, "IsAddResourceListTargetLocationsAllowed", "csharp");
@@clientName(ResourceTypeRegistrationProperties.allowEmptyRoleAssignments, "IsEmptyRoleAssignmentsAllowed", "csharp");
@@clientName(ResourceTypeRegistrationProperties.enableAsyncOperation, "IsAsyncOperationEnabled", "csharp");
@@clientName(ResourceTypeRegistrationProperties.enableThirdPartyS2S, "IsThirdPartyS2SEnabled", "csharp");
@@clientName(ResourceTypeRegistrationProperties.supportsTags, "AreTagsSupported", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesAvailabilityZoneRule, "ResourceTypeRegistrationAvailabilityZoneRule", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesCapacityRule, "ResourceTypeRegistrationCapacityRule", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesLegacyPolicy, "ResourceTypeRegistrationLegacyPolicy", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesMarketplaceOptions, "ResourceTypeRegistrationMarketplaceOptions", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesMarketplaceOptions.addOnPlanConversionAllowed, "IsAddOnPlanConversionAllowed", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceCache, "ResourceTypeRegistrationResourceCache", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceCache.enableResourceCache, "IsResourceCacheEnabled", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptions, "ResourceTypeRegistrationResourceManagementOptions", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptionsBatchProvisioningSupport, "BatchProvisioningSupport", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptionsNestedProvisioningSupport, "NestedProvisioningSupport", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceQueryManagement, "ProviderResourceQueryManagement", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesResourceTypeCommonAttributeManagement, "ResourceTypeCommonAttributeManagement", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesRoutingRule, "ResourceTypeRegistrationRoutingRule", "csharp");
@@clientName(ResourceTypeSku, "ResourceTypeSkuProperties", "csharp");
@@clientName(Role, "ApplicationOwnershipRole", "csharp");
@@alternateType(RolloutStatusBase.completedRegions, Azure.Core.azureLocation[], "csharp");
@@clientName(RoutingType, "ResourceRoutingType", "csharp");
@@clientName(ServiceStatus, "ResourceProviderServiceStatus", "csharp");
@@clientName(SkuCapability, "ResourceSkuCapability", "csharp");
@@clientName(SkuCapacity, "ResourceTypeSkuCapacity", "csharp");
@@clientName(SkuCost, "ResourceTypeSkuCost", "csharp");
@@clientName(SkuLocationInfo, "ResourceTypeSkuLocationInfo", "csharp");
@@clientName(SkuLocationInfo.type, "LocationType", "csharp");
@@clientName(SkuResource, "ResourceTypeSku", "csharp");
@@clientName(SkuResourceArrayResponseWithContinuation, "ResourceTypeSkuListResult", "csharp");
@@clientName(SkuScaleType, "ResourceTypeSkuScaleType", "csharp");
@@clientName(SkuSetting, "ResourceTypeSkuSetting", "csharp");
@@clientName(SkuZoneDetail, "ResourceTypeSkuZoneDetail", "csharp");
@@clientName(SubscriptionState, "ProviderSubscriptionState", "csharp");
@@clientName(SubscriptionStateRule, "ProviderSubscriptionStateRule", "csharp");
@@clientName(SupportedOperations, "ResourceManagementSupportedOperation", "csharp");
@@clientName(TemplateDeploymentOptions.preflightSupported, "IsPreflightSupported", "csharp");
@@alternateType(TrafficRegions.regions, Azure.Core.azureLocation[], "csharp");
@@alternateType(ResourceProviderEndpoint.endpointUri, url, "csharp");
@@alternateType(ResourceTypeEndpoint.endpointUri, url, "csharp");
@@alternateType(ResourceTypeExtension.endpointUri, url, "csharp");
@@alternateType(SwaggerSpecification.swaggerSpecFolderUri, url, "csharp");
@@alternateType(ResourceTypeEndpointBase.endpointUri, url, "csharp");
@@clientName(ExtendedLocationOptions, "ProviderHubExtendedLocationOptions", "csharp");
@@clientName(ProvisioningState, "ProviderHubProvisioningState", "csharp");
@@clientName(IdentityManagementTypes, "IdentityManagementType", "csharp");
@@clientName(TemplateDeploymentCapabilities, "TemplateDeploymentCapability", "csharp");
@@clientName(TemplateDeploymentPreflightOptions, "TemplateDeploymentPreflightOption", "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.providerAuthentication, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.featuresRule, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.resourceProviderAuthorizationRules, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.notificationSettings, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.resourceGroupLockOptionDuringMove, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.responseOptions, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceType.identityManagement, "csharp");
@@access(ResourceProviderAuthentication, Access.internal, "csharp");

// Step 6: Rename flattened inner properties to match old SDK names
@@clientName(ResourceProviderAuthentication.allowedAudiences, "ProviderAuthenticationAllowedAudiences", "csharp");
@@clientName(ResourceProviderManifestPropertiesNotificationSettings.subscriberSettings, "NotificationSubscriberSettings", "csharp");
@@clientName(ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove.blockActionVerb, "ResourceGroupLockOptionDuringMoveBlockActionVerb", "csharp");
@@clientName(IdentityManagement.type, "ManagementType", "csharp");
@@clientName(Intent.DEFERRED_ACCESS_CHECK, "DeferredAccessCheck", "csharp");
@@clientName(Intent.RP_CONTRACT, "RPContract", "csharp");
@@clientName(SubscriptionLifecycleNotificationSpecifications.softDeleteTTL, "SoftDeleteTtl", "csharp");

// Step 6: ApiCompat fixes — restore old type names

// Group A: Enum/union renames (singular ← plural)
@@clientName(LoggingDetails, "LoggingDetail", "csharp");
@@clientName(LoggingDirections, "LoggingDirection", "csharp");
@@clientName(SkipNotifications, "SkipNotification", "csharp");
@@clientName(TemplateDeploymentPreflightNotifications, "TemplateDeploymentPreflightNotification", "csharp");

// Group A: Resource type renames — restore old resource/collection class names
// SkuResources interface = base level (resourceType/skus/{sku}) → old name ResourceTypeSku
@@clientName(SkuResources, "ResourceTypeSku", "csharp");
// Skus interface = nested level 1 (nestedResourceTypeFirst/skus/{sku}) → old name NestedResourceTypeFirstSku
@@clientName(Skus, "NestedResourceTypeFirstSku", "csharp");
// SkuResourceOperations interface = nested level 2 → old name NestedResourceTypeSecondSku
@@clientName(SkuResourceOperations, "NestedResourceTypeSecondSku", "csharp");
// SkuResourceOperationGroup interface = nested level 3 → old name NestedResourceTypeThirdSku
@@clientName(SkuResourceOperationGroup, "NestedResourceTypeThirdSku", "csharp");
// NewRegionFrontloadRelease interface → old name was RegistrationNewRegionFrontloadRelease{Collection,Resource}
@@clientName(NewRegionFrontloadRelease, "RegistrationNewRegionFrontloadReleases", "csharp");

// Group B: Guid param — AuthorizedApplication key was System.Guid in old SDK
@@alternateType(AuthorizedApplication.name, Azure.Core.uuid, "csharp");

// ManifestLevelPropertyBag is internalized by PostProcessor — keep it public
@@access(ManifestLevelPropertyBag, Access.public, "csharp");

// SkuLocationInfo.location was AzureLocation in old SDK
@@alternateType(SkuLocationInfo.location, Azure.Core.azureLocation, "csharp");

// ResourceManagementEntity.location was AzureLocation in old SDK
@@alternateType(ResourceManagementEntity.location, Azure.Core.azureLocation, "csharp");


// Operation renames to match old SDK method names
@@clientName(ProviderRegistrations.deleteResources, "DeleteResourcesResourceAction", "csharp");
@@clientName(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest, "GenerateManifestNewRegionFrontloadRelease", "csharp");

// Property renames to match old SDK names
@@clientName(IdentityManagementProperties.type, "ManagementType", "csharp");
@@clientName(ThrottlingMetric.type, "MetricType", "csharp");
@@clientName(TypedErrorInfo.type, "TypedErrorInfoType", "csharp");

// Replacement model: DefaultRolloutSpecification
// The spec defines empty wrapper models (e.g. DefaultRolloutSpecificationCanary extends CanaryTrafficRegionRolloutConfiguration)
// but old autorest collapsed these wrappers and used the base types directly.
// This replacement uses the base types to match old SDK behavior.
model DefaultRolloutSpecificationReplacement {
  /** The expedited rollout definition. */
  expeditedRollout?: ExpeditedRolloutDefinition;

  /** The canary traffic region configuration. */
  canary?: CanaryTrafficRegionRolloutConfiguration;

  /** The low traffic region configuration. */
  lowTraffic?: TrafficRegionRolloutConfiguration;

  /** The medium traffic region configuration. */
  mediumTraffic?: TrafficRegionRolloutConfiguration;

  /** The high traffic region configuration. */
  highTraffic?: TrafficRegionRolloutConfiguration;

  /** The rest of the world group one region configuration. */
  restOfTheWorldGroupOne?: TrafficRegionRolloutConfiguration;

  /** The rest of the world group two region configuration. */
  restOfTheWorldGroupTwo?: TrafficRegionRolloutConfiguration;

  /** The provider registration. */
  providerRegistration?: ProviderRegistration;

  /** The resource type registrations. */
  resourceTypeRegistrations?: ResourceTypeRegistration[];

  /** The auto provisioning config. */
  autoProvisionConfig?: DefaultRolloutSpecificationAutoProvisionConfig;
}

@@alternateType(DefaultRolloutSpecification, DefaultRolloutSpecificationReplacement, "csharp");
@@clientName(DefaultRolloutSpecification, "DefaultRolloutSpecificationOriginal", "csharp");
@@clientName(DefaultRolloutSpecificationReplacement, "DefaultRolloutSpecification", "csharp");

// Replacement model: CustomRolloutProperties
model CustomRolloutPropertiesReplacement {
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The specification. */
  specification: CustomRolloutSpecification;

  /** The status. */
  status?: CustomRolloutStatus;
}

@@alternateType(CustomRolloutProperties, CustomRolloutPropertiesReplacement, "csharp");
@@clientName(CustomRolloutProperties, "CustomRolloutPropertiesOriginal", "csharp");
@@clientName(CustomRolloutPropertiesReplacement, "CustomRolloutProperties", "csharp");

// Replacement model: DefaultRolloutProperties
model DefaultRolloutPropertiesReplacement {
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The default rollout specification. */
  specification?: DefaultRolloutSpecification;

  /** The default rollout status. */
  status?: DefaultRolloutStatus;
}

@@alternateType(DefaultRolloutProperties, DefaultRolloutPropertiesReplacement, "csharp");
@@clientName(DefaultRolloutProperties, "DefaultRolloutPropertiesOriginal", "csharp");
@@clientName(DefaultRolloutPropertiesReplacement, "DefaultRolloutProperties", "csharp");

// Replacement model: CustomRolloutSpecification
model CustomRolloutSpecificationReplacement {
  /** The auto provisioning configuration. */
  autoProvisionConfig?: CustomRolloutSpecificationAutoProvisionConfig;

  /** The canary region configuration. */
  canary?: TrafficRegions;

  /** The list of ARM regions scoped for the release. */
  releaseScopes?: string[];

  /** Whether refreshing subscription registration is enabled or disabled. */
  refreshSubscriptionRegistration?: boolean;

  /** Whether release scope validation should be skipped. */
  skipReleaseScopeValidation?: boolean;

  /** The provider registration. */
  providerRegistration?: ProviderRegistration;

  /** The resource type registrations. */
  resourceTypeRegistrations?: ResourceTypeRegistration[];
}

@@alternateType(CustomRolloutSpecification, CustomRolloutSpecificationReplacement, "csharp");
@@clientName(CustomRolloutSpecification, "CustomRolloutSpecificationOriginal", "csharp");
@@clientName(CustomRolloutSpecificationReplacement, "CustomRolloutSpecification", "csharp");

// Replacement model: CustomRolloutStatus
model CustomRolloutStatusReplacement {
  /** The completed regions. */
  completedRegions?: string[];

  /** The failed or skipped regions. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failedOrSkippedRegions?: Record<ExtendedErrorInfo>;

  /** The manifest checkin status. */
  manifestCheckinStatus?: CheckinManifestInfo;
}

@@alternateType(CustomRolloutStatus, CustomRolloutStatusReplacement, "csharp");
@@clientName(CustomRolloutStatus, "CustomRolloutStatusOriginal", "csharp");
@@clientName(CustomRolloutStatusReplacement, "CustomRolloutStatus", "csharp");

// Replacement model: DefaultRolloutStatus
model DefaultRolloutStatusReplacement extends RolloutStatusBase {
  /** The next traffic region. */
  nextTrafficRegion?: TrafficRegionCategory;

  /** The next traffic region scheduled time. */
  nextTrafficRegionScheduledTime?: utcDateTime;

  /** The subscription reregistration result. */
  subscriptionReregistrationResult?: SubscriptionReregistrationResult;

  /** The manifest checkin status. */
  manifestCheckinStatus?: CheckinManifestInfo;
}

@@alternateType(DefaultRolloutStatus, DefaultRolloutStatusReplacement, "csharp");
@@clientName(DefaultRolloutStatus, "DefaultRolloutStatusOriginal", "csharp");
@@clientName(DefaultRolloutStatusReplacement, "DefaultRolloutStatus", "csharp");

// Replacement model: ResourceTypeRegistrationProperties
// Uses OmitProperties to spread all non-wrapper properties from the original,
// then explicitly declares the 12 wrapper properties with their base types.
model ResourceTypeRegistrationPropertiesReplacement {
  extensionOptions?: ResourceTypeExtensionOptions;
  featuresRule?: FeaturesRule;
  subscriptionLifecycleNotificationSpecifications?: SubscriptionLifecycleNotificationSpecifications;
  identityManagement?: IdentityManagementProperties;
  checkNameAvailabilitySpecifications?: CheckNameAvailabilitySpecifications;
  requestHeaderOptions?: RequestHeaderOptions;
  templateDeploymentOptions?: TemplateDeploymentOptions;
  resourceMovePolicy?: ResourceMovePolicy;
  resourceGraphConfiguration?: ResourceGraphConfiguration;
  management?: ResourceProviderManagement;
  templateDeploymentPolicy?: TemplateDeploymentPolicy;
  dstsConfiguration?: DstsConfiguration;

  ...OmitProperties<
    ResourceTypeRegistrationProperties,
    "extensionOptions"
      | "featuresRule"
      | "subscriptionLifecycleNotificationSpecifications"
      | "identityManagement"
      | "checkNameAvailabilitySpecifications"
      | "requestHeaderOptions"
      | "templateDeploymentOptions"
      | "resourceMovePolicy"
      | "resourceGraphConfiguration"
      | "management"
      | "templateDeploymentPolicy"
      | "dstsConfiguration"
  >;
}

@@alternateType(ResourceTypeRegistrationProperties, ResourceTypeRegistrationPropertiesReplacement, "csharp");
@@clientName(ResourceTypeRegistrationProperties, "ResourceTypeRegistrationPropertiesOriginal", "csharp");
@@clientName(ResourceTypeRegistrationPropertiesReplacement, "ResourceTypeRegistrationProperties", "csharp");

// Experiment: directly swap wrapper with base type
@@alternateType(LoggingRuleHiddenPropertyPaths, LoggingHiddenPropertyPath, "csharp");

// Force visibility for base types that lost public references when wrappers were replaced
@@usage(ResourceProviderAuthentication, Usage.input | Usage.output, "csharp");
@@usage(FeaturesRule, Usage.input | Usage.output, "csharp");
@@access(FeaturesRule, Access.public, "csharp");
@@usage(PrivateResourceProviderConfiguration, Usage.input | Usage.output, "csharp");
@@usage(IdentityManagement, Usage.input | Usage.output, "csharp");

// Direct wrapper→base replacements for all remaining empty wrapper models
@@alternateType(ProviderRegistrationPropertiesProviderHubMetadata, ProviderHubMetadata, "csharp");
@@alternateType(ProviderHubMetadataProviderAuthentication, ResourceProviderAuthentication, "csharp");
@@alternateType(ProviderHubMetadataThirdPartyProviderAuthorization, ThirdPartyProviderAuthorization, "csharp");
@@alternateType(ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications, SubscriptionLifecycleNotificationSpecifications, "csharp");
@@alternateType(ProviderRegistrationPropertiesPrivateResourceProviderConfiguration, PrivateResourceProviderConfiguration, "csharp");
@@alternateType(ResourceProviderManifestPropertiesProviderAuthentication, ResourceProviderAuthentication, "csharp");
@@alternateType(ResourceProviderManifestPropertiesFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceProviderManifestPropertiesRequestHeaderOptions, RequestHeaderOptions, "csharp");
@@alternateType(ResourceProviderManifestPropertiesManagement, ResourceProviderManagement, "csharp");
@@alternateType(ResourceProviderManifestPropertiesTemplateDeploymentOptions, TemplateDeploymentOptions, "csharp");
@@alternateType(ResourceProviderManifestPropertiesDstsConfiguration, DstsConfiguration, "csharp");
@@alternateType(ResourceProviderEndpointFeaturesRule, FeaturesRule, "csharp");
@@alternateType(FanoutLinkedNotificationRuleDstsConfiguration, DstsConfiguration, "csharp");
@@alternateType(ResourceTypeEndpointFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeEndpointDstsConfiguration, DstsConfiguration, "csharp");
@@alternateType(ResourceTypeExtensionOptionsResourceCreationBegin, ExtensionOptions, "csharp");
@@alternateType(ResourceProviderManifestProviderAuthentication, ResourceProviderAuthentication, "csharp");
@@alternateType(ResourceProviderManifestFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceProviderManifestRequestHeaderOptions, RequestHeaderOptions, "csharp");
@@alternateType(ResourceProviderManifestManagement, ResourceProviderManagement, "csharp");
@@alternateType(ResourceProviderManifestReRegisterSubscriptionMetadata, ReRegisterSubscriptionMetadata, "csharp");
@@alternateType(ResourceTypeIdentityManagement, IdentityManagement, "csharp");
@@alternateType(ResourceTypeFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeRequestHeaderOptions, RequestHeaderOptions, "csharp");
@@alternateType(ResourceTypeTemplateDeploymentPolicy, TemplateDeploymentPolicy, "csharp");
@@alternateType(OperationsDefinitionDisplay, OperationsDisplayDefinition, "csharp");
@@alternateType(OperationsPutContentProperties, OperationsContentProperties, "csharp");
@@alternateType(LocalizedOperationDefinitionDisplay, LocalizedOperationDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionDefault, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionEn, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionCs, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionDe, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionEs, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionFr, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionHu, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionIt, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionJa, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionKo, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionNl, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionPl, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionPtBR, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionPtPT, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionRu, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionSv, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionZhHans, OperationsDisplayDefinition, "csharp");
@@alternateType(LocalizedOperationDisplayDefinitionZhHant, OperationsDisplayDefinition, "csharp");
@@alternateType(SkuResourceProperties, ResourceTypeSku, "csharp");
@@alternateType(SkuSettingCapacity, SkuCapacity, "csharp");
@@alternateType(FrontloadPayloadPropertiesOverrideManifestLevelFields, ManifestLevelPropertyBag, "csharp");
@@alternateType(FrontloadPayloadPropertiesOverrideEndpointLevelFields, ResourceTypeEndpointBase, "csharp");
@@alternateType(ResourceTypeEndpointBaseFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeEndpointBaseDstsConfiguration, DstsConfiguration, "csharp");

