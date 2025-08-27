// import "@typespec/rest";
// import "@typespec/http";
// import "@azure-tools/typespec-azure-core";
// import "@azure-tools/typespec-azure-resource-manager";

// import "./common.tsp";
// import "./supercomputer.tsp";

// using Rest;
// using Azure.ResourceManager;

// namespace Microsoft.SupercomputerInfrastructure;

// /** A maintenance request on resource(s) that can be requested and approved. */
// @parentResource(Supercomputer)
// model MaintenanceRequest is ProxyResource<MaintenanceRequestProperties> {
//   ...ResourceNameParameter<MaintenanceRequest>;
// }

// /** The properties of a maintenance request. */
// model MaintenanceRequestProperties {
//   /** A customizable description of the maintenance request. */
//   description: string;

//   /** The status of the last operation on the maintenance request. */
//   @visibility(Lifecycle.Read)
//   provisioningState?: ResourceProvisioningState;

//   /** The type of the maintenance request */
//   @visibility(Lifecycle.Create, Lifecycle.Read)
//   maintenanceRequestType: MaintenanceRequestType;

//   /**
//    * The current state of the maintenance request in the encompassing workflow.
//    * Customers can only create a maintenance request with "Investigating" or
//    * "Approved" state, and can only update this from "WaitingForApproval" to "Approved".
//    */
//   state: MaintenanceRequestState;

//   /**
//    * The ARM resource IDs of the entities that are reported to be unhealthy.
//    */
//   @visibility(Lifecycle.Create, Lifecycle.Read)
//   unhealthyResources: string[];

//   /** The impact seen to cause this maintenance request. */
//   @visibility(Lifecycle.Create, Lifecycle.Read)
//   impactCategory: MaintenanceRequestImpactCategory;

//   /** The ARM resource IDs of the entities impacted by this maintenance request. */
//   @visibility(Lifecycle.Read)
//   impactedResources: string[];

//   /** The ID of the duplicate maintenance request, if this is a duplicate. */
//   @visibility(Lifecycle.Read)
//   duplicateRequestId?: string;

//   /** The cluster that the maintenance request is associated with, if any. */
//   @visibility(Lifecycle.Read)
//   clusterId?: string;
// }

// /** The type of maintenance request. */
// union MaintenanceRequestType {
//   /**
//    * It is unknown exactly what the problem is, and Microsoft should investigate
//    * and return with action items.
//    */
//   Investigative: "Investigative",

//   /**
//    * It is known what action items should be completed and Microsoft should
//    * only perform that as directed.
//    */
//   Unhealthy: "Unhealthy",

//   string,
// }

// /** The types of impact covered by maintenance requests. */
// union MaintenanceRequestImpactCategory {
//   /** The link is miswired between two devices. */
//   LinkMiswire: "LinkMiswire",

//   /** The referenced link has unspecified performance issues. */
//   LinkUnhealthy: "LinkUnhealthy",

//   /** The referenced NIC has incorrect firmware. */
//   NicIncorrectFirmware: "NicIncorrectFirmware",

//   /** The referenced NIC has unspecified issues. */
//   NicUnhealthy: "NicUnhealthy",

//   /** The referenced port is completely down. */
//   PortDown: "PortDown",

//   /** The referenced link is flapping. */
//   LinkFlap: "LinkFlap",

//   /** The referenced port is receiving low Rx power. */
//   PortRxLowPower: "PortRxLowPower",

//   /** The referenced port is receiving low Tx power. */
//   PortTxLowPower: "PortTxLowPower",

//   /** The referenced port has unspecified performance issues, such as packet drops. */
//   PortUnhealthy: "PortUnhealthy",

//   /** The referenced switch is completely down. */
//   SwitchDown: "SwitchDown",

//   /** The referenced switch is misconfigured. */
//   SwitchMisconfigured: "SwitchMisconfigured",

//   /** The referenced switch has unspecified issues, such as a low buffer. */
//   SwitchUnhealthy: "SwitchUnhealthy",

//   string,
// }

// /** The states of the maintenance request */
// union MaintenanceRequestState {
//   /** The maintenance request is being investigated by Microsoft. */
//   Investigating: "Investigating",

//   /**
//    * The maintenance request is a duplicate of another maintenance request
//    * that is mentioned in network maintenance ID.
//    */
//   Duplicate: "Duplicate",

//   /** The maintenance request is waiting on customer approval to continue. */
//   WaitingOnApproval: "WaitingOnApproval",

//   /** The maintenance request is approved by the customer. */
//   Approved: "Approved",

//   /** The maintenance request is currently underway. */
//   InProgress: "InProgress",

//   /** The maintenance request is complete. */
//   Complete: "Complete",

//   /** The maintenance request is cancelled. */
//   Cancelled: "Cancelled",

//   string,
// }

// @armResourceOperations
// interface MaintenanceRequests {
//   get is ArmResourceRead<MaintenanceRequest>;
//   createOrUpdate is ArmResourceCreateOrReplaceAsync<MaintenanceRequest>;
//   update is ArmResourcePatchAsync<
//     MaintenanceRequest,
//     MaintenanceRequestProperties
//   >;
//   listBySupercomputer is ArmResourceListByParent<MaintenanceRequest>;
//   delete is ArmResourceDeleteWithoutOkAsync<MaintenanceRequest>;
// }
