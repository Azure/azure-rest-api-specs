import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Support;
@doc("Object that represents FileWorkspaceDetails resource")
@subscriptionResource
model FileWorkspaceDetails is ProxyResource<FileWorkspaceDetailsProperties> {
  @doc("File Workspace Name")
  @key("fileWorkspaceName")
  @segment("fileWorkspaces")
  name: string;
}

@armResourceOperations
@projectedName("client", "FileWorkspaces")
interface FileWorkspaceDetails_FileWorkspaces {
  @doc("Gets details for a specific file workspace in an Azure subscription.")
  get is ArmResourceRead<FileWorkspaceDetails>;

  @doc("Creates a new file workspace for the specified subscription.")
  create is ArmResourceCreateOrReplaceSync<FileWorkspaceDetails>;
}
