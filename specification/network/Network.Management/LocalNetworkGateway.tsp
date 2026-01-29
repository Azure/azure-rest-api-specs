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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model LocalNetworkGateway extends Resource {
  properties: LocalNetworkGatewayPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("localNetworkGatewayName")
  @segment("localNetworkGateways")
  name: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
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
