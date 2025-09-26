import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Class representing a Traffic Manager HeatMap.
 */
@parentResource(Profile)
model HeatMapModel is Azure.ResourceManager.ProxyResource<HeatMapProperties> {
  ...ResourceNameParameter<
    Resource = HeatMapModel,
    KeyName = "heatMap",
    SegmentName = "heatMaps",
    NamePattern = ""
  >;

  /** Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName} */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: Azure.Core.armResourceIdentifier;

  /** The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts" */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: Azure.Core.armResourceType;

  /** Azure Resource Manager metadata containing createdBy and modifiedBy information. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

alias HeatMapModelsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<HeatMapModel>;
  },
  {
    /**
     * The name of the Traffic Manager profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    profileName: string;

    /**
     * The type of the heatmap.
     */
    @path
    @segment("heatMaps")
    heatMapType: HeatMapType;
  },
  ErrorType = CloudError
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface HeatMapModels {
  /**
   * Gets latest heatmap for Traffic Manager profile.
   */
  get is HeatMapModelsOps.Read<
    HeatMapModel,
    Parameters = {
      /**
       * The top left latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("topLeft")
      @minItems(2)
      @maxItems(2)
      topLeft?: float64[];

      /**
       * The bottom right latitude,longitude pair of the rectangular viewport to query for.
       */
      @query("botRight")
      @minItems(2)
      @maxItems(2)
      botRight?: float64[];
    }
  >;
}

@@doc(HeatMapModel.name, "");
@@doc(HeatMapModel.properties,
  "The properties of the Traffic Manager HeatMap."
);
