import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FileWorkspaceDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Support;
@doc("Object that represents File Details resource")
@parentResource(FileWorkspaceDetails)
model FileDetails is ProxyResource<FileDetailsProperties> {
  @doc("File Name")
  @key("fileName")
  @segment("files")
  name: string;
}

@armResourceOperations
@projectedName("client", "Files")
interface FileDetails_Files {
  @doc("Returns details of a specific file in a work space.")
  get is ArmResourceRead<FileDetails>;

  @doc("Creates a new file under a workspace for the specified subscription.")
  create is ArmResourceCreateOrReplaceSync<FileDetails>;

  @doc("Lists all the Files information under a workspace for an Azure subscription.")
  list is ArmResourceListByParent<FileDetails>;

  @doc("This API allows you to upload content to a file")
  upload is ArmResourceActionNoContentSync<FileDetails, UploadFile>;
}
