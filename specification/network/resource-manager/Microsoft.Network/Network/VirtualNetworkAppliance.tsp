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
 * A virtual network appliance in a resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualNetworkAppliance extends Resource {
  properties?: VirtualNetworkAppliancePropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualNetworkApplianceName")
  @segment("virtualNetworkAppliances")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VirtualNetworkAppliances {
  /**
   * Gets information about the specified virtual network appliance.
   */
  get is ArmResourceRead<VirtualNetworkAppliance>;

  /**
   * Creates or updates a virtual network appliance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetworkAppliance>;

  /**
   * Updates a virtual network appliance tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualNetworkAppliance,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified virtual network appliance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetworkAppliance>;

  /**
   * Gets all virtual network appliances in a resource group.
   */
  list is ArmResourceListByParent<VirtualNetworkAppliance>;

  /**
   * Gets all virtual network appliances in a subscription.
   */
  listAll is ArmListBySubscription<VirtualNetworkAppliance>;
}

@@doc(VirtualNetworkAppliance.name,
  "The name of the virtual network appliance."
);
@@doc(VirtualNetworkAppliance.properties,
  "Properties of the virtual network appliance."
);
@@doc(VirtualNetworkAppliances.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network appliance operation."
);
@@doc(VirtualNetworkAppliances.updateTags::parameters.properties,
  "Parameters supplied to update virtual network appliance tags."
);
