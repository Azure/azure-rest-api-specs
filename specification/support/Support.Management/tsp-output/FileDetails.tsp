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
/**
 * Object that represents File Details resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(FileWorkspaceDetails)
@Azure.ResourceManager.Private.armResourceInternal(FileDetailsProperties)
@includeInapplicableMetadataInPayload(false)
model FileDetails extends ProxyResourceBase {
  /**
   * File Name
   */
  @path
  @key("fileName")
  @segment("files")
  name: string;

  /**
   * Properties of the resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: FileDetailsProperties;
}

@armResourceOperations
@projectedName("client", "FileDetails")
interface FileDetailsOperationGroup {
  /**
   * Returns details of a specific file in a work space.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_Get")
  get is ArmResourceRead<FileDetails>;

  /**
   * Creates a new file under a workspace for the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_Create")
  create is ArmResourceCreateOrReplaceSync<FileDetails>;

  /**
   * Lists all the Files information under a workspace for an Azure subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_List")
  list is ArmResourceListByParent<FileDetails>;

  /**
   * This API allows you to upload content to a file
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
