import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Space.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IntegrationSpaces;
/**
 * An infrastructure resource under Space.
 */
@parentResource(Space)
model InfrastructureResource
  is ProxyResource<InfrastructureResourceProperties> {
  /**
   * The name of the infrastructure resource in the space.
   */
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  @path
  @key("infrastructureResourceName")
  @segment("infrastructureResources")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface InfrastructureResources {
  /**
   * Get a InfrastructureResource
   */
  get is ArmResourceRead<InfrastructureResource>;

  /**
   * Create a InfrastructureResource
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<InfrastructureResource>;

  /**
   * Update a InfrastructureResource
   */
  @parameterVisibility("read")
  patch is ArmCustomPatchSync<
    InfrastructureResource,
    InfrastructureResourceUpdate
  >;

  /**
   * Delete a InfrastructureResource
   */
  delete is ArmResourceDeleteSync<InfrastructureResource>;

  /**
   * List InfrastructureResource resources by Space
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InfrastructureResources_ListBySpace")
  listBySpace is ArmResourceListByParent<
    InfrastructureResource,
    {
      ...BaseParameters<InfrastructureResource>;

      ...TopQueryParameter;

      ...SkipQueryParameter;

      ...MaxPageSizeQueryParameter;

      ...FilterQueryParameter;

      ...SelectQueryParameter;

      ...ExpandQueryParameter;

      ...OrderByQueryParameter;
    }
  >;
}
