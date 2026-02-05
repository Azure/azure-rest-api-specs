import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster role.
 */
@parentResource(Cluster)
model Role is Azure.ResourceManager.ProxyResource<RoleProperties, false> {
  ...ResourceNameParameter<
    Resource = Role,
    KeyName = "roleName",
    SegmentName = "roles",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface Roles {
  /**
   * Gets information about a cluster role.
   */
  get is ArmResourceRead<Role>;

  /**
   * Creates a new role or updates an existing role.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    Role,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Role> &
      ArmLroLocationHeader<FinalResult = Role>
  >;

  /**
   * Deletes a cluster role.
   */
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    Role,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Role> &
      ArmLroLocationHeader<FinalResult = Role>
  >;

  /**
   * List all the roles in a given cluster.
   */
  listByCluster is ArmResourceListByParent<
    Role,
    Response = ArmResponse<ResourceListResult<Role>>
  >;
}

@@doc(Role.name, "The name of the cluster role.");
@@doc(Role.properties, "The properties of a role.");
@@doc(Roles.create::parameters.resource,
  "The required parameters for creating or updating a role."
);
