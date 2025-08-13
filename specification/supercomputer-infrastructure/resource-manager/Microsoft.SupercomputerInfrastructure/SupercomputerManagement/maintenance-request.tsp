import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./maintenance-request-common.tsp";
import "./supercomputer.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A maintenance request on resource(s) that can be requested and approved. */
@parentResource(Supercomputer)
model MaintenanceRequest is ProxyResource<MaintenanceRequestProperties> {
  ...ResourceNameParameter<MaintenanceRequest>;
}

/** The properties of a maintenance request. */
model MaintenanceRequestProperties {
  /** A customizable description of the maintenance request. */
  description: string;

  /** The status of the last operation on the maintenance request. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** The type of the maintenance request */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  maintenanceRequestType: MaintenanceRequestType;

  /**
   * The current state of the maintenance request in the encompassing workflow.
   * Customers can only create a maintenance request with "Investigating" or
   * "Approved" state, and can only update this from "WaitingForApproval" to "Approved".
   */
  state: MaintenanceRequestState;

  /**
   * The ARM resource IDs of the entities that are reported to be unhealthy.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  unhealthyResources: string[];

  /** The impact seen to cause this maintenance request. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  impactCategory: MaintenanceRequestImpactCategory;

  /** The ARM resource IDs of the entities impacted by this maintenance request. */
  @visibility(Lifecycle.Read)
  impactedResources: string[];

  /** The ID of the duplicate maintenance request, if this is a duplicate. */
  @visibility(Lifecycle.Read)
  duplicateRequestId?: string;

  /** The cluster that the maintenance request is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: string;
}

@armResourceOperations
interface MaintenanceRequests {
  get is ArmResourceRead<MaintenanceRequest>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MaintenanceRequest>;
  update is ArmResourcePatchAsync<
    MaintenanceRequest,
    MaintenanceRequestProperties
  >;
  listBySupercomputer is ArmResourceListByParent<MaintenanceRequest>;
  // TODO: Figure out what ARM recommends... should customers be able to delete MaintenanceRequests?
  delete is ArmResourceDeleteWithoutOkAsync<MaintenanceRequest>;
}
