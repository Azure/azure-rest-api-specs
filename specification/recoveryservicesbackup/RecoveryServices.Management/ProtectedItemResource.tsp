import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainerResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup items.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(ProtectionContainerResource)
@Azure.ResourceManager.Private.armResourceInternal(ProtectedItem)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProtectedItemResource extends Resource {
  ...ResourceNameParameter<
    Resource = ProtectedItemResource,
    KeyName = "protectedItemName",
    SegmentName = "protectedItems",
    NamePattern = ""
  >;

  /**
   * ProtectedItemResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  properties?: ProtectedItem;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ProtectedItemResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<ProtectedItemResource> | AcceptedResponse
  >;

  /**
   * Used to disable backup of an item within a container. This is an asynchronous operation. To know the status of the
   * request, call the GetItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get is ProtectedItemOperationResultOps.Read<
    ProtectedItemResource,
    Response = ArmResponse<ProtectedItemResource> | AcceptedResponse | ArmNoContentResponse
  >;
}

@@doc(ProtectedItemResource.name,
  "Backed up item name whose details are to be fetched."
);
@@doc(ProtectedItems.createOrUpdate::parameters.resource,
  "resource backed up item"
);
@@doc(Backups.trigger::parameters.body, "resource backup request");
@@doc(RecoveryPointsRecommendedForMove.list::parameters.body,
  "List Recovery points Recommended for Move Request"
);
