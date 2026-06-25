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

namespace Microsoft.ExtendedLocation {
  @@scope(CustomLocations.update, "!javascript");
  @@scope(ResourceSyncRules.update, "!javascript");

  @armResourceOperations
  interface CustomLocationsScope {
    #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "client customization"
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
    update(
      ...Azure.ResourceManager.Foundations.DefaultBaseParameters<customLocation>,
      ...Azure.ResourceManager.ProviderNamespace<customLocation>,

      @path
      @segment("customLocations")
      resourceName: string,

      /**
       * Identity for the resource.
       */
      identity?: Identity,

      ...customLocationProperties,

      /**
       * Resource tags
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      tags?: Record<string>,
    ):
      | Azure.ResourceManager.ArmResponse<Microsoft.ExtendedLocation.customLocation>
      | Azure.ResourceManager.CommonTypes.ErrorResponse;
  }
  @armResourceOperations
  interface ResourceSyncRulesScope {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
    update(
      ...Azure.ResourceManager.Foundations.DefaultBaseParameters<resourceSyncRule>,
      ...Azure.ResourceManager.ProviderNamespace<resourceSyncRule>,

      @path
      @segment("customLocations")
      resourceName: string,

      @path
      @segment("resourceSyncRules")
      childResourceName: string,

      ...resourceSyncRuleProperties,

      /**
       * Resource tags
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      tags?: Record<string>,
    ):
      | (ArmResponse<resourceSyncRule> &
          ArmAsyncOperationHeader<FinalResult = resourceSyncRule> &
          Azure.Core.Foundations.RetryAfterHeader)
      | Azure.ResourceManager.CommonTypes.ErrorResponse;
  }

  @@scope(CustomLocationsScope.update, "javascript");
  @@scope(ResourceSyncRulesScope.update, "javascript");
  @@clientLocation(
    CustomLocationsScope.update,
    "CustomLocations",
    "javascript"
  );
  @@clientLocation(
    ResourceSyncRulesScope.update,
    "ResourceSyncRules",
    "javascript"
  );
}
