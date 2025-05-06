import "./common.tsp";

@doc("Properties for the repository resource.")
model RepositoryProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the repository.")
  projectId: string;

  @doc("The repository ID of the repository.")
  repositoryId: string;

  @doc("Url of the reference repository.")
  repositoryUrl: url;

  @doc("Name of the default branch.")
  defaultBranch?: string;

  @doc("True if the repository is disabled. False otherwise.")
  isDisabled: boolean;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
