import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

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

@@override(CustomLocations.update, customLocationsUpdate, "javascript");
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op customLocationsUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  provider: "Microsoft.ExtendedLocation",
  resourceName: string,

  /**
   * Identity for the resource.
   */
  identity?: Identity,

  properties?: customLocationProperties,

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.ExtendedLocation.customLocation>
  | Azure.ResourceManager.CommonTypes.ErrorResponse;
@@override(ResourceSyncRules.update, resourceSyncRulesUpdate, "javascript");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op resourceSyncRulesUpdate(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  provider: "Microsoft.ExtendedLocation",
  resourceName: string,
  childResourceName: string,
  properties?: resourceSyncRuleProperties,

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>,
):
  | {
      statusCode: 200;
      body: Microsoft.ExtendedLocation.resourceSyncRule;
      azureAsyncOperation: string;
      retryAfter: int32;
    }
  | Azure.ResourceManager.CommonTypes.ErrorResponse;
