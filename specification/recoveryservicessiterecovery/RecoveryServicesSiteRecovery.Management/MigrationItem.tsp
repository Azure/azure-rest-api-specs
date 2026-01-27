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

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias MigrationItemAcceptedLroResponse = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MigrationItem> &
  Azure.Core.Foundations.RetryAfterHeader>;

@armResourceOperations
interface MigrationItems {
  /**
   * Gets the details of a migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the details of a migration item.")
  get is ArmResourceRead<MigrationItem, Error = never>;

  /**
   * The operation to create an ASR migration item (enable migration).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Enables migration.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    MigrationItem,
    Request = EnableMigrationInput,
    Response = ArmResourceUpdatedResponse<MigrationItem> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = MigrationItem> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update the recovery settings of an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Updates migration item.")
  update is ArmCustomPatchAsync<
    MigrationItem,
    PatchModel = UpdateMigrationItemInput,
    Error = never
  >;

  /**
   * The operation to delete an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete the migration item.")
  delete is ArmResourceDeleteWithoutOkAsync<
    MigrationItem,
    Parameters = {
      /**
       * The delete option.
       */
      @query("deleteOption")
      deleteOption?: string;
    },
    Error = never
  >;

  /**
   * Gets the list of ASR migration items in the protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of migration items in the protection container.")
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
    Response = ArmResponse<MigrationItemCollection>,
    Error = never
  >;

  /**
   * The operation to initiate migration of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Migrate item.")
  migrate is ArmResourceActionAsyncBase<
    MigrationItem,
    MigrateInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
  >;

  /**
   * The operation to initiate pause replication of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Pause replication.")
  pauseReplication is ArmResourceActionAsyncBase<
    MigrationItem,
    PauseReplicationInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
  >;

  /**
   * The operation to initiate resume replication of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Resume replication.")
  resumeReplication is ArmResourceActionAsyncBase<
    MigrationItem,
    ResumeReplicationInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
  >;

  /**
   * The operation to resynchronize replication of an ASR migration item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Resynchronizes replication.")
  resync is ArmResourceActionAsyncBase<
    MigrationItem,
    ResyncInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
  >;

  /**
   * The operation to initiate test migration of the item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Test migrate item.")
  testMigrate is ArmResourceActionAsyncBase<
    MigrationItem,
    TestMigrateInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
  >;

  /**
   * The operation to initiate test migrate cleanup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Test migrate cleanup.")
  testMigrateCleanup is ArmResourceActionAsyncBase<
    MigrationItem,
    TestMigrateCleanupInput,
    ArmResponse<MigrationItem> | MigrationItemAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<MigrationItem>,
    Error = never
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
