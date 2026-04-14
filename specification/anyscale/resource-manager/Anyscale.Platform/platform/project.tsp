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

@added(Versions.v2026_02_01_preview)
@parentResource(Cloud)
@resource("projects")
model Project is ProxyResource<ProjectProperties> {
  /** The name of the project. */
  @pattern("^[a-zA-Z0-9_-]*$")
  @key("projectName")
  @path
  @segment("projects")
  name: string;
}

/** The properties of the project. */
@added(Versions.v2026_02_01_preview)
model ProjectProperties {
  /** The URL link of the project to the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: string;

  /** The provisioning state of the project. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  listByResourceGroup is ArmResourceListByParent<Project>;
  listBySubscription is ArmListBySubscription<Project>;
}
