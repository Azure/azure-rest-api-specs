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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@singleton("vaultstorageconfig")
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(BackupResourceConfig)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackupResourceConfigResource extends Resource {
  ...ResourceNameParameter<
    Resource = BackupResourceConfigResource,
    KeyName = "backupstorageconfig",
    SegmentName = "backupstorageconfig",
    NamePattern = ""
  >;

  /**
   * BackupResourceConfigResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  properties?: BackupResourceConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
@armResourceOperations
interface BMSPrepareDataMoveOperationResult {
  /**
   * Fetches operation status for data move operation on vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
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
