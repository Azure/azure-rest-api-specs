import "./common.tsp";

@doc("Properties for the release definition revision resource.")
model ReleaseDefinitionRevisionProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the release definition.")
  projectId: string;

  @doc("The release definition ID of the release.")
  releaseDefinitionId: int64;

  @doc("The revision of the release definition.")
  releaseDefinitionRevision: int64;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
