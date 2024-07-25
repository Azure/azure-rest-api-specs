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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
namespace Microsoft.Edge;
/**
 * A Microsoft.Edge connectivity status resource
 */
model ConnectivityStatus
  is Azure.ResourceManager.ExtensionResource<ConnectivityStatusProperties> {
  /**
   * Name of ConnectivityStatus
   */
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("connectivityStatusName")
  @segment("connectivityStatuses")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ConnectivityStatuses {
  /**
   * Get a ConnectivityStatus
   */
  get is ArmResourceRead<ConnectivityStatus>;

  /**
   * Create a ConnectivityStatus
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConnectivityStatus,
    BaseParameters<ConnectivityStatus>,
    ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a ConnectivityStatus
   */
  @parameterVisibility
  update is ArmCustomPatchSync<ConnectivityStatus, ConnectivityStatusUpdate>;

  /**
   * Delete a ConnectivityStatus
   */
  delete is ArmResourceDeleteSync<ConnectivityStatus>;

  /**
   * List ConnectivityStatus resources by parent
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectivityStatuses_List")
  list is ArmResourceListByParent<ConnectivityStatus>;
}
