import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Managed Virtual Network resource type.
 */
@parentResource(Factory)
model ManagedVirtualNetworkResource
  is Azure.ResourceManager.ProxyResource<ManagedVirtualNetwork, false> {
  ...ResourceNameParameter<
    Resource = ManagedVirtualNetworkResource,
    KeyName = "managedVirtualNetworkName",
    SegmentName = "managedVirtualNetworks",
    NamePattern = "^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedVirtualNetworkResources {
  /**
   * Gets a managed Virtual Network.
   */
  get is ArmResourceRead<
    ManagedVirtualNetworkResource,
    Parameters = {
      /**
       * ETag of the managed Virtual Network entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a managed Virtual Network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedVirtualNetworkResource,
    Parameters = {
      /**
       * ETag of the managed Virtual Network entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<ManagedVirtualNetworkResource>,
    Error = CloudError
  >;

  /**
   * Lists managed Virtual Networks.
   */
  listByFactory is ArmResourceListByParent<
    ManagedVirtualNetworkResource,
    Response = ArmResponse<ManagedVirtualNetworkListResponse>,
    Error = CloudError
  >;
}

@@maxLength(ManagedVirtualNetworkResource.name, 127);
@@minLength(ManagedVirtualNetworkResource.name, 1);
@@doc(ManagedVirtualNetworkResource.name, "Managed virtual network name");
@@doc(ManagedVirtualNetworkResource.properties,
  "Managed Virtual Network properties."
);
@@doc(ManagedVirtualNetworkResources.createOrUpdate::parameters.resource,
  "Managed Virtual Network resource definition."
);
