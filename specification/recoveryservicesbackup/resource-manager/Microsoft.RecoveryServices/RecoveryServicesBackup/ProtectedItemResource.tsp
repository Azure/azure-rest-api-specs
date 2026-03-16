import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainerResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup items.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(ProtectionContainerResource)
model ProtectedItemResource
  is TrackedResourceWithOptionalLocation<ProtectedItem> {
  ...ResourceNameParameter<
    Resource = ProtectedItemResource,
    KeyName = "protectedItemName",
    SegmentName = "protectedItems",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface ProtectedItems {
  /**
   * Provides the details of the backed up item. This is an asynchronous operation. To know the status of the operation,
   * call the GetItemOperationResult API.
   */
  get is ArmResourceRead<
    ProtectedItemResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Enables backup of an item or to modifies the backup policy information of an already backed up item. This is an
   * asynchronous operation. To know the status of the operation, call the GetItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ProtectedItemResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<ProtectedItemResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProtectedItemResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Used to disable backup of an item within a container. This is an asynchronous operation. To know the status of the
   * request, call the GetItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<
    ProtectedItemResource,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse
  >;
}

@armResourceOperations
interface Backups {
  /**
   * Triggers backup for specified backed up item. This is an asynchronous operation. To know the status of the
   * operation, call GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("backup")
  trigger is ArmResourceActionSync<
    ProtectedItemResource,
    BackupRequestResource,
    AcceptedResponse
  >;
}

@armResourceOperations
interface RecoveryPointsRecommendedForMove {
  /**
   * Lists the recovery points recommended for move to another tier
   */
  @action("recoveryPointsRecommendedForMove")
  @list
  list is ArmResourceActionSync<
    ProtectedItemResource,
    ListRecoveryPointsRecommendedForMoveRequest,
    ArmResponse<RecoveryPointResourceList>
  >;
}

@armResourceOperations
interface ProtectedItemOperationStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupFabrics */
        @path @segment("backupFabrics") fabricName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionContainerResource,
          KeyName = "containerName",
          SegmentName = "protectionContainers",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProtectedItemResource,
          KeyName = "protectedItemName",
          SegmentName = "protectedItems",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectedItemResource,
        KeyName = "operationId",
        SegmentName = "operationsStatus",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectedItemOperationStatuses {
  /**
   * Fetches the status of an operation such as triggering a backup, restore. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of the operation. Some operations
   * create jobs. This method returns the list of jobs associated with the operation.
   */
  get is ProtectedItemOperationStatusOps.Read<
    ProtectedItemResource,
    Response = ArmResponse<OperationStatus>
  >;
}

@armResourceOperations
interface ProtectedItemOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** vaults */
        @path @segment("vaults") vaultName: string,

        /** backupFabrics */
        @path @segment("backupFabrics") fabricName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ProtectionContainerResource,
          KeyName = "containerName",
          SegmentName = "protectionContainers",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProtectedItemResource,
          KeyName = "protectedItemName",
          SegmentName = "protectedItems",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectedItemResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectedItemOperationResults {
  /**
   * Fetches the result of any operation on the backup item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ProtectedItemOperationResultOps.Read<
    ProtectedItemResource,
    Response = ArmResponse<ProtectedItemResource> | AcceptedResponse | ArmNoContentResponse
  >;
}

@@doc(ProtectedItemResource.name,
  "Backed up item name whose details are to be fetched."
);
@@doc(ProtectedItemResource.properties, "ProtectedItemResource properties");
@@doc(ProtectedItems.createOrUpdate::parameters.resource,
  "resource backed up item"
);
@@doc(Backups.trigger::parameters.body, "resource backup request");
@@doc(RecoveryPointsRecommendedForMove.list::parameters.body,
  "List Recovery points Recommended for Move Request"
);
