@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Approval Operation Status Enum")
union ApprovalOperationStatus {
  @doc("ApprovalOperationStatus Type NotSpecified")
  NotSpecified: "NotSpecified",

  @doc("ApprovalOperationStatus Type Pending")
  Pending: "Pending",

  @doc("ApprovalOperationStatus Type Running")
  Running: "Running",

  @doc("ApprovalOperationStatus Type Succeeded")
  Succeeded: "Succeeded",

  @doc("ApprovalOperationStatus Type Failed")
  Failed: "Failed",

  string,
}
