import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;
using Azure.Core;
using Azure.ResourceManager;

@@clientName(
  Microsoft.ExtendedLocation,
  "CustomLocationsManagementClient",
  "javascript"
);
@@clientName(Microsoft.ExtendedLocation, "CustomLocationsMgmtClient", "python");

// C# client name mappings to match the previous GA API surface
@@clientName(
  customLocationPropertiesAuthentication,
  "CustomLocationAuthentication",
  "csharp"
);
@@clientName(HostType, "CustomLocationHostType", "csharp");
@@clientName(
  EnabledResourceType,
  "CustomLocationEnabledResourceType",
  "csharp"
);
@@clientName(
  EnabledResourceTypePropertiesTypesMetadataItem,
  "CustomLocationEnabledResourceTypeMetadata",
  "csharp"
);
@@clientName(
  EnabledResourceTypesListResult,
  "CustomLocationEnabledResourceTypesResult",
  "csharp"
);

// Map custom Identity model to ARM common type ManagedServiceIdentity
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(
  customLocation.identity,
  CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  patchableCustomLocations.identity,
  CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// Rename CustomLocationOperation to avoid AZC0033 naming violation
@@clientName(customLocationOperation, "CustomLocationOperationInfo", "csharp");

// Fix camelCase resource/model names to PascalCase for C#
@@clientName(customLocation, "CustomLocation", "csharp");
@@clientName(resourceSyncRule, "ResourceSyncRule", "csharp");
@@clientName(patchableCustomLocations, "CustomLocationPatch", "csharp");
@@clientName(patchableResourceSyncRule, "ResourceSyncRulePatch", "csharp");

// Fix property types to match previous GA API surface
@@alternateType(
  customLocationProperties.clusterExtensionIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(
  customLocationProperties.hostResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EnabledResourceTypeProperties.clusterExtensionId,
  armResourceIdentifier,
  "csharp"
);

// Preserve old property name for CustomLocationAuthentication.type
@@clientName(
  customLocationPropertiesAuthentication.type,
  "CustomLocationPropertiesAuthenticationType",
  "csharp"
);

// Rename it so that its meaning is immediately apparent.
@@clientName(
  matchExpressionsProperties,
  "ResourceSyncRuleMatchExpression",
  "csharp"
);

// Make EnabledResourceType and EnabledResourceTypeMetadata input to preserve public ctors and setters
@@usage(EnabledResourceType, Usage.input, "csharp");
@@usage(EnabledResourceTypePropertiesTypesMetadataItem, Usage.input, "csharp");
// disable update for custom locations as https://github.com/Azure/autorest.typescript/issues/3919
// @@override(CustomLocations.update, customLocationsUpdate, "javascript");
// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
// #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
// op customLocationsUpdate(
//   ...ApiVersionParameter,
//   ...SubscriptionIdParameter,
//   ...ResourceGroupParameter,
//   provider: "Microsoft.ExtendedLocation",
//   resourceName: string,

//   /**
//    * Identity for the resource.
//    */
//   identity?: Identity,

//   /**
//    * This is optional input that contains the authentication that should be used to generate the namespace.
//    */
//   authentication?: customLocationPropertiesAuthentication,

//   /**
//    * Contains the reference to the add-on that contains charts to deploy CRDs and operators.
//    */
//   clusterExtensionIds?: string[],

//   /**
//    * Display name for the Custom Locations location.
//    */
//   displayName?: string,

//   /**
//    * Connected Cluster or AKS Cluster. The Custom Locations RP will perform a checkAccess API for listAdminCredentials permissions.
//    */
//   hostResourceId?: string,

//   /**
//    * Type of host the Custom Locations is referencing (Kubernetes, etc...).
//    */
//   hostType?: HostType,

//   /**
//    * Kubernetes namespace that will be created on the specified cluster.
//    */
//   `namespace`?: string,

//   /**
//    * Provisioning State for the Custom Location.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   provisioningState?: string,

//   /**
//    * Resource tags
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   tags?: Record<string>,
// ): Azure.ResourceManager.ArmResponse<Microsoft.ExtendedLocation.customLocation> | Azure.ResourceManager.CommonTypes.ErrorResponse;
// @@override(ResourceSyncRules.update, resourceSyncRulesUpdate, "javascript");

// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
// #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
// op resourceSyncRulesUpdate(
//   ...ApiVersionParameter,
//   ...SubscriptionIdParameter,
//   ...ResourceGroupParameter,
//   provider: "Microsoft.ExtendedLocation",
//   resourceName: string,
//   childResourceName: string,

//   /**
//    * Priority represents a priority of the Resource Sync Rule
//    */
//   priority?: int32,

//   /**
//    * Provisioning State for the Resource Sync Rule.
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   @visibility(Lifecycle.Read)
//   provisioningState?: string,

//   /**
//    * A label selector is composed of two parts, matchLabels and matchExpressions. The first part, matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is 'key', the operator is 'In', and the values array contains only 'value'. The second part, matchExpressions is a list of resource selector requirements. Valid operators include In, NotIn, Exists, and DoesNotExist. The values set must be non-empty in the case of In and NotIn. The values set must be empty in the case of Exists and DoesNotExist. All of the requirements, from both matchLabels and matchExpressions must all be satisfied in order to match.
//    */
//   selector?: ResourceSyncRulePropertiesSelector,

//   /**
//    * For an unmapped custom resource, its labels will be used to find matching resource sync rules. If this resource sync rule is one of the matching rules with highest priority, then the unmapped custom resource will be projected to the target resource group associated with this resource sync rule. The user creating this resource sync rule should have write permissions on the target resource group and this write permission will be validated when creating the resource sync rule.
//    */
//   targetResourceGroup?: string,

//   /**
//    * Resource tags
//    */
//   #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
//   tags?: Record<string>,
// ): {
//   statusCode: 200;
//   body: Microsoft.ExtendedLocation.resourceSyncRule;
//   azureAsyncOperation: string;
//   retryAfter: int32;
// } | Azure.ResourceManager.CommonTypes.ErrorResponse;
