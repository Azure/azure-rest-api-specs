import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SubscriptionFileWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Support;
@doc("Object that represents File Details resource")
@parentResource(SubscriptionFileWorkspace)
model SupportTicketFile is ProxyResource<FileDetailsProperties> {
  @doc("File Name")
  @path
  @key("fileName")
  @segment("files")
  name: string;
}

@armResourceOperations
interface SupportTicketFiles {
  @doc("Returns details of a specific file in a work space.")
  get is ArmResourceRead<SupportTicketFile>;
  @doc("Creates a new file under a workspace for the specified subscription.")
  create is ArmResourceCreateOrReplaceSync<SupportTicketFile>;
  @doc("Lists all the Files information under a workspace for an Azure subscription.")
  list is ArmResourceListByParent<SupportTicketFile>;
  @doc("This API allows you to upload content to a file")
  upload is ArmResourceActionNoContentSync<SupportTicketFile, UploadFile>;
}
