import "./common.tsp";
import "./queuestatus.tsp";
import "./repositorytype.tsp";

@doc("Properties for the build definition revision resource.")
model BuildDefinitionRevisionProperties {
  @doc("The name of the organization.")
  organizationName: string;

  @doc("The project ID of the build definition.")
  projectId: string;

  @doc("The repository ID of the build definition.")
  repositoryId: string;

  @doc("The ID of the build definition.")
  buildDefinitionId: int64;

  @doc("The revision of the build definition.")
  buildDefinitionRevision: int64;

  @doc("A value that indicates whether builds can be queued against this definition.")
  queueStatus?: QueueStatus;

  @doc("Type of the reference repository.")
  repositoryType: RepositoryType;

  @doc("Url of the reference repository.")
  repositoryUrl: url;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the resource.")
  provisioningState?: ProvisioningState;
}
