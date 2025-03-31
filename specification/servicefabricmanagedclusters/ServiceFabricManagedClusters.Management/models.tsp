import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.ServiceFabric;

/**
 * The provisioning state of the managed resource.
 */
union ManagedResourceProvisioningState {
  string,

  /**
   * The resource does not have a provisioning state.
   */
  None: "None",

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is created.
   */
  Created: "Created",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource provisioning has succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The resource provisioning has failed.
   */
  Failed: "Failed",

  /**
   * The resource provisioning has been canceled.
   */
  Canceled: "Canceled",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource has been deleted.
   */
  Deleted: "Deleted",

  /**
   * The resource provisioning state is a state other than the previously specified states.
   */
  Other: "Other",
}

/**
 * Sfmc operation status.
 */
union SfmcOperationStatus {
  string,

  /**
   * Operation created.
   */
  Created: "Created",

  /**
   * Operation started.
   */
  Started: "Started",

  /**
   * Operation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Operation failed.
   */
  Failed: "Failed",

  /**
   * Operation aborted.
   */
  Aborted: "Aborted",

  /**
   * Operation canceled.
   */
  Canceled: "Canceled",
}

/**
 * The type of managed identity for the resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backwards compatibility with existing flag enum"
enum ManagedIdentityType {
  /**
   * Indicates that no identity is associated with the resource.
   */
  None,

  /**
   * Indicates that system assigned identity is associated with the resource.
   */
  SystemAssigned,

  /**
   * Indicates that user assigned identity is associated with the resource.
   */
  UserAssigned,

  /**
   * Indicates that both system assigned and user assigned identity are associated with the resource.
   */
  `SystemAssigned, UserAssigned`,
}

/**
 * The structure of the error.
 */
@error
model ErrorModel {
  /**
   * The error details.
   */
  error?: ErrorModelError;
}

/**
 * The error details.
 */
model ErrorModelError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedIdentity {
  /**
   * The principal id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of managed identity for the resource.
   */
  type?: ManagedIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backwards compatibility, used to pass user identities"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Available operation list result
 */
model OperationResult {
  /**
   * The name of the operation.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that represents the operation.
   */
  display?: AvailableOperationDisplay;

  /**
   * Origin result
   */
  origin?: string;

  /**
   * The URL to use for getting the next set of results.
   */
  nextLink?: string;
}

/**
 * Operation supported by the Service Fabric resource provider
 */
model AvailableOperationDisplay {
  /**
   * The name of the provider.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed
   */
  resource?: string;

  /**
   * The operation that can be performed.
   */
  operation?: string;

  /**
   * Operation description
   */
  description?: string;
}

/**
 * Describes the result of the request to list Service Fabric resource provider operations.
 */
model OperationListResult is Azure.Core.Page<OperationResult>;

/**
 * Long running operation result.
 */
model LongRunningOperationResult {
  /**
   * The name of the operation.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  endTime?: utcDateTime;

  /**
   * The completion percentage of the operation.
   */
  percentComplete?: float64;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The operation error.
   */
  error?: ErrorModelError;
}

/**
 * The IP tag associated with the public IP address.
 */
model IpTag {
  /**
   * IP tag type. Example: FirstPartyUsage.
   */
  ipTagType: string;

  /**
   * IP tag associated with the public IP. Example: SQL, Storage etc.
   */
  tag: string;
}

/**
 * Parameters for Fault Simulation id.
 */
model FaultSimulationIdContent {
  /**
   * unique identifier for the fault simulation.
   */
  simulationId: string;
}

/**
 * Fault simulation object with status.
 */
model FaultSimulation {
  /**
   * unique identifier for the fault simulation.
   */
  simulationId?: string;

  /**
   * Fault simulation status
   */
  status?: FaultSimulationStatus;

  /**
   * The start time of the fault simulation.
   */
  startTime?: utcDateTime;

  /**
   * The end time of the fault simulation.
   */
  endTime?: utcDateTime;

  /**
   * Fault simulation details
   */
  details?: FaultSimulationDetails;
}

/**
 * The kind of fault simulation.
 */
union FaultKind {
  string,

  /**
   * Simulates an availability zone down.
   */
  Zone: "Zone",
}

/**
 * Details for Fault Simulation.
 */
model FaultSimulationDetails {
  /**
   * unique identifier for the cluster resource.
   */
  clusterId?: string;

  /**
   * unique identifier for the operation associated with the fault simulation.
   */
  operationId?: string;

  /**
   * List of node type simulations associated with the cluster fault simulation.
   */
  @OpenAPI.extension("x-ms-identifiers", #["nodeTypeName"])
  nodeTypeFaultSimulation?: NodeTypeFaultSimulation[];

  /**
   * Fault simulation parameters.
   */
  parameters?: FaultSimulationContent;
}

/**
 * Node type fault simulation object with status.
 */
model NodeTypeFaultSimulation {
  /**
   * Node type name.
   */
  nodeTypeName?: string;

  /**
   * Fault simulation status
   */
  status?: FaultSimulationStatus;

  /**
   * Current or latest asynchronous operation identifier on the node type.
   */
  operationId?: string;

  /**
   * Current or latest asynchronous operation status on the node type
   */
  operationStatus?: SfmcOperationStatus;
}

/**
 * Parameters for Fault Simulation action.
 */
@discriminator("faultKind")
model FaultSimulationContent {
  /**
   * The kind of fault to be simulated.
   */
  faultKind: FaultKind;

  /**
   * Force the action to go through without any check on the cluster.
   */
  force?: boolean;

  /**
   * Constraints for Fault Simulation action.
   */
  constraints?: FaultSimulationConstraints;
}

/**
 * Constraints for Fault Simulation action.
 */
model FaultSimulationConstraints {
  /**
   * The absolute expiration timestamp (UTC) after which this fault simulation should be stopped if it's still active.
   */
  expirationTime?: utcDateTime;
}

/**
 * Fault simulation list results
 */
model FaultSimulationListResult is Azure.Core.Page<FaultSimulation>;

/**
 * Parameters for Zone Fault Simulation action.
 */
model ZoneFaultSimulationContent extends FaultSimulationContent {
  /**
   * Indicates the zones of the fault simulation.
   */
  zones?: string[];

  /**
   * The kind of fault simulation.
   */
  faultKind: "Zone";
}

/**
 * Fault simulation status.
 */
union FaultSimulationStatus {
  string,

  /**
   * Indicates the fault simulation is starting. The simulation will have this status while the start operation is in progress.
   */
  Starting: "Starting",

  /**
   * Indicates the fault simulation is active. The simulation will have this status after the start operation has completed successfully.
   */
  Active: "Active",

  /**
   * Indicates the fault simulation is stopping. The simulation will have this status while the stop operation is in progress.
   */
  Stopping: "Stopping",

  /**
   * Indicates the fault simulation is done. The simulation will have this status after the stop operation has completed successfully.
   */
  Done: "Done",

  /**
   * Indicates the fault simulation has failed on start. The simulation will have this status after the start operation fails.
   */
  StartFailed: "StartFailed",

  /**
   * Indicates the fault simulation has failed on stop. The simulation will have this status after the stop operation fails.
   */
  StopFailed: "StopFailed",
}
