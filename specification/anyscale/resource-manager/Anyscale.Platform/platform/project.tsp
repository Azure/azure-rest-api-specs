import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./versions.tsp";
import "./cloud.tsp";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

@parentResource(Cloud)
@resource("projects")
/** A project that organizes Anyscale workloads. */
model Project is ProxyResource<ProjectProperties> {
  /** The name of the project. */
  @pattern("^[a-zA-Z0-9_-]+$")
  @maxLength(256)
  @key("projectName")
  @path
  @segment("projects")
  name: string;
}

/** The properties of the project. */
model ProjectProperties {
  /** The URL link of the project to the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: url;

  /** The provisioning state of the project. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Projects {
  /** Gets a project. */
  get is ArmResourceRead<Project>;
  /** Creates or updates a project. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  /** Deletes a project. */
  delete is ArmResourceDeleteWithoutOkAsync<
    Project,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Lists projects in a cloud. */
  listByResourceGroup is ArmResourceListByParent<Project>;
}
