import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "For backward compatibility"
@parentResource(ProtectedItemResource)
model RecoveryPointResource
  is Azure.ResourceManager.TrackedResource<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RecoveryPointResources {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID. This is an asynchronous operation.
   * To know the status of the operation, call the GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPoints_Get")
  get is ArmResourceRead<RecoveryPointResource>;

  /**
   * Lists the backup copies for the backed up item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RecoveryPoints_List")
  list is ArmResourceListByParent<
    RecoveryPointResource,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RecoveryPointResourceList>
  >;

  /**
   * Move recovery point from one datastore to another store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("move")
  @operationId("MoveRecoveryPoint")
  moveRecoveryPoint is ArmResourceActionAsyncBase<
    RecoveryPointResource,
    MoveRPAcrossTiersRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPointResource>
  >;

  /**
   * Restores the specified backed up data. This is an asynchronous operation. To know the status of this API call, use
   * GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("restore")
  @operationId("Restores_Trigger")
  trigger is ArmResourceActionAsyncBase<
    RecoveryPointResource,
    RestoreRequestResource,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPointResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;

  /**
   * Provisions a script which invokes an iSCSI connection to the backup data. Executing this script opens a file
   * explorer displaying all the recoverable files and folders. This is an asynchronous operation. To know the status of
   * provisioning, call GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  @action("provisionInstantItemRecovery")
  @operationId("ItemLevelRecoveryConnections_Provision")
  provision is ArmResourceActionSync<
    RecoveryPointResource,
    ILRRequestResource,
    AcceptedResponse
  >;

  /**
   * Revokes an iSCSI connection which can be used to download a script. Executing this script opens a file explorer
   * displaying all recoverable files and folders. This is an asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  @action("revokeInstantItemRecovery")
  @operationId("ItemLevelRecoveryConnections_Revoke")
  revoke is ArmResourceActionSync<
    RecoveryPointResource,
    void,
    AcceptedResponse
  >;
}

@@doc(RecoveryPointResource.name,
  "RecoveryPointID represents the backed up data to be fetched."
);
@@doc(RecoveryPointResource.properties, "RecoveryPointResource properties");
@@doc(RecoveryPointResources.moveRecoveryPoint::parameters.body,
  "Move Resource Across Tiers Request"
);
@@doc(RecoveryPointResources.trigger::parameters.body,
  "resource restore request"
);
@@doc(RecoveryPointResources.provision::parameters.body,
  "resource ILR request"
);
