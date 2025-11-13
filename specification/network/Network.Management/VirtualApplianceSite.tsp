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
@parentResource(NetworkVirtualAppliance)
model VirtualApplianceSite
  is Azure.ResourceManager.ProxyResource<VirtualApplianceSiteProperties> {
  ...ResourceNameParameter<
    Resource = VirtualApplianceSite,
    KeyName = "siteName",
    SegmentName = "virtualApplianceSites",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VirtualApplianceSites {
  /**
   * Gets the specified Virtual Appliance Site.
   */
  get is ArmResourceRead<VirtualApplianceSite>;

  /**
   * Creates or updates the specified Network Virtual Appliance Site.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualApplianceSite>;

  /**
   * Deletes the specified site from a Virtual Appliance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualApplianceSite,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Network Virtual Appliance Sites in a Network Virtual Appliance resource.
   */
  list is ArmResourceListByParent<VirtualApplianceSite>;
}

@@doc(VirtualApplianceSite.name, "The name of the site.");
@@doc(VirtualApplianceSite.properties,
  "The properties of the Virtual Appliance Sites."
);
@@doc(VirtualApplianceSites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance Site operation."
);
