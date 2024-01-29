import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IntegrationSpaces;
/**
 * An integration space.
 */
model Space is TrackedResource<SpaceResourceProperties> {
  /**
   * The name of the space
   */
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  @path
  @key("spaceName")
  @segment("spaces")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Spaces {
  /**
   * Get a Space
   */
  get is ArmResourceRead<Space>;

  /**
   * Create a Space
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Space>;

  /**
   * Update a Space
   */
  @parameterVisibility("read")
  patch is ArmCustomPatchSync<Space, SpaceUpdate>;

  /**
   * Delete a Space
   */
  delete is ArmResourceDeleteSync<Space>;

  /**
   * List Space resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Spaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Space,
    {
      ...BaseParameters<Space>;

      ...TopQueryParameter;

      ...SkipQueryParameter;

      ...MaxPageSizeQueryParameter;

      ...FilterQueryParameter;

      ...SelectQueryParameter;

      ...ExpandQueryParameter;

      ...OrderByQueryParameter;
    }
  >;

  /**
   * List Space resources by subscription ID
   */
  listBySubscription is ArmListBySubscription<Space>;
}
