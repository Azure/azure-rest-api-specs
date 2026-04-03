import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes an Arc Gateway.
 */
model Gateway is Azure.ResourceManager.TrackedResource<GatewayProperties> {
  ...ResourceNameParameter<
    Resource = Gateway,
    KeyName = "gatewayName",
    SegmentName = "gateways",
    NamePattern = "[a-zA-Z0-9-_\\.]+"
  >;
}

@armResourceOperations
interface Gateways {
  /**
   * Retrieves information about the view of a gateway.
   */
  get is ArmResourceRead<Gateway>;

  /**
   * The operation to create or update a gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Gateway,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Gateway> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update a gateway.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Gateway, PatchModel = GatewayUpdate>;

  /**
   * The operation to delete a gateway.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Gateway,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = Gateway>
  >;

  /**
   * The operation to get all gateways of a non-Azure machine
   */
  listByResourceGroup is ArmResourceListByParent<Gateway>;

  /**
   * The operation to get all gateways of a non-Azure machine
   */
  listBySubscription is ArmListBySubscription<Gateway>;
}

@@doc(Gateway.name, "The name of the Gateway.");
@@doc(Gateway.properties, "Hybrid Compute Gateway properties");
@@doc(Gateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create gateway operation."
);
@@doc(Gateways.update::parameters.properties,
  "Parameters supplied to the Update gateway operation."
);
