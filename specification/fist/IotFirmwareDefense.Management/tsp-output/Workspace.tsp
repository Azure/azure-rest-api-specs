import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.IoTFirmwareDefense;
@doc("Firmware analysis workspace.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the firmware analysis workspace.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface Workspaces {
  @doc("Get firmware analysis workspace.")
  get is ArmResourceRead<Workspace>;

  @doc("The operation to create or update a firmware analysis workspace.")
  create is ArmResourceCreateOrReplaceSync<Workspace>;

  @doc("The operation to update a firmware analysis workspaces.")
  update is ArmCustomPatchSync<Workspace, WorkspaceUpdateDefinition>;

  @doc("The operation to delete a firmware analysis workspace.")
  delete is ArmResourceDeleteSync<Workspace>;

  @doc("Lists all of the firmware analysis workspaces in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  @doc("Lists all of the firmware analysis workspaces in the specified subscription.")
  listBySubscription is ArmListBySubscription<Workspace>;

  @doc("The operation to get a url for file upload.")
  generateUploadUrl is ArmResourceActionSync<
    Workspace,
    GenerateUploadUrlRequest,
    UrlToken
  >;
}
