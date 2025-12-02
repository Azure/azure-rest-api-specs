import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedVirtualNetworkResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Managed private endpoint resource type.
 */
@parentResource(ManagedVirtualNetworkResource)
model ManagedPrivateEndpointResource
  is Azure.ResourceManager.ProxyResource<ManagedPrivateEndpoint, false> {
  ...ResourceNameParameter<
    Resource = ManagedPrivateEndpointResource,
    KeyName = "managedPrivateEndpointName",
    SegmentName = "managedPrivateEndpoints",
    NamePattern = "^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ManagedPrivateEndpointResources {
  /**
   * Gets a managed private endpoint.
   */
  get is ArmResourceRead<
    ManagedPrivateEndpointResource,
    Parameters = {
      /**
       * ETag of the managed private endpoint entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a managed private endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedPrivateEndpointResource,
    Parameters = {
      /**
       * ETag of the managed private endpoint entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<ManagedPrivateEndpointResource>,
    Error = CloudError
  >;

  /**
   * Deletes a managed private endpoint.
   */
  delete is ArmResourceDeleteSync<
    ManagedPrivateEndpointResource,
    Error = CloudError
  >;

  /**
   * Lists managed private endpoints.
   */
  listByFactory is ArmResourceListByParent<
    ManagedPrivateEndpointResource,
    Response = ArmResponse<ManagedPrivateEndpointListResponse>,
    Error = CloudError
  >;
}

@@maxLength(ManagedPrivateEndpointResource.name, 127);
@@minLength(ManagedPrivateEndpointResource.name, 1);
@@doc(ManagedPrivateEndpointResource.name, "Managed private endpoint name");
@@doc(ManagedPrivateEndpointResource.properties,
  "Managed private endpoint properties."
);
@@doc(ManagedPrivateEndpointResources.createOrUpdate::parameters.resource,
  "Managed private endpoint resource definition."
);
