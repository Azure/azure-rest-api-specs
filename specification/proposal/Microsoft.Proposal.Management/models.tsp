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
