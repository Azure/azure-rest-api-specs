import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@parentResource(ProtectedItemResource)
model RecoveryPointResource
  is TrackedResourceWithOptionalLocation<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface RecoveryPoints {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID. This is an asynchronous operation.
   * To know the status of the operation, call the GetProtectedItemOperationResult API.
   */
  get is ArmResourceRead<RecoveryPointResource>;

  /**
   * Lists the backup copies for the backed up item.
   */
  @list
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
  @action("move")
  moveRecoveryPoint is ArmResourceActionAsyncBase<
    RecoveryPointResource,
    MoveRPAcrossTiersRequest,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPointResource>
  >;
}

@armResourceOperations
interface Restores {
  /**
   * Restores the specified backed up data. This is an asynchronous operation. To know the status of this API call, use
   * GetProtectedItemOperationResult API.
   */
  @action("restore")
  trigger is ArmResourceActionAsyncBase<
    RecoveryPointResource,
    RestoreRequestResource,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<RecoveryPointResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;
}

@armResourceOperations
interface ItemLevelRecoveryConnections {
  /**
   * Provisions a script which invokes an iSCSI connection to the backup data. Executing this script opens a file
   * explorer displaying all the recoverable files and folders. This is an asynchronous operation. To know the status of
   * provisioning, call GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("provisionInstantItemRecovery")
  provision is ArmResourceActionSync<
    RecoveryPointResource,
    ILRRequestResource,
    AcceptedResponse
  >;

  /**
   * Revokes an iSCSI connection which can be used to download a script. Executing this script opens a file explorer
   * displaying all recoverable files and folders. This is an asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("revokeInstantItemRecovery")
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
@@doc(RecoveryPoints.moveRecoveryPoint::parameters.body,
  "Move Resource Across Tiers Request"
);
@@doc(Restores.trigger::parameters.body, "resource restore request");
@@doc(ItemLevelRecoveryConnections.provision::parameters.body,
  "resource ILR request"
);
