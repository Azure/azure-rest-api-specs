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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Migrations {
  /**
   * Gets information about a migration in a Redis Enterprise cluster.
   */
  get is ArmResourceRead<Migration>;

  /**
   * Starts a new migration
   */
  @Azure.Core.useFinalStateVia("original-uri")
  start is ArmResourceCreateOrReplaceAsync<
    Migration,
    Response = (ArmResponse<Migration> &
      ArmCombinedLroHeaders<FinalResult = Migration>) | (ArmCreatedResponse<Migration> &
      ArmCombinedLroHeaders<FinalResult = Migration>)
  >;

  /**
   * Gets information about all migrations attempts in a Redis Enterprise cluster.
   */
  list is ArmResourceListByParent<
    Migration,
    Response = ArmResponse<MigrationList>
  >;

  /**
   * Cancel or rollback the migration operation in a Redis Enterprise cluster.
   */
  cancel is ArmResourceActionAsyncBase<
    Migration,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Migration>
  >;
}

@@doc(Migration.name, "");
@@doc(Migration.properties, "Properties of the migration operation.");
@@doc(Migrations.start::parameters.resource,
  "Parameters supplied to start a migration operation."
);
