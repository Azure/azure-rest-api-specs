import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./computeConfig.tsp";
import "./project.tsp";
import "./versions.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

@added(Versions.v2026_02_01_preview)
@parentResource(Project)
@resource("workspaces")
model Workspace is ProxyResource<WorkspaceProperties> {
  /** The name of the workspace. */
  @pattern("^[a-zA-Z0-9]*$")
  @key("workspaceName")
  @path
  @segment("workspaces")
  name: string;
}

/** The properties of the workspace. */
@added(Versions.v2026_02_01_preview)
model WorkspaceProperties {
  /** The compute config to use for the workspace. */
  computeConfig: ComputeConfigSpecOrReference;

  /** The URI of the Ray image to use for the workspace. */
  imageUri: string;

  /** If set to a positive number, Anyscale will terminate the workspace this many minutes after the workspace is idle. Idle time is defined as the time during which a workspace is not running a user command. To disable, set this field to 0. */
  idleTerminationMinutes?: int32 = 0;

  /** The current status of the workspace. */
  @visibility(Lifecycle.Read)
  currentStatus?: WorkspaceState;

  /** The provisioning state of the workspace. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The current state of workspace. */
@added(Versions.v2026_02_01_preview)
union WorkspaceState {
  /** The workspace is starting up. */
  Starting: "Starting",

  /** The workspace is updating. */
  Updating: "Updating",

  /** The workspace is running. */
  Running: "Running",

  /** The workspace is terminating. */
  Terminating: "Terminating",

  /** The workspace is terminated. */
  Terminated: "Terminated",

  /** The workspace is in an error state. */
  Errored: "Errored",

  string,
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;
  update is ArmCustomPatchSync<
    Workspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Workspace,
      WorkspaceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;
  listByResourceGroup is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}
