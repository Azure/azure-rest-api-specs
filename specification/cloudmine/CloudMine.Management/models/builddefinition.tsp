import "./common.tsp";
import "./queuestatus.tsp";
import "./repositorytype.tsp";

@doc("Properties for the build definition resource.")
model BuildDefinitionProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the build definition.")
  projectId: string;

  @doc("The repository ID of the build definition.")
  repositoryId: string;

  @doc("The ID of the build definition.")
  buildDefinitionId: int64;

  @doc("The revisions of the build definition.")
  buildDefinitionRevisions: Array<int64>;

  @doc("Type of the reference repository.")
  repositoryType: RepositoryType;

  @doc("Url of the reference repository.")
  repositoryUrl: url;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
