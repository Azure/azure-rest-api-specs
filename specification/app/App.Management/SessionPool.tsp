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
interface SessionPools {
  /**
   * Get the properties of a session pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_Get")
  get is ArmResourceRead<SessionPool>;

  /**
   * Create or update a session pool with the given properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SessionPool>;

  /**
   * Patches a session pool using JSON merge patch
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SessionPool,
    PatchModel = SessionPoolUpdatableProperties,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SessionPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete the session pool with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<SessionPool>;

  /**
   * Get the session pools in a given resource group of a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SessionPool,
    Response = ArmResponse<SessionPoolCollection>
  >;

  /**
   * Get the session pools in a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    SessionPool,
    Response = ArmResponse<SessionPoolCollection>
  >;

  /**
   * Fetch the MCP server credentials of a session pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_FetchMcpServerCredentials")
  fetchMcpServerCredentials is ArmResourceActionSync<
    SessionPool,
    void,
    ArmResponse<McpServerCredential>
  >;

  /**
   * Rotate and fetch the rotated MCP server credentials of a session pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSessionPools_RotateMcpServerCredentials")
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
@@doc(SessionPools.createOrUpdate::parameters.resource,
  "Properties used to create a session pool"
);
@@doc(SessionPools.update::parameters.properties,
  "Properties used to create a session pool"
);
