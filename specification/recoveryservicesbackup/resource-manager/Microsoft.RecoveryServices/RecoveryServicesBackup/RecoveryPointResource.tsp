import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.RecoveryServices;
/**
 * Base class for backup copies. Workload-specific backup copies are derived from this class.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/beyond-nesting-levels" "Backward compatibility with existing API structure."
@parentResource(ProtectedItemResource)
model RecoveryPointResource is ProxyResource<RecoveryPoint> {
  ...ResourceNameParameter<
    Resource = RecoveryPointResource,
    KeyName = "recoveryPointId",
    SegmentName = "recoveryPoints",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Optional location"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backward compatibility for optional ETag"
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

  /**
   * UpdateRecoveryPoint to update recovery point for given RecoveryPointID.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Recovery point updates use UpdateRecoveryPointRequest model which does not include tags property"
  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  @added(Versions.v2026_01_31_preview)
  @removed(Versions.v2026_02_01)
  @added(Versions.v2026_03_31_preview)
  @removed(Versions.v2026_05_01)
  @added(Versions.v2026_05_31_preview)
  @removed(Versions.v2026_08_01)
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    RecoveryPointResource,
    PatchModel = UpdateRecoveryPointRequest,
    Response = ArmResponse<RecoveryPointResource>
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
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "x-ms-authorization-auxiliary is a standard ARM cross-tenant auxiliary-token header defined by ARM; it carries no service-specific semantics to document."
      #suppress "@azure-tools/typespec-azure-core/casing-style" "x-ms-authorization-auxiliary is a fixed ARM wire header; its casing is mandated by ARM and must not be altered."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "provisionInstantItemRecovery returns 202 Accepted without a Location/Azure-AsyncOperation header; provisioning status is polled via GetProtectedItemOperationResult, so the LRO location-header requirement does not apply to this legacy action."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "This action is accepted-only (returns 202 with no synchronous 200 body); the standard POST 200+default response-code set does not apply to this legacy asynchronous action."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "revokeInstantItemRecovery returns 202 Accepted without a Location/Azure-AsyncOperation header; revoke status is polled via GetProtectedItemOperationResult, so the LRO location-header requirement does not apply to this legacy action."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "This action is accepted-only (returns 202 with no synchronous 200 body); the standard POST 200+default response-code set does not apply to this legacy asynchronous action."
  @action("revokeInstantItemRecovery")
  revoke is ArmResourceActionSync<
    RecoveryPointResource,
    void,
    AcceptedResponse
  >;

  /**
   * Fetches the mount scripts for an active Instant Item Recovery (ILR) session on the recovery point.
   * The mount scripts contain the iSCSI connection details required to browse and recover files and folders.
   * This dedicated action returns the scripts that were previously embedded inline in the
   * operationsStatus (ILR provision) response, and must be used to retrieve them from API version 2026-08-01 onwards.
   */
  @added(Versions.v2026_08_01)
  @action("fetchInstantItemRecoveryOperationResult")
  fetchInstantItemRecoveryOperationResult is ArmResourceActionSync<
    RecoveryPointResource,
    InstantItemRecoveryOperationResultRequestResource,
    ArmResponse<InstantItemRecoveryTarget>
  >;
}

@@doc(
  RecoveryPointResource.name,
  "RecoveryPointID represents the backed up data to be fetched."
);
@@doc(RecoveryPointResource.properties, "RecoveryPointResource properties");
@@doc(
  RecoveryPoints.moveRecoveryPoint::parameters.body,
  "Move Resource Across Tiers Request"
);
@@doc(
  RecoveryPoints.update::parameters.properties,
  "Request body for operation"
);
@@doc(Restores.trigger::parameters.body, "resource restore request");
@@doc(
  ItemLevelRecoveryConnections.provision::parameters.body,
  "resource ILR request"
);
