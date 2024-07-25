import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;
/**
 * An Edge Aggregation resource for update
 */
model Update is Azure.ResourceManager.ExtensionResource<UpdateProperties> {
  /**
   * Name of update
   */
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("updateName")
  @segment("updates")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Updates {
  /**
   * Get a Update
   */
  get is ArmResourceRead<Update>;

  /**
   * Create an Update
   */
  createOrModify is ArmResourceCreateOrReplaceAsync<
    Update,
    BaseParameters<Update>,
    Azure.Core.Foundations.RetryAfterHeader & ArmAsyncOperationHeader
  >;

  /**
   * Update a Update
   */
  @parameterVisibility
  modify is ArmCustomPatchSync<Update, ModifyUpdate>;

  /**
   * Delete an Update
   */
  delete is ArmResourceDeleteSync<Update>;

  /**
   * List Update resources by parent
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Updates_List")
  list is ArmResourceListByParent<Update>;
}
