import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Embr;

/** Project resource */
model Project is TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<Project>;
}

/** Project properties. */
model ProjectProperties {
  /** Internal Embr project identifier this ARM resource tracks. */
  embrProjectId?: string;

  /** The source type of the project. */
  sourceType?: SourceType;

  /** Repository owner. */
  owner?: string;

  /** Repository name. */
  repositoryName?: string;

  /** Repository full name in owner/repo format. */
  repositoryFullName?: string;

  /** Repository id. */
  repositoryId?: int64;

  /** Indicates whether the project is active. */
  @visibility(Lifecycle.Read)
  isActive?: boolean;

  /** Indicates whether the project is suspended. */
  @visibility(Lifecycle.Read)
  isSuspended?: boolean;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The source type of the project. */
union SourceType {
  string,

  /** GitHub repository source. */
  GitHub: "github",

  /** Zip archive source. */
  Zip: "zip",
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  update is ArmResourcePatchSync<Project, ProjectProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  listByResourceGroup is ArmResourceListByParent<Project>;
  listBySubscription is ArmListBySubscription<Project>;
}
