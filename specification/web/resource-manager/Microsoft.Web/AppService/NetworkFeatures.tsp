import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Full view of network features for an app (presently VNET integration and Hybrid Connections).
 */
@parentResource(Site)
model NetworkFeatures
  is Azure.ResourceManager.ProxyResource<NetworkFeaturesProperties> {
  ...ResourceNameParameter<
    Resource = NetworkFeatures,
    KeyName = "view",
    SegmentName = "networkFeatures",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface NetworkFeaturesOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** The type of view. Only "summary" is supported at this time. */
        @path
        @segment("networkFeatures")
        @key
        view: string,
      }
    > {}

@armResourceOperations
interface NetworkFeaturesOperationGroup {
  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  @summary("Gets all network features used by the app (or deployment slot, if specified).")
  listNetworkFeatures is NetworkFeaturesOperationGroupOps.Read<
    NetworkFeatures,
    Response = ArmResponse<NetworkFeatures> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface NetworkFeaturesSlotOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get network features for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** The type of view. Only "summary" is supported at this time. */
        @path
        @segment("networkFeatures")
        @key
        view: string,
      }
    > {}
@armResourceOperations
interface NetworkFeaturesSlotOperationGroup {
  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  @summary("Gets all network features used by the app (or deployment slot, if specified).")
  listNetworkFeaturesSlot is NetworkFeaturesSlotOperationGroupOps.Read<
    NetworkFeatures,
    Response = ArmResponse<NetworkFeatures> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@@doc(NetworkFeatures.properties,
  "NetworkFeatures resource specific properties"
);
