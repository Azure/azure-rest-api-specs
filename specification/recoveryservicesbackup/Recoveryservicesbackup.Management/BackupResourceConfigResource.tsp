import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * The resource storage details.
 */
@singleton("vaultstorageconfig")
model BackupResourceConfigResource
  is Azure.ResourceManager.TrackedResource<BackupResourceConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceConfigResource,
    KeyName = "backupstorageconfig",
    SegmentName = "backupstorageconfig",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BackupResourceConfigResources {
  /**
   * Fetches resource storage config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupResourceStorageConfigsNonCRR_Get")
  get is ArmResourceRead<BackupResourceConfigResource>;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupResourceStorageConfigsNonCRR_Update")
  update is ArmResourceCreateOrReplaceSync<
    BackupResourceConfigResource,
    Response = ArmResourceUpdatedResponse<BackupResourceConfigResource>
  >;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("BackupResourceStorageConfigsNonCRR_patch")
  patch is ArmCustomPatchSync<
    BackupResourceConfigResource,
    PatchModel = BackupResourceConfigResource,
    Response = ArmNoContentResponse
  >;

  /**
   * Fetches operation status for data move operation on vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("GetOperationStatus")
  getOperationStatus is ArmResourceActionSync<
    BackupResourceConfigResource,
    void,
    ArmResponse<OperationStatus>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @path
      operationId: string;
    }
  >;

  /**
   * Prepares source vault for Data Move operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("prepareDataMove")
  @operationId("BMSPrepareDataMove")
  bMSPrepareDataMove is ArmResourceActionAsync<
    BackupResourceConfigResource,
    PrepareDataMoveRequest,
    OkResponse
  >;

  /**
   * Triggers Data Move Operation on target vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("triggerDataMove")
  @operationId("BMSTriggerDataMove")
  bMSTriggerDataMove is ArmResourceActionAsync<
    BackupResourceConfigResource,
    TriggerDataMoveRequest,
    OkResponse
  >;

  /**
   * Fetches Operation Result for Prepare Data Move
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("BMSPrepareDataMoveOperationResult_Get")
  bMSPrepareDataMoveOperationResultGet is ArmResourceActionSync<
    BackupResourceConfigResource,
    void,
    ArmResponse<VaultStorageConfigOperationResultResponse> | AcceptedResponse,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @path
      operationId: string;
    }
  >;
}

@@doc(BackupResourceConfigResource.name, "");
@@doc(BackupResourceConfigResource.properties,
  "BackupResourceConfigResource properties"
);
@@doc(BackupResourceConfigResources.update::parameters.resource,
  "Vault storage config request"
);
@@doc(BackupResourceConfigResources.patch::parameters.properties,
  "Vault storage config request"
);
@@doc(BackupResourceConfigResources.bMSPrepareDataMove::parameters.body,
  "Prepare data move request"
);
@@doc(BackupResourceConfigResources.bMSTriggerDataMove::parameters.body,
  "Trigger data move request"
);
