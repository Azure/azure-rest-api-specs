import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Migration item.
 */
@parentResource(ProtectionContainer)
model MigrationItem
  is Azure.ResourceManager.ProxyResource<MigrationItemProperties> {
  ...ResourceNameParameter<
    Resource = MigrationItem,
    KeyName = "migrationItemName",
    SegmentName = "replicationMigrationItems",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MigrationItems {
  /**
   * Gets the details of a migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_Get")
  get is ArmResourceRead<MigrationItem>;

  /**
   * The operation to create an ASR migration item (enable migration).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationMigrationItems_Create")
  create is ArmResourceCreateOrReplaceAsync<
    MigrationItem,
    Response = ArmResourceUpdatedResponse<MigrationItem> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the recovery settings of an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("ReplicationMigrationItems_Update")
  update is ArmCustomPatchAsync<
    MigrationItem,
    PatchModel = UpdateMigrationItemInput
  >;

  /**
   * The operation to delete an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    MigrationItem,
    Parameters = {
      /**
       * The delete option.
       */
      @query("deleteOption")
      deleteOption?: string;
    }
  >;

  /**
   * Gets the list of ASR migration items in the protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_ListByReplicationProtectionContainers")
  listByReplicationProtectionContainers is ArmResourceListByParent<
    MigrationItem,
    Parameters = {
      /**
       * The pagination token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * The page size.
       */
      @query("takeToken")
      takeToken?: string;

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<MigrationItemCollection>
  >;

  /**
   * The operation to initiate migration of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_Migrate")
  migrate is ArmResourceActionAsync<
    MigrationItem,
    MigrateInput,
    ArmResponse<MigrationItem>
  >;

  /**
   * The operation to initiate pause replication of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_PauseReplication")
  pauseReplication is ArmResourceActionAsync<
    MigrationItem,
    PauseReplicationInput,
    ArmResponse<MigrationItem>
  >;

  /**
   * The operation to initiate resume replication of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_ResumeReplication")
  resumeReplication is ArmResourceActionAsync<
    MigrationItem,
    ResumeReplicationInput,
    ArmResponse<MigrationItem>
  >;

  /**
   * The operation to resynchronize replication of an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_Resync")
  resync is ArmResourceActionAsync<
    MigrationItem,
    ResyncInput,
    ArmResponse<MigrationItem>
  >;

  /**
   * The operation to initiate test migration of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_TestMigrate")
  testMigrate is ArmResourceActionAsync<
    MigrationItem,
    TestMigrateInput,
    ArmResponse<MigrationItem>
  >;

  /**
   * The operation to initiate test migrate cleanup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationMigrationItems_TestMigrateCleanup")
  testMigrateCleanup is ArmResourceActionAsync<
    MigrationItem,
    TestMigrateCleanupInput,
    ArmResponse<MigrationItem>
  >;
}

@@doc(MigrationItem.name, "Migration item name.");
@@doc(MigrationItem.properties, "The migration item properties.");
@@doc(MigrationItems.create::parameters.resource, "Enable migration input.");
@@doc(MigrationItems.update::parameters.properties,
  "Update migration item input."
);
@@doc(MigrationItems.migrate::parameters.body, "Migrate input.");
@@doc(MigrationItems.pauseReplication::parameters.body,
  "Pause replication input."
);
@@doc(MigrationItems.resumeReplication::parameters.body,
  "Resume replication input."
);
@@doc(MigrationItems.resync::parameters.body, "Resync input.");
@@doc(MigrationItems.testMigrate::parameters.body, "Test migrate input.");
@@doc(MigrationItems.testMigrateCleanup::parameters.body,
  "Test migrate cleanup input."
);
