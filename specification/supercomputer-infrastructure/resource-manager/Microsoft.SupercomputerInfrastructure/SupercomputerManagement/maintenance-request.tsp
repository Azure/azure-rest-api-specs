import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./supercomputer.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A maintenance request on resource(s) that can be requested and approved. */
@parentResource(Supercomputer)
model MaintenanceRequest is ProxyResource<MaintenanceRequestProperties> {
  ...ResourceNameParameter<
    MaintenanceRequest,
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
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
   * The Azure resource IDs of the entities that are reported to be unhealthy.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  unhealthyResources: ReportableWithinMaintenanceRequestResourceId[];

  /** The impact seen to cause this maintenance request. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  impactCategory: MaintenanceRequestImpactCategory;

  /**
   * The Azure resource IDs of the entities that are repaired through this request.
   */
  @visibility(Lifecycle.Read)
  repairedResources?: ReportableWithinMaintenanceRequestResourceId[];

  /** The category of repair on the repaired resources. */
  @visibility(Lifecycle.Read)
  repairCategory?: MaintenanceRequestRepairCategory;

  /**
   * The Azure Resource ID of the workload impact resource,
   * if created through the Impact RP workflow.
   */
  @visibility(Lifecycle.Read)
  workloadImpactId?: WorkloadImpactResourceId;

  /** The ARM resource IDs of the entities impacted by this maintenance request. */
  @visibility(Lifecycle.Read)
  impactedResources?: ReportableWithinMaintenanceRequestResourceId[];

  /** The ID of the duplicate maintenance request, if this is a duplicate. */
  @visibility(Lifecycle.Read)
  duplicateRequestId?: MaintenanceRequestResourceId;

  /** The cluster that the maintenance request is associated with, if any. */
  @visibility(Lifecycle.Read)
  clusterId?: ClusterResourceId;
}

/** The type of maintenance request. */
union MaintenanceRequestType {
  /**
   * It is unknown exactly what the problem is, and Microsoft should investigate
   * and return with action items.
   */
  Investigative: "Investigative",

  /**
   * It is known what action items should be completed and Microsoft should
   * only perform that as directed.
   */
  Unhealthy: "Unhealthy",

  string,
}

/** The types of impact covered by maintenance requests. */
union MaintenanceRequestImpactCategory {
  /** The link is miswired between two devices. */
  EthLinkMiswire: "EthLinkMiswire",

  /** The referenced link has unspecified performance issues. */
  EthLinkUnhealthy: "EthLinkUnhealthy",

  /** The referenced NIC has unspecified issues. */
  EthNicUnhealthy: "EthNicUnhealthy",

  /** The referenced port is completely down. */
  EthPortDown: "EthPortDown",

  /** The referenced link is flapping. */
  EthLinkFlap: "EthLinkFlap",

  /** The referenced port is receiving low Rx power. */
  EthPortRxLowPower: "EthPortRxLowPower",

  /** The referenced port is receiving low Tx power. */
  EthPortTxLowPower: "EthPortTxLowPower",

  /** The referenced port has unspecified performance issues, such as packet drops. */
  EthPortUnhealthy: "EthPortUnhealthy",

  /** The referenced switch is completely down. */
  EthSwitchDown: "EthSwitchDown",

  /** The referenced switch has unspecified issues, such as a low buffer. */
  EthSwitchUnhealthy: "EthSwitchUnhealthy",

  string,
}

/** The types of repair covered by maintenance requests. */
union MaintenanceRequestRepairCategory {
  /** The repair needs human investigation. */
  HumanInvestigate: "HumanInvestigate",

  /** The operating system needs to be upgraded. */
  OsUpgrade: "OsUpgrade",

  /** A power cycle is required. */
  PowerCycle: "PowerCycle",

  /** A restart without power cycle is required. */
  Restart: "Restart",

  /** The repair involves an RMA on a device. */
  RMA: "RMA",

  /** A NIC needs to be replaced. */
  ReplaceNic: "ReplaceNic",

  /** A cable needs to be replaced. */
  ReplaceCable: "ReplaceCable",

  string,
}

/** The states of the maintenance request */
union MaintenanceRequestState {
  /** The maintenance request has been created. */
  Created: "Created",

  /** The maintenance request is being investigated by Microsoft. */
  Investigating: "Investigating",

  /**
   * The maintenance request is a duplicate of another maintenance request
   * that is mentioned in network maintenance ID.
   */
  Duplicate: "Duplicate",

  /** The maintenance request is waiting on customer approval to continue. */
  WaitingOnApproval: "WaitingOnApproval",

  /** The maintenance request is approved by the customer. */
  Approved: "Approved",

  /** The maintenance request is currently underway. */
  InProgress: "InProgress",

  /** The maintenance request is complete. */
  Complete: "Complete",

  /** The maintenance request is cancelled. */
  Cancelled: "Cancelled",

  string,
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
  delete is ArmResourceDeleteWithoutOkAsync<MaintenanceRequest>;
}
