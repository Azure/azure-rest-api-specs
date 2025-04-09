import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.ContainerStorage;

@doc("Status of the assignment resource")
model AssignmentStatus {
  @doc("State of the assignment resource")
  state: AssignmentStatusState;

  @doc("Reason for the status")
  message?: string;
}

@doc("Status of the assignment resource")
union AssignmentStatusState {
  string,

  @doc("The assignment of the pool to the resource is in progress")
  "Assigning",

  @doc("The assignment to the pool was successful.")
  "Assigned",

  @doc("The pool is being unassigned.")
  "Unassigning",

  @doc("The operation of assigning or unassigning the pool failed.")
  "Failed",
}

scalar AssignmentId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

@doc("Assignment Properties")
model Assignment {
  @visibility(Lifecycle.Read)
  @doc("Indicates if the assignment is in a usable state")
  status?: AssignmentStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Resource id for the assigned resource")
  id: AssignmentId;
}
