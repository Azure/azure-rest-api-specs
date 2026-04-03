import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A Migration Service.
 */
model MigrationService
  is Azure.ResourceManager.TrackedResource<MigrationServiceProperties> {
  ...ResourceNameParameter<
    Resource = MigrationService,
    KeyName = "migrationServiceName",
    SegmentName = "migrationServices",
    NamePattern = "^[A-Za-z][A-Za-z0-9_-]*$"
  >;
}

@armResourceOperations
interface MigrationServices {
  /**
   * Retrieve the Database Migration Service
   */
  get is ArmResourceRead<MigrationService>;

  /**
   * Create or Update Database Migration Service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    MigrationService,
    LroHeaders = ArmLroLocationHeader<FinalResult = MigrationService> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update Database Migration Service.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    MigrationService,
    PatchModel = MigrationServiceUpdate
  >;

  /**
   * Delete Database Migration Service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MigrationService>;

  /**
   * Retrieve all migration services in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<MigrationService>;

  /**
   * Retrieve all migration services in the subscriptions.
   */
  listBySubscription is ArmListBySubscription<MigrationService>;

  /**
   * Retrieve the List of database migrations attached to the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MigrationServices_listMigrations")
  @list
  @get
  listMigrations is ArmResourceActionSync<
    MigrationService,
    void,
    ArmResponse<ResourceListResult<DatabaseMigrationBase>>
  >;
}

@@doc(MigrationService.name, "Name of the Migration Service.");
@@doc(MigrationService.properties, "The Migration Service properties.");
@@doc(MigrationServices.createOrUpdate::parameters.resource,
  "Details of MigrationService resource."
);
@@doc(MigrationServices.update::parameters.properties,
  "Details of MigrationService resource."
);
