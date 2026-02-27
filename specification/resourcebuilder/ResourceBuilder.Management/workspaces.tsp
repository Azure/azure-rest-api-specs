import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ResourceBuilder;

/** Workspace resource */
model Workspace is TrackedResource<WorkspaceProperties> {
  /** The name of the workspace. */
  @segment("workspaces")
  @key("workspaceName")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,63}$")
  name: string;
}

/** Workspace properties */
model WorkspaceProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workspace>;
  update is ArmResourcePatchSync<Workspace, WorkspaceProperties>;
  delete is ArmResourceDeleteSync<Workspace>;
  list is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}
