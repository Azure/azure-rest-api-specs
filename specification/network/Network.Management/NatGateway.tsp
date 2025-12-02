import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Nat Gateway resource.
 */
model NatGateway
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NatGatewayPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NatGateway,
    KeyName = "natGatewayName",
    SegmentName = "natGateways",
    NamePattern = ""
  >;

  /**
   * The nat gateway SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: NatGatewaySku;

  ...Azure.ResourceManager.AvailabilityZonesProperty;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NatGateways {
  /**
   * Gets the specified nat gateway in a specified resource group.
   */
  get is ArmResourceRead<
    NatGateway,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a nat gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NatGateway,
    Response = ArmResourceUpdatedResponse<NatGateway> | ArmResourceCreatedResponse<NatGateway> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader> &
      Azure.Core.Foundations.RetryAfterHeader),
    Error = CloudError
  >;

  /**
   * Updates nat gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NatGateway,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified nat gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    NatGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all nat gateways in a resource group.
   */
  list is ArmResourceListByParent<NatGateway, Error = CloudError>;

  /**
   * Gets all the Nat Gateways in a subscription.
   */
  listAll is ArmListBySubscription<NatGateway, Error = CloudError>;
}

@@doc(NatGateway.name, "The name of the nat gateway.");
@@doc(NatGateway.properties, "Nat Gateway properties.");
@@doc(NatGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update nat gateway operation."
);
@@doc(NatGateways.updateTags::parameters.properties,
  "Parameters supplied to update nat gateway tags."
);
