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

namespace Microsoft.Cache;
/**
 * Describes the current migration operation on a Redis Enterprise cluster.
 */
@singleton("default")
@parentResource(Cluster)
model Migration is Azure.ResourceManager.ProxyResource<MigrationProperties> {
  ...ResourceNameParameter<
    Resource = Migration,
    KeyName = "migration",
    SegmentName = "migrations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Migrations {
  /**
   * Gets information about a migration in a Redis Enterprise cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migration_Get")
  get is ArmResourceRead<Migration>;

  /**
   * Starts a new migration
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migration_Start")
  start is ArmResourceCreateOrReplaceAsync<Migration>;

  /**
   * Gets information about all migrations attempts in a Redis Enterprise cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migration_List")
  list is ArmResourceListByParent<
    Migration,
    Response = ArmResponse<MigrationList>
  >;

  /**
   * Cancel or rollback the migration operation in a Redis Enterprise cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migration_Cancel")
  cancel is ArmResourceActionAsyncBase<
    Migration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Migration>
  >;
}

@@doc(Migration.name, "");
@@doc(Migration.properties, "Properties of the migration operation.");
@@doc(Migrations.start::parameters.resource,
  "Parameters supplied to start a migration operation."
);
