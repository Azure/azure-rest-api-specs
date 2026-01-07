import "./common.tsp";

@doc("Properties for the release definition resource.")
model ReleaseDefinitionProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the release definition.")
  projectId: string;

  @doc("The release definition ID of the release.")
  releaseDefinitionId: int64;

  @doc("The revisions of the release definition.")
  releaseDefinitionRevisions: Array<int64>;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
