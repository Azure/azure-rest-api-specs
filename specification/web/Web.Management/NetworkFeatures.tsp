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

namespace Microsoft.CertificateRegistration;
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
}

@armResourceOperations
interface NetworkFeaturesOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = NetworkFeatures,
        KeyName = "view",
        SegmentName = "networkFeatures",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface NetworkFeaturesOperationGroup {
  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListNetworkFeatures")
  listNetworkFeatures is NetworkFeaturesOperationGroupOps.Read<NetworkFeatures>;
}
@armResourceOperations
interface NetworkFeaturesOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = NetworkFeatures,
        KeyName = "view",
        SegmentName = "networkFeatures",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface NetworkFeaturesOperationGroup {
  /**
   * Description for Gets all network features used by the app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListNetworkFeaturesSlot")
  listNetworkFeaturesSlot is NetworkFeaturesOperationGroupOps.Read<NetworkFeatures>;
}

@@doc(NetworkFeatures.name,
  "The type of view. Only ",
  summary,
  " is supported at this time."
);
@@doc(NetworkFeatures.properties,
  "NetworkFeatures resource specific properties"
);
