import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App session pool.
 */
model SessionPool
  is Azure.ResourceManager.TrackedResource<SessionPoolProperties> {
  ...ResourceNameParameter<
    Resource = SessionPool,
    KeyName = "sessionPoolName",
    SegmentName = "sessionPools",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ContainerAppsSessionPools {
  /**
   * Get the properties of a session pool.
   */
  @summary("Get the properties of a session pool.")
  get is ArmResourceRead<SessionPool>;

  /**
   * Create or update a session pool with the given properties.
   */
  @summary("Create or update a session pool.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SessionPool>;

  /**
   * Patches a session pool using JSON merge patch
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a session pool")
  update is ArmCustomPatchAsync<
    SessionPool,
    PatchModel = SessionPoolUpdatableProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SessionPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the session pool with the given name.
   */
  @summary("Delete a session pool.")
  delete is ArmResourceDeleteWithoutOkAsync<SessionPool>;

  /**
   * Get the session pools in a given resource group of a subscription.
   */
  @summary("Get the session pools in a given resource group of a subscription.")
  listByResourceGroup is ArmResourceListByParent<
    SessionPool,
    Response = ArmResponse<SessionPoolCollection>
  >;

  /**
   * Get the session pools in a given subscription.
   */
  @summary("Get the session pools in a given subscription.")
  listBySubscription is ArmListBySubscription<
    SessionPool,
    Response = ArmResponse<SessionPoolCollection>
  >;

  /**
   * Fetch the MCP server credentials of a session pool.
   */
  @summary("Fetch the MCP server credentials of a session pool.")
  fetchMcpServerCredentials is ArmResourceActionSync<
    SessionPool,
    void,
    ArmResponse<McpServerCredential>
  >;

  /**
   * Rotate and fetch the rotated MCP server credentials of a session pool.
   */
  @summary("Rotate and fetch the rotated MCP server credentials of a session pool.")
  rotateMcpServerCredentials is ArmResourceActionSync<
    SessionPool,
    void,
    ArmResponse<McpServerCredential>
  >;
}

@@maxLength(SessionPool.name, 63);
@@minLength(SessionPool.name, 3);
@@doc(SessionPool.name, "Name of the session pool.");
@@doc(SessionPool.properties,
  "Container App session pool resource specific properties"
);
@@doc(ContainerAppsSessionPools.createOrUpdate::parameters.resource,
  "Properties used to create a session pool"
);
@@doc(ContainerAppsSessionPools.update::parameters.properties,
  "Properties used to create a session pool"
);
