import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FileWorkspaceDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
@doc("Object that represents File Details resource")
@parentResource(FileWorkspaceDetails)
model FileDetails is ProxyResource<FileDetailsProperties> {
  @doc("File Name")
  @path
  @key("fileName")
  @segment("files")
  name: string;
}

@armResourceOperations
@projectedName("client", "FileDetails")
interface FileDetailsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns details of a specific file in a work space.")
  @operationId("Files_Get")
  get is ArmResourceRead<FileDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new file under a workspace for the specified subscription.")
  @operationId("Files_Create")
  create is ArmResourceCreateOrReplaceSync<FileDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the Files information under a workspace for an Azure subscription.")
  @operationId("Files_List")
  list is ArmResourceListByParent<FileDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This API allows you to upload content to a file")
  @operationId("Files_Upload")
  upload is ArmResourceActionNoContentSync<FileDetails, UploadFile>;
}

@@projectedName(FileDetailsOperationGroup.create::parameters.resource,
  "json",
  "createFileParameters"
);
@@extension(FileDetailsOperationGroup.create::parameters.resource,
  "x-ms-client-name",
  "createFileParameters"
);
@@doc(FileDetailsOperationGroup.create::parameters.resource,
  "Create file object"
);
@@projectedName(FileDetailsOperationGroup.upload::parameters.body,
  "json",
  "uploadFile"
);
@@extension(FileDetailsOperationGroup.upload::parameters.body,
  "x-ms-client-name",
  "uploadFile"
);
@@doc(FileDetailsOperationGroup.upload::parameters.body, "UploadFile object");
