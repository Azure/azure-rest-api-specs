import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Proposal;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("The proposal status.")
union ProposalStatus {
  string,

  @doc("Draft - Initial status when a proposal is created.")
  Draft: "Draft",

  @doc("Submitted - status when a proposal is submitted for approval and waiting for approver decision.")
  Submitted: "Submitted",

  @doc("Active -  status when a proposal is ready for purchase transaction.")
  Active: "Active",

  @doc("Rejected - status when a proposal's approval has been denied by the approver.")
  Rejected: "Rejected",

  @doc("Deleted - status when a proposal has been deleted by the consumer (not visible once deleted)")
  Deleted: "Deleted",

  @doc("Expired - status when a proposal is beyond its set expiration date.")
  Expired: "Expired",

  @doc("PurchaseInProgress - status when a proposal is inprogress on its purchase transaction.")
  PurchaseInProgress: "PurchaseInProgress",

  @doc("Completed - status when a proposal is successfully transacted by purchase.")
  Completed: "Completed",

  @doc("Ended - status when a proposal is ended by the consumer.")
  Ended: "Ended",
}

@doc("The line items to purchase in the proposal.")
model LineItem {
  @doc("The product code of the line item as a UUID that uniquely identifies this line item within the proposal.")
  productCode: string;

  @visibility(Lifecycle.Read)
  @doc("The resource URI of the line item.")
  resourceUri?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the line item.")
  status?: LineItemStatus;

  @visibility(Lifecycle.Read)
  @doc("The error code if any error occurs during processing the line item.")
  errorCode?: string;

  @visibility(Lifecycle.Read)
  @doc("The error message if any error occurs during processing the line item.")
  errorMessage?: string;
}

@doc("The status of the line item in the proposal.")
union LineItemStatus {
  string,

  @doc("NotDeployed - Initial status when a line item is created.")
  NotDeployed: "NotDeployed",

  @doc("Success - status when a line item is successfully deployed.")
  Success: "Success",

  @doc("InProgress - status when a line item deployment is in progress.")
  InProgress: "InProgress",

  @doc("Canceled - status when a line item deployment is canceled.")
  Canceled: "Canceled",

  @doc("Failed - status when a line item deployment has failed.")
  Failed: "Failed",
}
