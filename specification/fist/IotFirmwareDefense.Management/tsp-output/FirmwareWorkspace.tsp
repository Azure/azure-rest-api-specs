import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotFirmwareDefense;
@doc("Firmware analysis workspace.")
model FirmwareWorkspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the firmware analysis workspace.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface FirmwareWorkspaces {
  @doc("Get firmware analysis workspace.")
  get is ArmResourceRead<FirmwareWorkspace>;
  @doc("The operation to create or update a firmware analysis workspace.")
  create is ArmResourceCreateOrReplaceSync<FirmwareWorkspace>;
  @doc("The operation to update a firmware analysis workspaces.")
  update is ArmResourcePatchSync<FirmwareWorkspace, WorkspaceProperties>;
  @doc("The operation to delete a firmware analysis workspace.")
  delete is ArmResourceDeleteSync<FirmwareWorkspace>;
  @doc("Lists all of the firmware analysis workspaces in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<FirmwareWorkspace>;
  @doc("Lists all of the firmware analysis workspaces in the specified subscription.")
  listBySubscription is ArmListBySubscription<FirmwareWorkspace>;
  @doc("The operation to get a url for file upload.")
  generateUploadUrl is ArmResourceActionSync<
    FirmwareWorkspace,
    GenerateUploadUrlRequest,
    UrlToken
  >;
}
