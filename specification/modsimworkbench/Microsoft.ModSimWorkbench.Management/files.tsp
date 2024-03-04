import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@service({
  title: "ModSimWorkbench Control Plane API",
  version: "2021-03-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ModSimWorkbench;

@doc("The chamber data pipeline direction.")
enum DataPipelineDirection {
  @doc("File coming in to chamber.")
  Inbound, // TODO: This should be lowercase

  @doc("File going out from chamber.")
  Outbound, // TODO: This should be lowercase
}

@doc("Action to be performed on data pipeline file.")
enum FileAction {
  @doc("Delete file.")
  Delete, // TODO: This should be lowercase

  @doc("Archive file.")
  Archive, // TODO: This should be lowercase
}

@doc("Options for whether to force a file manage operation.")
enum FileActionForce {
  @doc("Force the operation.")
  True, // TODO: This should be lowercase

  @doc("Do not force the operation.")
  False, // TODO: This should be lowercase
}

@doc("Parameters for managing a file.")
model FileManageParameters {
  @doc("The chamber data pipeline direction.")
  dataPipeline?: DataPipelineDirection;

  @doc("Action to be performed on data pipeline file.")
  action: FileAction;

  @doc("Specifies whether to force delete. Only works if action is Delete.")
  force: FileActionForce;
}

@doc("Parameters for requesting file download.")
model FileDownloadRequestParameters {
  @doc("Specifies the reason for the download request.")
  description: string;
}

@doc("File properties.")
model FileProperties {
  ...ProvisioningStateProperty;
  ...TimestampProperty;

  @visibility("read")
  @doc("The direction of the chamber data pipeline where the file is located.")
  dataPipeline: DataPipelineDirection;

  @visibility("read")
  @doc("The resource ID of the chamber data pipeline request. Populated only if requested.")
  requestId?: string;

  @visibility("read")
  @doc("The Linux File System path for the chamber data pipeline file.")
  filePath: string;

  @visibility("read")
  @doc("The size of the file.")
  size: int64;

  @visibility("read")
  @doc("The MD5 hash of the file.")
  checksum: string;
}

@doc("File resource.")
@parentResource(Chamber)
model File is ProxyResource<FileProperties> {
  @doc("The name of the File")
  @segment("files")
  @key("fileName")
  @TypeSpec.Http.path
  @pattern("^[a-zA-Z0-9\\._-]+$")
  name: string;
}

@armResourceOperations
interface Files extends ProxyResourceOperations<File> {
  @doc("Manage a chamber data pipeline file.")
  manage is ArmResourceActionAsync<File, FileManageParameters, ResultProperty>; // TODO: Document meaning of result.

  @doc("Request to download a chamber data pipeline file.")
  downloadRequest is ArmResourceActionAsync<
    File,
    FileDownloadRequestParameters,
    ResultProperty // TODO: Document meaning of result.
  >;
}
