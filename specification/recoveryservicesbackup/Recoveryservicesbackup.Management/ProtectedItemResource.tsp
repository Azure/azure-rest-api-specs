import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainerResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup items.
 */
@parentResource(ProtectionContainerResource)
model ProtectedItemResource
  is Azure.ResourceManager.TrackedResource<ProtectedItem> {
  ...ResourceNameParameter<
    Resource = ProtectedItemResource,
    KeyName = "protectedItemName",
    SegmentName = "protectedItems",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectedItemResourceOps
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
      },
      KeysOf<ResourceNameParameter<
        Resource = ProtectedItemResource,
        KeyName = "protectedItemName",
        SegmentName = "protectedItems",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ProtectedItemResources {
  /**
   * Provides the details of the backed up item. This is an asynchronous operation. To know the status of the operation,
   * call the GetItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProtectedItems_Get")
  get is ProtectedItemResourceOps.Read<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ProtectedItems_CreateOrUpdate")
  createOrUpdate is ProtectedItemResourceOps.CreateOrUpdateSync<
    ProtectedItemResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<ProtectedItemResource> | AcceptedResponse
  >;

  /**
   * Used to disable backup of an item within a container. This is an asynchronous operation. To know the status of the
   * request, call the GetItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ProtectedItems_Delete")
  delete is ProtectedItemResourceOps.DeleteSync<
    ProtectedItemResource,
    Response = ArmDeletedResponse | AcceptedResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Triggers backup for specified backed up item. This is an asynchronous operation. To know the status of the
   * operation, call GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("backup")
  @operationId("Backups_Trigger")
  trigger is ProtectedItemResourceOps.ActionSync<
    ProtectedItemResource,
    BackupRequestResource,
    AcceptedResponse
  >;

  /**
   * Fetches the status of an operation such as triggering a backup, restore. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of the operation. Some operations
   * create jobs. This method returns the list of jobs associated with the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("ProtectedItemOperationStatuses_Get")
  protectedItemOperationStatusesGet is ProtectedItemResourceOps.ActionSync<
    ProtectedItemResource,
    void,
    ArmResponse<OperationStatus>,
    Parameters = {
      /**
       * OperationID represents the operation whose status needs to be fetched.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Lists the recovery points recommended for move to another tier
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("recoveryPointsRecommendedForMove")
  @operationId("RecoveryPointsRecommendedForMove_List")
  list is ProtectedItemResourceOps.ActionSync<
    ProtectedItemResource,
    ListRecoveryPointsRecommendedForMoveRequest,
    ArmResponse<RecoveryPointResourceList>
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
  get is ProtectedItemOperationResultOps.Read<
    ProtectedItemResource,
    Response = ArmResponse<ProtectedItemResource> | AcceptedResponse | ArmNoContentResponse
  >;
}

@@doc(ProtectedItemResource.name,
  "Backed up item name whose details are to be fetched."
);
@@doc(ProtectedItemResource.properties, "ProtectedItemResource properties");
@@doc(ProtectedItemResources.createOrUpdate::parameters.resource,
  "resource backed up item"
);
@@doc(ProtectedItemResources.trigger::parameters.body,
  "resource backup request"
);
@@doc(ProtectedItemResources.list::parameters.body,
  "List Recovery points Recommended for Move Request"
);
