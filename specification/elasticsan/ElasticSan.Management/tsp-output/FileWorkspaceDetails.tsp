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

namespace Microsoft.Support;
@doc("Object that represents FileWorkspaceDetails resource")
@subscriptionResource
model FileWorkspaceDetails is ProxyResource<FileWorkspaceDetailsProperties> {
  @doc("File Workspace Name")
  @path
  @key("fileWorkspaceName")
  @segment("fileWorkspaces")
  name: string;
}

@armResourceOperations
@projectedName("client", "FileWorkspaceDetails")
interface FileWorkspaceDetailsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets details for a specific file workspace in an Azure subscription.")
  @operationId("FileWorkspaces_Get")
  get is ArmResourceRead<FileWorkspaceDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new file workspace for the specified subscription.")
  @operationId("FileWorkspaces_Create")
  create is ArmResourceCreateOrReplaceSync<FileWorkspaceDetails>;
}
