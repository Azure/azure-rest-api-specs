import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a cluster role.
 */
@parentResource(Cluster)
model Role is ProxyResource<RoleProperties> {
  /**
   * The name of the cluster role.
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("roleName")
  @segment("roles")
  name: string;
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
  create is ArmResourceCreateOrReplaceAsync<
    Role,
    BaseParameters<Role>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a cluster role.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Role,
    BaseParameters<Role>,
    ArmLroLocationHeader
  >;

  /**
   * List all the roles in a given cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Roles_ListByCluster")
  listByCluster is ArmResourceListByParent<Role>;
}

@@projectedName(Roles.create::parameters.resource, "json", "parameters");
@@extension(Roles.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Roles.create::parameters.resource,
  "The required parameters for creating or updating a role."
);
