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
 * A common class for general resource information.
 */
model LocalNetworkGateway
  is Azure.ResourceManager.ProxyResource<
    LocalNetworkGatewayPropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = LocalNetworkGateway,
    KeyName = "localNetworkGatewayName",
    SegmentName = "localNetworkGateways",
    NamePattern = ""
  >;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface LocalNetworkGateways {
  /**
   * Gets the specified local network gateway in a resource group.
   */
  get is ArmResourceRead<LocalNetworkGateway, Error = CloudError>;

  /**
   * Creates or updates a local network gateway in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LocalNetworkGateway,
    Error = CloudError
  >;

  /**
   * Updates a local network gateway tags.
   */
  @patch(#{ implicitOptionality: false })
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateTags is ArmCustomPatchSync<
    LocalNetworkGateway,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified local network gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    LocalNetworkGateway,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the local network gateways in a resource group.
   */
  list is ArmResourceListByParent<LocalNetworkGateway, Error = CloudError>;
}

@@minLength(LocalNetworkGateway.name, 1);
@@doc(LocalNetworkGateway.name, "The name of the local network gateway.");
@@doc(LocalNetworkGateway.properties,
  "Properties of the local network gateway."
);
@@doc(LocalNetworkGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update local network gateway operation."
);
@@doc(LocalNetworkGateways.updateTags::parameters.properties,
  "Parameters supplied to update local network gateway tags."
);
