import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FileWorkspaceDetails.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents File Details resource
 */
@parentResource(FileWorkspaceDetails)
model FileDetails
  is Azure.ResourceManager.ProxyResource<FileDetailsProperties> {
  ...ResourceNameParameter<
    Resource = FileDetails,
    KeyName = "fileName",
    SegmentName = "files",
    NamePattern = ""
  >;
}
/**
 * [Placeholder] Description for page model
 */
model FilesListResult {
  /**
   * [Placeholder] Description for nextLink property
   */
  @nextLink
  nextLink?: string;

  /**
   * [Placeholder] Description for value property
   */
  @pageItems
  value?: FileDetails[];
}

@armResourceOperations
interface FileOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = FileWorkspaceDetails,
          KeyName = "fileWorkspaceName",
          SegmentName = "fileWorkspaces",
          NamePattern = "^[0-9a-zA-Z_\\-. ]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = FileDetails,
        KeyName = "fileName",
        SegmentName = "files",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Files {
  /**
   * Returns details of a specific file in a work space.
   */
  get is FileOps.Read<FileDetails>;

  /**
   * Creates a new file under a workspace for the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is FileOps.CreateOrUpdateSync<
    FileDetails,
    Response = ArmResourceCreatedSyncResponse<FileDetails>
  >;

  /**
   * Lists all the Files information under a workspace for an Azure subscription.
   */
  list is FileOps.List<FileDetails, Response = FilesListResult>;

  /**
   * This API allows you to upload content to a file
   */
  upload is FileOps.ActionSync<FileDetails, UploadFile, NoContentResponse>;
}
@armResourceOperations
interface FilesNoSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = FileWorkspaceDetails,
          KeyName = "fileWorkspaceName",
          SegmentName = "fileWorkspaces",
          NamePattern = "^[0-9a-zA-Z_\\-. ]+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = FileDetails,
        KeyName = "fileName",
        SegmentName = "files",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface FilesNoSubscription {
  /**
   * Returns details of a specific file in a work space.
   */
  get is FilesNoSubscriptionOps.Read<FileDetails>;

  /**
   * Creates a new file under a workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is FilesNoSubscriptionOps.CreateOrUpdateSync<
    FileDetails,
    Response = ArmResourceCreatedSyncResponse<FileDetails>
  >;

  /**
   * Lists all the Files information under a workspace for an Azure subscription.
   */
  list is FilesNoSubscriptionOps.List<FileDetails, Response = FilesListResult>;

  /**
   * This API allows you to upload content to a file
   */
  upload is FilesNoSubscriptionOps.ActionSync<
    FileDetails,
    UploadFile,
    NoContentResponse
  >;
}

@@doc(FileDetails.name, "File Name");
@@doc(FileDetails.properties, "Properties of the resource");
@@doc(Files.create::parameters.resource, "Create file object");
@@doc(Files.upload::parameters.body, "UploadFile object");
@@doc(FilesNoSubscription.create::parameters.resource, "Create file object");
@@doc(FilesNoSubscription.upload::parameters.body, "UploadFile object");
