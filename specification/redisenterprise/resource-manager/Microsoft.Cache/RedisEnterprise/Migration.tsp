import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Force the OpenAPI tag to remain 'Migrations' in every API version even though the interface is renamed to singular 'Migration' in versions before 2026-06-01-preview, so the already-shipped older swagger tags are preserved unchanged."
@armResourceOperations
@renamedFrom(Versions.v2026_06_01_preview, "Migration")
@tag("Migrations")
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
    Response =
      | (ArmResponse<Migration> &
          ArmCombinedLroHeaders<FinalResult = Migration>)
      | (ArmCreatedResponse<Migration> &
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
  @renamedFrom(Versions.v2026_08_01, "cancel")
  @action("cancel")
  undo is ArmResourceActionAsyncBase<
    Migration,
    MigrationUndoRequest,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Migration>,
    OptionalRequestBody = true
  >;

  /**
   * Unlinks the migrated endpoint from the Redis Enterprise cluster, removing the source cache endpoint that was redirected to this cluster during migration.
   */
  @added(Versions.v2026_08_01)
  @action("unlinkMigratedEndpoint")
  unlinkMigratedEndpoint is ArmResourceActionAsyncBase<
    Migration,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Migration>
  >;

  /**
   * Validates if a source Azure Cache for Redis resource can be migrated to a target Azure Managed Redis resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the already-shipped 'Migrations_Validate' operationId across older API versions where the interface is renamed to singular 'Migration'."
  @operationId("Migrations_Validate")
  @action("validate")
  validate is ArmResourceActionSync<
    Migration,
    MigrationValidationRequest,
    Response = ArmResponse<MigrationValidationResponse>
  >;
}

@@doc(Migration.name, "");
@@doc(Migration.properties, "Properties of the migration operation.");
@@added(Migrations.undo::parameters.body, Versions.v2026_08_01);
@@doc(
  Migrations.undo::parameters.body,
  "Parameters supplied to undo a migration operation."
);
@@doc(
  Migrations.start::parameters.resource,
  "Parameters supplied to start a migration operation."
);
@@doc(
  Migrations.validate::parameters.body,
  "Parameters supplied to validate a migration operation."
);
