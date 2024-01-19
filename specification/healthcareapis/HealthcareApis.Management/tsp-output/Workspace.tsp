import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
@doc("Workspace resource.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of workspace resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface Workspaces {
  @doc("Gets the properties of the specified workspace.")
  get is ArmResourceRead<Workspace>;

  @doc("Creates or updates a workspace resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Workspace>;

  @doc("Patch workspace details.")
  update is ArmCustomPatchAsync<Workspace, WorkspacePatchResource>;

  @doc("Deletes a specified workspace.")
  delete is ArmResourceDeleteAsync<Workspace>;

  @doc("Lists all the available workspaces under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  @doc("Lists all the available workspaces under the specified subscription.")
  listBySubscription is ArmListBySubscription<Workspace>;
}

@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "json",
  "workspace"
);
@@extension(Workspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a healthcare workspace."
);
@@projectedName(Workspaces.update::parameters.properties,
  "json",
  "workspacePatchResource"
);
@@extension(Workspaces.update::parameters.properties,
  "x-ms-client-name",
  "workspacePatchResource"
);
@@doc(Workspaces.update::parameters.properties,
  "The parameters for updating a specified workspace."
);
