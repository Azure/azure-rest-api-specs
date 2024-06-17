import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("File request approval details.")
model FileRequestApproval {
  ...TimestampProperty;

  @visibility("read")
  @doc("The globally unique identifier for the approval.")
  id: string;

  @visibility("read")
  @doc("The description of the approval.")
  description: string;

  @visibility("read")
  @doc("The description of the approval.")
  userId: string;
}

@doc("File request download details")
model FileRequestDownload {
  @visibility("read")
  @doc("Download destination location.")
  location: string;

  @visibility("read")
  @doc("The timestamp when download started.")
  startTime: utcDateTime;

  @visibility("read")
  @doc("The timestamp when download completed.")
  completeTime: utcDateTime;
}

@doc("Internal meta-data associated with file request.")
model FileRequestInternalMetadata {
  @visibility("read")
  @doc("SAS userid")
  sasUriId: string;
  // TODO: Figure out what this is. Likely a URI.
  // TODO: Consider reducing nesting.
}

@doc("File request approval.")
union FileRequestAction {
  string,

  @doc("Approve request.")
  Approve: "Approve",

  @doc("Reject request.")
  Reject: "Reject",
}

@doc("Parameters for managing file request.")
model FileRequestManageParameters {
  @doc("Whether to approve teh request.")
  action: FileRequestAction;

  @doc("Specifies the reason for the action.")
  description: string;
}

@doc("FileRequest properties.")
model FileRequestProperties {
  ...ProvisioningStateProperty;
  ...TimestampProperty;

  @visibility("read")
  @doc("The unique identifier if the file associated with this request.")
  fileId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ModSimWorkbench/files";
    }
  ]>;

  @visibility("read")
  @doc("Principal ID of Azure Active Directory User who approved to download.")
  requestUserId: string;

  @doc("The chamber workload's local login username.")
  @visibility("read")
  linuxUsername: string;

  @visibility("read")
  @doc("The status of a chamber data pipeline file request.")
  status: string; // TODO: Make enum so user knows what values and can handle them.

  @visibility("read")
  @doc("Description for the operation.")
  description: string;

  @visibility("read")
  @doc("Details of file request approval.")
  approve?: FileRequestApproval;

  @visibility("read")
  @doc("Details of file request download.")
  download?: FileRequestDownload;

  @visibility("read")
  @doc("Internal meta-data associated with file request download.")
  internalMetadata?: FileRequestInternalMetadata;
}

@doc("FileRequest resource.")
@parentResource(Chamber)
model FileRequest is ProxyResource<FileRequestProperties> {
  @doc("The name of the File Request")
  @segment("fileRequests")
  @key("requestName")
  @TypeSpec.Http.path
  @pattern("^[a-zA-Z0-9\\._-]+$")
  name: string;
}

@doc("File request get download URI response.")
model DownloadUriResponse {
  @doc("SAS URI for downloading a file.")
  result: string;
}

@armResourceOperations
interface FileRequests extends ProxyResourceOperations<FileRequest> {
  @doc("Manage a chamber data pipeline file request.")
  manage is ArmResourceActionAsync<
    FileRequest,
    FileRequestManageParameters,
    ResultProperty // TODO: Eliminate result?
  >;

  @doc("Get a SAS URI to download a file from a chamber data pipeline.")
  getDownloadUri is ArmResourceActionAsync<
    FileRequest,
    void,
    DownloadUriResponse
  >;
}
