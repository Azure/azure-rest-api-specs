import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../shared/resourceid.tsp";
import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Approval Status Enum")
union ApprovalStatus {
  @doc("ApprovalStatus Type Approved")
  Approved: "Approved",

  @doc("ApprovalStatus Type Rejected")
  Rejected: "Rejected",

  @doc("ApprovalStatus Type Pending")
  Pending: "Pending",

  string
}

@doc("Request Metadata for approvals request.")
model RequestMetadata{
  @doc("Resource Action of the item being approved or declined.")
    resourceAction: string;

    @doc("Approval status.")
    approvalStatus: ApprovalStatus;
}

@doc("Approvals Resource Properties")
model ApprovalsProperties {

    @doc("Provisioning State.")
    @visibility("read")
    provisioningState?: ProvisioningState;

    @doc("Parameter for optimizing query results")
    parent1?: string;

    @doc("Parameter for optimizing query results")
    parent2?: string;

    @doc("Request metadata for the approval request.")
    requestMetadata?: RequestMetadata;
}
