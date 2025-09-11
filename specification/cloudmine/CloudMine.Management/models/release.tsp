import "./common.tsp";

@doc("Properties for the release resource.")
model ReleaseProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the release.")
  projectId: string;

  @doc("The release definition ID of the release.")
  releaseDefinitionId: int64;

  @doc("The ID of the release.")
  releaseId: int64;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
