import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkVirtualAppliance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Virtual Appliance Site resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NetworkVirtualAppliance)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualApplianceSite extends SubResourceModel {
  properties?: VirtualApplianceSiteProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("siteName")
  @segment("virtualApplianceSites")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VirtualApplianceSites {
  /**
   * Gets the specified Virtual Appliance Site.
   */
  get is ArmResourceRead<VirtualApplianceSite, Error = CloudError>;

  /**
   * Creates or updates the specified Network Virtual Appliance Site.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualApplianceSite,
    Error = CloudError
  >;

  /**
   * Deletes the specified site from a Virtual Appliance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualApplianceSite,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Network Virtual Appliance Sites in a Network Virtual Appliance resource.
   */
  list is ArmResourceListByParent<
    VirtualApplianceSite,
    Response = NetworkVirtualApplianceSiteListResult,
    Error = CloudError
  >;
}

@@doc(VirtualApplianceSite.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VirtualApplianceSite.properties,
  "The properties of the Virtual Appliance Sites."
);
@@doc(VirtualApplianceSites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance Site operation."
);
