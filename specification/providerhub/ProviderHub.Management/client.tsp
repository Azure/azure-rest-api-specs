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

@@clientName(AdditionalAuthorization,
  "ProviderAdditionalAuthorization",
  "csharp"
);
@@clientName(AdditionalOptions, "AdditionalOptionResourceType", "csharp");
@@clientName(AdditionalOptionsAsyncOperation,
  "AdditionalOptionAsyncOperation",
  "csharp"
);
@@clientName(AdditionalOptionsResourceTypeRegistration,
  "AdditionalOptionResourceTypeRegistration",
  "csharp"
);
@@clientName(ApiProfile, "ResourceTypeRegistrationApiProfile", "csharp");
@@clientName(AuthenticationScheme, "ProviderAuthenticationScheme", "csharp");
@@clientName(AuthorizedApplication, "ProviderAuthorizedApplication", "csharp");
@@clientName(AuthorizedApplicationProperties,
  "ProviderAuthorizedApplicationProperties",
  "csharp"
);
@@alternateType(CanaryTrafficRegionRolloutConfiguration.regions,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(CanaryTrafficRegionRolloutConfiguration.skipRegions,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(CapacityPolicy,
  "ResourceTypeRegistrationCapacityPolicy",
  "csharp"
);
@@clientName(CheckinManifestParams, "CheckinManifestContent", "csharp");
@@alternateType(CheckinManifestParams.baselineArmManifestLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(CheckNameAvailabilitySpecifications.enableDefaultValidation,
  "IsDefaultValidationEnabled",
  "csharp"
);
@@clientName(CustomRolloutArrayResponseWithContinuation,
  "CustomRolloutListResult",
  "csharp"
);
@@clientName(CustomRolloutSpecificationAutoProvisionConfig,
  "CustomRolloutAutoProvisionConfig",
  "csharp"
);
@@clientName(CustomRolloutSpecificationAutoProvisionConfig.resourceGraph,
  "IsResourceGraphEnabled",
  "csharp"
);
@@clientName(CustomRolloutSpecificationAutoProvisionConfig.storage,
  "IsStorageEnabled",
  "csharp"
);
@@alternateType(CustomRolloutStatus.completedRegions,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(DataBoundary, "ResourceTypeDataBoundary", "csharp");
@@clientName(DefaultRolloutArrayResponseWithContinuation,
  "DefaultRolloutListResult",
  "csharp"
);
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig,
  "DefaultRolloutAutoProvisionConfig",
  "csharp"
);
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig.resourceGraph,
  "IsResourceGraphEnabled",
  "csharp"
);
@@clientName(DefaultRolloutSpecificationAutoProvisionConfig.storage,
  "IsStorageEnabled",
  "csharp"
);
@@clientName(DeleteDependency,
  "ResourceTypeRegistrationDeleteDependency",
  "csharp"
);
@@clientName(DstsConfiguration, "ProviderDstsConfiguration", "csharp");
@@clientName(EndpointInformation, "ProviderEndpointInformation", "csharp");
@@clientName(EndpointType, "ProviderEndpointType", "csharp");
@@clientName(EndpointTypeResourceType,
  "ProviderEndpointTypeResourceType",
  "csharp"
);
@@clientName(ExpeditedRolloutDefinition.enabled,
  "IsExpeditedRolloutEnabled",
  "csharp"
);
@@clientName(ExtendedLocationOptions.supportedPolicy,
  "SupportedLocationPolicy",
  "csharp"
);
@@clientName(ExtendedLocationOptions.type, "LocationType", "csharp");
@@clientName(ExtendedLocationType, "ProviderExtendedLocationType", "csharp");
@@clientName(ExtensionCategory, "ResourceTypeExtensionCategory", "csharp");
@@clientName(FeaturesRule, "ProviderFeaturesRule", "csharp");
@@clientName(FilterOption, "ProviderResourceQueryFilterOption", "csharp");
@@clientName(FilterRule, "ProviderFilterRule", "csharp");
@@clientName(FrontloadPayload, "ProviderFrontloadPayload", "csharp");
@@clientName(FrontloadPayloadProperties,
  "ProviderFrontloadPayloadProperties",
  "csharp"
);
@@clientName(Intent, "AllowedUnauthorizedActionIntent", "csharp");
@@clientName(Intent.LOW_PRIVILEGE, "LowPrivilege", "csharp");
@@clientName(Intent.NOT_SPECIFIED, "NotSpecified", "csharp");
@@clientName(LegacyOperation, "ProviderLegacyOperation", "csharp");
@@clientName(LocationQuotaRule, "ProviderLocationQuotaRule", "csharp");
@@alternateType(LocationQuotaRule.location, Azure.Core.azureLocation, "csharp");
@@clientName(LoggingHiddenPropertyPath, "LoggingHiddenPropertyPaths", "csharp");
@@clientName(Notification, "ProviderNotification", "csharp");
@@alternateType(NotificationEndpoint.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(NotificationEndpoint.notificationDestination,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(NotificationEndpointType,
  "ProviderNotificationEndpointType",
  "csharp"
);
@@clientName(NotificationOptions, "ProviderNotificationOption", "csharp");
@@clientName(NotificationRegistrationArrayResponseWithContinuation,
  "NotificationRegistrationListResult",
  "csharp"
);
@@clientName(NotificationType, "ProviderNotificationType", "csharp");
@@clientName(OpenApiValidation.allowNoncompliantCollectionResponse,
  "IsNoncompliantCollectionResponseAllowed",
  "csharp"
);
@@clientName(Policy, "ResourceConcurrencyPolicy", "csharp");
@@clientName(ProviderRegistrationArrayResponseWithContinuation,
  "ProviderRegistrationListResult",
  "csharp"
);
@@clientName(QuotaPolicy, "ProviderQuotaPolicy", "csharp");
@@clientName(QuotaRule, "ProviderQuotaRule", "csharp");
@@clientName(Readiness, "ServiceTreeReadiness", "csharp");
@@clientName(Regionality, "ResourceTypeRegistrationRegionality", "csharp");
@@clientName(ReRegisterSubscriptionMetadata.enabled, "IsEnabled", "csharp");
@@clientName(RequestHeaderOptions, "ProviderRequestHeaderOptions", "csharp");
@@clientName(ResourceGraphConfiguration.enabled, "IsEnabled", "csharp");
@@clientName(ResourceMovePolicy.crossResourceGroupMoveEnabled,
  "IsCrossResourceGroupMoveEnabled",
  "csharp"
);
@@clientName(ResourceMovePolicy.crossSubscriptionMoveEnabled,
  "IsCrossSubscriptionMoveEnabled",
  "csharp"
);
@@clientName(ResourceMovePolicy.validationRequired,
  "IsValidationRequired",
  "csharp"
);
@@clientName(ResourceProviderAuthorizationManagedByAuthorization,
  "ResourceProviderManagedByAuthorization",
  "csharp"
);
@@clientName(ResourceProviderAuthorizationManagedByAuthorization.allowManagedByInheritance,
  "DoesAllowManagedByInheritance",
  "csharp"
);
@@clientName(ResourceProviderEndpoint.enabled, "IsEnabled", "csharp");
@@alternateType(ResourceProviderEndpoint.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(ResourceProviderManagement.pcCode, "ProfitCenterCode", "csharp");
@@clientName(ResourceProviderManagement.resourceAccessRoles,
  "ResourceAccessRoleList",
  "csharp"
);
@@clientName(ResourceProviderManagementErrorResponseMessageOptions,
  "ResourceProviderErrorResponseMessageOptions",
  "csharp"
);
@@clientName(ResourceProviderManagementExpeditedRolloutMetadata,
  "ExpeditedRolloutMetadata",
  "csharp"
);
@@clientName(ResourceProviderManagementExpeditedRolloutMetadata.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(ResourceProviderManifest.enableTenantLinkedNotification,
  "IsTenantLinkedNotificationEnabled",
  "csharp"
);
@@clientName(ResourceProviderManifestPropertiesNotificationSettings,
  "ResourceProviderManifestNotificationSettings",
  "csharp"
);
@@clientName(ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove,
  "ResourceProviderManifestResourceGroupLockOptionDuringMove",
  "csharp"
);
@@clientName(ResourceProviderManifestPropertiesResponseOptions,
  "ResourceProviderManifestResponseOptions",
  "csharp"
);
@@clientName(ResourceSubType, "ProviderResourceSubType", "csharp");
@@clientName(ResourceType, "ProviderResourceType", "csharp");
@@clientName(ResourceTypeEndpoint.enabled, "IsEnabled", "csharp");
@@alternateType(ResourceTypeEndpoint.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(ResourceTypeRegistrationArrayResponseWithContinuation,
  "ResourceTypeRegistrationListResult",
  "csharp"
);
@@clientName(ResourceTypeRegistrationProperties.addResourceListTargetLocations,
  "IsAddResourceListTargetLocationsAllowed",
  "csharp"
);
@@clientName(ResourceTypeRegistrationProperties.allowEmptyRoleAssignments,
  "IsEmptyRoleAssignmentsAllowed",
  "csharp"
);
@@clientName(ResourceTypeRegistrationProperties.enableAsyncOperation,
  "IsAsyncOperationEnabled",
  "csharp"
);
@@clientName(ResourceTypeRegistrationProperties.enableThirdPartyS2S,
  "IsThirdPartyS2SEnabled",
  "csharp"
);
@@clientName(ResourceTypeRegistrationProperties.supportsTags,
  "AreTagsSupported",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesAvailabilityZoneRule,
  "ResourceTypeRegistrationAvailabilityZoneRule",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesCapacityRule,
  "ResourceTypeRegistrationCapacityRule",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesLegacyPolicy,
  "ResourceTypeRegistrationLegacyPolicy",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesMarketplaceOptions,
  "ResourceTypeRegistrationMarketplaceOptions",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesMarketplaceOptions.addOnPlanConversionAllowed,
  "IsAddOnPlanConversionAllowed",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceCache,
  "ResourceTypeRegistrationResourceCache",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceCache.enableResourceCache,
  "IsResourceCacheEnabled",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptions,
  "ResourceTypeRegistrationResourceManagementOptions",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptionsBatchProvisioningSupport,
  "BatchProvisioningSupport",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceManagementOptionsNestedProvisioningSupport,
  "NestedProvisioningSupport",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceQueryManagement,
  "ProviderResourceQueryManagement",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesResourceTypeCommonAttributeManagement,
  "ResourceTypeCommonAttributeManagement",
  "csharp"
);
@@clientName(ResourceTypeRegistrationPropertiesRoutingRule,
  "ResourceTypeRegistrationRoutingRule",
  "csharp"
);
@@clientName(ResourceTypeSku, "ResourceTypeSkuProperties", "csharp");
@@clientName(Role, "ApplicationOwnershipRole", "csharp");
@@alternateType(RolloutStatusBase.completedRegions,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(RoutingType, "ResourceRoutingType", "csharp");
@@clientName(ServiceStatus, "ResourceProviderServiceStatus", "csharp");
@@clientName(SkuCapability, "ResourceSkuCapability", "csharp");
@@clientName(SkuCapacity, "ResourceTypeSkuCapacity", "csharp");
@@clientName(SkuCost, "ResourceTypeSkuCost", "csharp");
@@clientName(SkuLocationInfo, "ResourceTypeSkuLocationInfo", "csharp");
@@clientName(SkuLocationInfo.type, "LocationType", "csharp");
@@clientName(SkuResource, "ResourceTypeSku", "csharp");
@@clientName(SkuResourceArrayResponseWithContinuation,
  "ResourceTypeSkuListResult",
  "csharp"
);
@@clientName(SkuScaleType, "ResourceTypeSkuScaleType", "csharp");
@@clientName(SkuSetting, "ResourceTypeSkuSetting", "csharp");
@@clientName(SkuZoneDetail, "ResourceTypeSkuZoneDetail", "csharp");
@@clientName(SubscriptionState, "ProviderSubscriptionState", "csharp");
@@clientName(SubscriptionStateRule, "ProviderSubscriptionStateRule", "csharp");
@@clientName(SupportedOperations,
  "ResourceManagementSupportedOperation",
  "csharp"
);
@@clientName(TemplateDeploymentOptions.preflightSupported,
  "IsPreflightSupported",
  "csharp"
);
@@alternateType(TrafficRegions.regions, Azure.Core.azureLocation[], "csharp");
@@alternateType(ResourceProviderEndpoint.endpointUri, url, "csharp");
@@alternateType(ResourceTypeEndpoint.endpointUri, url, "csharp");
@@alternateType(ResourceTypeExtension.endpointUri, url, "csharp");
@@alternateType(SwaggerSpecification.swaggerSpecFolderUri, url, "csharp");
@@alternateType(ResourceTypeEndpointBase.endpointUri, url, "csharp");
@@clientName(ExtendedLocationOptions,
  "ProviderHubExtendedLocationOptions",
  "csharp"
);
@@clientName(ProvisioningState, "ProviderHubProvisioningState", "csharp");
@@clientName(IdentityManagementTypes, "IdentityManagementType", "csharp");
@@clientName(TemplateDeploymentCapabilities,
  "TemplateDeploymentCapability",
  "csharp"
);
@@clientName(TemplateDeploymentPreflightOptions,
  "TemplateDeploymentPreflightOption",
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.providerAuthentication,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.featuresRule,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.resourceProviderAuthorizationRules,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.notificationSettings,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.resourceGroupLockOptionDuringMove,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceProviderManifestProperties.responseOptions,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ResourceType.identityManagement,
  "csharp"
);
@@access(ResourceProviderAuthentication, Access.internal, "csharp");

@@clientName(ResourceProviderAuthentication.allowedAudiences,
  "ProviderAuthenticationAllowedAudiences",
  "csharp"
);
@@clientName(ResourceProviderManifestPropertiesNotificationSettings.subscriberSettings,
  "NotificationSubscriberSettings",
  "csharp"
);
@@clientName(ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove.blockActionVerb,
  "ResourceGroupLockOptionDuringMoveBlockActionVerb",
  "csharp"
);
@@clientName(IdentityManagement.type, "ManagementType", "csharp");
@@clientName(Intent.DEFERRED_ACCESS_CHECK, "DeferredAccessCheck", "csharp");
@@clientName(Intent.RP_CONTRACT, "RPContract", "csharp");
@@clientName(SubscriptionLifecycleNotificationSpecifications.softDeleteTTL,
  "SoftDeleteTtl",
  "csharp"
);

@@clientName(LoggingDetails, "LoggingDetail", "csharp");
@@clientName(LoggingDirections, "LoggingDirection", "csharp");
@@clientName(SkipNotifications, "SkipNotification", "csharp");
@@clientName(TemplateDeploymentPreflightNotifications,
  "TemplateDeploymentPreflightNotification",
  "csharp"
);

@@clientName(SkuResources, "ResourceTypeSku", "csharp");
@@clientName(Skus, "NestedResourceTypeFirstSku", "csharp");
@@clientName(SkuResourceOperations, "NestedResourceTypeSecondSku", "csharp");
@@clientName(SkuResourceOperationGroup, "NestedResourceTypeThirdSku", "csharp");
@@clientName(NewRegionFrontloadRelease,
  "RegistrationNewRegionFrontloadReleases",
  "csharp"
);

@@alternateType(AuthorizedApplication.name, Azure.Core.uuid, "csharp");

@@access(ManifestLevelPropertyBag, Access.public, "csharp");

@@alternateType(SkuLocationInfo.location, Azure.Core.azureLocation, "csharp");

@@alternateType(ResourceManagementEntity.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@clientName(ProviderRegistrations.deleteResources,
  "DeleteResourcesResourceAction",
  "csharp"
);
@@clientName(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest,
  "GenerateManifestNewRegionFrontloadRelease",
  "csharp"
);

@@clientName(IdentityManagementProperties.type, "ManagementType", "csharp");
@@clientName(ThrottlingMetric.type, "MetricType", "csharp");
@@clientName(TypedErrorInfo.type, "TypedErrorInfoType", "csharp");

@@alternateType(DefaultRolloutSpecificationExpeditedRollout,
  ExpeditedRolloutDefinition,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationCanary,
  CanaryTrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationLowTraffic,
  TrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationMediumTraffic,
  TrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationHighTraffic,
  TrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationRestOfTheWorldGroupOne,
  TrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationRestOfTheWorldGroupTwo,
  TrafficRegionRolloutConfiguration,
  "csharp"
);
@@alternateType(DefaultRolloutSpecificationProviderRegistration,
  ProviderRegistration,
  "csharp"
);

@@alternateType(CustomRolloutPropertiesSpecification,
  CustomRolloutSpecification,
  "csharp"
);
@@alternateType(CustomRolloutPropertiesStatus, CustomRolloutStatus, "csharp");

@@alternateType(DefaultRolloutPropertiesSpecification,
  DefaultRolloutSpecification,
  "csharp"
);
@@alternateType(DefaultRolloutPropertiesStatus, DefaultRolloutStatus, "csharp");

@@alternateType(CustomRolloutSpecificationCanary, TrafficRegions, "csharp");
@@alternateType(CustomRolloutSpecificationProviderRegistration,
  ProviderRegistration,
  "csharp"
);

@@alternateType(CustomRolloutStatusManifestCheckinStatus,
  CheckinManifestInfo,
  "csharp"
);

@@alternateType(DefaultRolloutStatusManifestCheckinStatus,
  CheckinManifestInfo,
  "csharp"
);

@@alternateType(ResourceTypeRegistrationPropertiesExtensionOptions,
  ResourceTypeExtensionOptions,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesFeaturesRule,
  FeaturesRule,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications,
  SubscriptionLifecycleNotificationSpecifications,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesIdentityManagement,
  IdentityManagementProperties,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesCheckNameAvailabilitySpecifications,
  CheckNameAvailabilitySpecifications,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesRequestHeaderOptions,
  RequestHeaderOptions,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesTemplateDeploymentOptions,
  TemplateDeploymentOptions,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesResourceMovePolicy,
  ResourceMovePolicy,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesResourceGraphConfiguration,
  ResourceGraphConfiguration,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesManagement,
  ResourceProviderManagement,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesTemplateDeploymentPolicy,
  TemplateDeploymentPolicy,
  "csharp"
);
@@alternateType(ResourceTypeRegistrationPropertiesDstsConfiguration,
  DstsConfiguration,
  "csharp"
);

@@alternateType(LoggingRuleHiddenPropertyPaths,
  LoggingHiddenPropertyPath,
  "csharp"
);

@@usage(ResourceProviderAuthentication, Usage.input | Usage.output, "csharp");
@@usage(FeaturesRule, Usage.input | Usage.output, "csharp");
@@access(FeaturesRule, Access.public, "csharp");
@@usage(PrivateResourceProviderConfiguration,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(IdentityManagement, Usage.input | Usage.output, "csharp");

@@alternateType(ProviderRegistrationPropertiesProviderHubMetadata,
  ProviderHubMetadata,
  "csharp"
);
@@alternateType(ProviderHubMetadataProviderAuthentication,
  ResourceProviderAuthentication,
  "csharp"
);
@@alternateType(ProviderHubMetadataThirdPartyProviderAuthorization,
  ThirdPartyProviderAuthorization,
  "csharp"
);
@@alternateType(ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications,
  SubscriptionLifecycleNotificationSpecifications,
  "csharp"
);
@@alternateType(ProviderRegistrationPropertiesPrivateResourceProviderConfiguration,
  PrivateResourceProviderConfiguration,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesProviderAuthentication,
  ResourceProviderAuthentication,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesFeaturesRule,
  FeaturesRule,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesRequestHeaderOptions,
  RequestHeaderOptions,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesManagement,
  ResourceProviderManagement,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesTemplateDeploymentOptions,
  TemplateDeploymentOptions,
  "csharp"
);
@@alternateType(ResourceProviderManifestPropertiesDstsConfiguration,
  DstsConfiguration,
  "csharp"
);
@@alternateType(ResourceProviderEndpointFeaturesRule, FeaturesRule, "csharp");
@@alternateType(FanoutLinkedNotificationRuleDstsConfiguration,
  DstsConfiguration,
  "csharp"
);
@@alternateType(ResourceTypeEndpointFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeEndpointDstsConfiguration,
  DstsConfiguration,
  "csharp"
);
@@alternateType(ResourceTypeExtensionOptionsResourceCreationBegin,
  ExtensionOptions,
  "csharp"
);
@@alternateType(ResourceProviderManifestProviderAuthentication,
  ResourceProviderAuthentication,
  "csharp"
);
@@alternateType(ResourceProviderManifestFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceProviderManifestRequestHeaderOptions,
  RequestHeaderOptions,
  "csharp"
);
@@alternateType(ResourceProviderManifestManagement,
  ResourceProviderManagement,
  "csharp"
);
@@alternateType(ResourceProviderManifestReRegisterSubscriptionMetadata,
  ReRegisterSubscriptionMetadata,
  "csharp"
);
@@alternateType(ResourceTypeIdentityManagement, IdentityManagement, "csharp");
@@alternateType(ResourceTypeFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeRequestHeaderOptions,
  RequestHeaderOptions,
  "csharp"
);
@@alternateType(ResourceTypeTemplateDeploymentPolicy,
  TemplateDeploymentPolicy,
  "csharp"
);
@@alternateType(OperationsDefinitionDisplay,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(OperationsPutContentProperties,
  OperationsContentProperties,
  "csharp"
);
@@alternateType(LocalizedOperationDefinitionDisplay,
  LocalizedOperationDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionDefault,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionEn,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionCs,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionDe,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionEs,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionFr,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionHu,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionIt,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionJa,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionKo,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionNl,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionPl,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionPtBR,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionPtPT,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionRu,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionSv,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionZhHans,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(LocalizedOperationDisplayDefinitionZhHant,
  OperationsDisplayDefinition,
  "csharp"
);
@@alternateType(SkuResourceProperties, ResourceTypeSku, "csharp");
@@alternateType(SkuSettingCapacity, SkuCapacity, "csharp");
@@alternateType(FrontloadPayloadPropertiesOverrideManifestLevelFields,
  ManifestLevelPropertyBag,
  "csharp"
);
@@alternateType(FrontloadPayloadPropertiesOverrideEndpointLevelFields,
  ResourceTypeEndpointBase,
  "csharp"
);
@@alternateType(ResourceTypeEndpointBaseFeaturesRule, FeaturesRule, "csharp");
@@alternateType(ResourceTypeEndpointBaseDstsConfiguration,
  DstsConfiguration,
  "csharp"
);
