import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;

/**
 * Contains metadata of the SkuMixPlacement scoring resource
 */
@singleton("recommendations")
@parentResource(SubscriptionLocationResource)
model SkuMixPlacementBase
  is Azure.ResourceManager.ProxyResource<SkuMixPlacementProperties> {
  ...ResourceNameParameter<
    Resource = SkuMixPlacementBase,
    KeyName = "mixPlacementScore",
    SegmentName = "mixPlacementScores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SkuMixPlacementScores {
  /**
   * Gets SkuMixPlacement scoring metadata.
   */
  get is ArmResourceRead<SkuMixPlacementBase>;

  /**
   * Generates placement scores for VM SKU mix placement.
   */
  @action("generate")
  post is ArmResourceActionSync<
    SkuMixPlacementBase,
    SkuMixPlacementRequest,
    ArmResponse<SkuMixPlacementResponse>
  >;
}

@@clientName(SkuMixPlacementScores.post::parameters.body,
  "skuMixPlacementRequest"
);
@@doc(SkuMixPlacementScores.post::parameters.body,
  "SkuMixPlacement request object supplied in the body of the generate operation."
);
