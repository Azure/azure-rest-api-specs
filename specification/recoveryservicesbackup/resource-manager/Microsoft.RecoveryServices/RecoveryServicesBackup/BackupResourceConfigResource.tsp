import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * The resource storage details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@singleton("vaultstorageconfig")
@parentResource(VaultResource)
model BackupResourceConfigResource
  is TrackedResourceWithOptionalLocation<BackupResourceConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceConfigResource,
    KeyName = "backupstorageconfig",
    SegmentName = "backupstorageconfig",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Legacy API"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BackupResourceStorageConfigsNonCRR {
  /**
   * Fetches resource storage config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<BackupResourceConfigResource>;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update is ArmResourceCreateOrReplaceSync<
    BackupResourceConfigResource,
    Response = ArmResourceUpdatedResponse<BackupResourceConfigResource>
  >;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    BackupResourceConfigResource,
    PatchModel = BackupResourceConfigResource,
    Response = ArmNoContentResponse
  >;

  /**
   * Prepares source vault for Data Move operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("prepareDataMove")
  bmsPrepareDataMove is ArmResourceActionAsync<
    BackupResourceConfigResource,
    PrepareDataMoveRequest,
    OkResponse
  >;

  /**
   * Triggers Data Move Operation on target vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("triggerDataMove")
  bmsTriggerDataMove is ArmResourceActionAsync<
    BackupResourceConfigResource,
    TriggerDataMoveRequest,
    OkResponse
  >;
}

@armResourceOperations
interface BackupResourceConfigOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupStorageConfigName */
        @path
        @segment("backupstorageconfig")
        backupStorageConfigName: "vaultstorageconfig",
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupResourceConfigResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BMSPrepareDataMoveOperationResult {
  /**
   * Fetches operation status for data move operation on vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is BackupResourceConfigOperationResultOps.Read<
    BackupResourceConfigResource,
    Response = ArmResponse<VaultStorageConfigOperationResultResponse> | AcceptedResponse
  >;
}

@armResourceOperations
interface BackupResourceConfigOperationStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupStorageConfigName */
        @path
        @segment("backupstorageconfig")
        backupStorageConfigName: "vaultstorageconfig",
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupResourceConfigResource,
        KeyName = "operationId",
        SegmentName = "operationStatus",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BackupResourceConfigOperationStatuses {
  /**
   * Fetches Operation Result for Prepare Data Move
   */
  @get
  getOperationStatus is BackupResourceConfigOperationStatusOps.Read<
    BackupResourceConfigResource,
    Response = ArmResponse<OperationStatus>
  >;
}

@@doc(BackupResourceConfigResource.name, "");
@@doc(BackupResourceConfigResource.properties,
  "BackupResourceConfigResource properties"
);
@@doc(BackupResourceStorageConfigsNonCRR.update::parameters.resource,
  "Vault storage config request"
);
@@doc(BackupResourceStorageConfigsNonCRR.patch::parameters.properties,
  "Vault storage config request"
);
@@doc(BackupResourceStorageConfigsNonCRR.bmsPrepareDataMove::parameters.body,
  "Prepare data move request"
);
@@doc(BackupResourceStorageConfigsNonCRR.bmsTriggerDataMove::parameters.body,
  "Trigger data move request"
);
