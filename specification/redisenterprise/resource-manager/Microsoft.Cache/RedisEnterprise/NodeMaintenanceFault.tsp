import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Cluster.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Cache;

/** A node maintenance fault used to test the resilience of an Azure Managed Redis cluster with high availability enabled. */
@added(Versions.v2026_11_01_preview)
@parentResource(Cluster)
model NodeMaintenanceFault
  is Azure.ResourceManager.ProxyResource<NodeMaintenanceFaultProperties> {
  ...ResourceNameParameter<
    Resource = NodeMaintenanceFault,
    KeyName = "faultName",
    SegmentName = "nodeMaintenanceFaults",
    NamePattern = "^(?=.{1,63}$)[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

/** Provisioning and execution details of a node maintenance fault. */
@added(Versions.v2026_11_01_preview)
model NodeMaintenanceFaultProperties {
  /** The provisioning state of the fault resource. Successful provisioning indicates that fault execution was dispatched, not that execution has completed. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Keep this read-only enum inline: Swagger 2.0 ignores readOnly beside a $ref, causing ARM validation to treat a referenced provisioning state as writable."
  @visibility(Lifecycle.Read)
  @lroStatus
  provisioningState?:
    | ResourceProvisioningState
    | "Creating"
    | "Deleting"
    | string;

  /** The execution status of the fault. This property is absent if the fault could not be dispatched. */
  @visibility(Lifecycle.Read)
  faultStatus?: NodeMaintenanceFaultStatus;

  /** The time when fault execution started, in UTC. */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** The time when fault execution finished, in UTC. */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /** Error details when provisioning or deletion of the fault resource fails. */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /** Error details when fault execution fails. */
  @visibility(Lifecycle.Read)
  faultError?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/** The execution status of a node maintenance fault, independent of resource provisioning. */
@added(Versions.v2026_11_01_preview)
union NodeMaintenanceFaultStatus {
  /** The fault is waiting to execute. */
  Pending: "Pending",

  /** The fault is executing. */
  InProgress: "InProgress",

  /** Fault execution completed successfully. */
  Succeeded: "Succeeded",

  /** Fault execution failed. */
  Failed: "Failed",

  string,
}

/** Operations for node maintenance fault resources on an Azure Managed Redis cluster. */
@added(Versions.v2026_11_01_preview)
@armResourceOperations
interface NodeMaintenanceFaults {
  /** Gets a node maintenance fault, including its provisioning and execution status. */
  get is ArmResourceRead<NodeMaintenanceFault>;

  /** Creates or replaces a node maintenance fault on an Azure Managed Redis cluster with high availability enabled. A completed fault resource can be reused to run another fault. Requests are rejected while a fault is active or the cluster is not ready. No request body is required. */
  @autoRoute
  @put
  @armResourceCreateOrUpdate(NodeMaintenanceFault)
  @useFinalStateVia("original-uri")
  createOrReplace(...ResourceInstanceParameters<NodeMaintenanceFault>):
    | (ArmResponse<NodeMaintenanceFault> &
        ArmAsyncOperationHeader<FinalResult = NodeMaintenanceFault>)
    | (ArmCreatedResponse<NodeMaintenanceFault> &
        ArmAsyncOperationHeader<FinalResult = NodeMaintenanceFault>)
    | ErrorResponse;

  /** Deletes a node maintenance fault resource. Deletion waits for active fault execution to finish; it does not cancel the running fault. */
  @useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeMaintenanceFault,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void>
  >;

  /** Lists all node maintenance fault resources on a cluster. */
  listByCluster is ArmResourceListByParent<NodeMaintenanceFault>;

  /** Gets the result of deleting a node maintenance fault. Returns no content after successful deletion, or error details if deletion failed. */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "This GET polls resource-scoped DELETE operation results (202/204), rather than reading a resource or invoking a POST action."
  @autoRoute
  @get
  getOperationResult(
    ...ResourceInstanceParameters<NodeMaintenanceFault>,
    ...Azure.ResourceManager.CommonTypes.OperationIdParameter,
  ):
    | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader<FinalResult = void>>
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@segment(
  NodeMaintenanceFaults.getOperationResult::parameters.operationId,
  "operationresults"
);

@@doc(
  NodeMaintenanceFault.name,
  "The name of the node maintenance fault. Must be 1-63 alphanumeric or hyphen characters, without leading, trailing, or consecutive hyphens."
);
@@doc(
  NodeMaintenanceFault.properties,
  "Provisioning and execution details of the node maintenance fault."
);
