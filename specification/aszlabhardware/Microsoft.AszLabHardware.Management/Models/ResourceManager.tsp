@doc("The status of the resource manager.")
union ResourceManagerStatus {
  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being converged.")
  Converging: "Converging",

  @doc("The resource is converged.")
  Converged: "Converged",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource failed to create.")
  FailedToCreate: "FailedToCreate",

  @doc("The resource failed to converge.")
  FailedToConverge: "FailedToConverge",

  @doc("The resource failed to delete.")
  FailedToDelete: "FailedToDelete",

  string,
}

@doc("The properties of the resource manager.")
model ResourceManager {
  @doc("The current status of the ResourceManager")
  status: ResourceManagerStatus;

  @doc("The error message of the ResourceManager (if in failed state)")
  errorMessage?: string;
}
