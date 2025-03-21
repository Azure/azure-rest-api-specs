import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service(#{ title: "ModSimWorkbench Control Plane API" })
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("The chamber data pipeline direction.")
union DataPipelineDirection {
  string,

  @doc("File coming in to chamber.")
  Inbound: "Inbound",

  @doc("File going out from chamber.")
  Outbound: "Outbound",
}

@doc("Action to be performed on data pipeline file.")
union FileAction {
  string,

  @doc("Delete file.")
  Delete: "Delete",

  @doc("Archive file.")
  Archive: "Archive",
}

@doc("Options for whether to force a file manage operation.")
union FileActionForce {
  string,

  @doc("Force the operation.")
  True: "True",

  @doc("Do not force the operation.")
  False: "False",
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

  @visibility(Lifecycle.Read)
  @doc("The direction of the chamber data pipeline where the file is located.")
  dataPipeline: DataPipelineDirection;

  @visibility(Lifecycle.Read)
  @doc("The resource ID of the chamber data pipeline request. Populated only if requested.")
  requestId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ModSimWorkbench/fileRequests";
    }
  ]>;

  @visibility(Lifecycle.Read)
  @doc("The Linux File System path for the chamber data pipeline file.")
  filePath: string;

  @visibility(Lifecycle.Read)
  @doc("The size of the file.")
  size: int64;

  @visibility(Lifecycle.Read)
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
    ResultProperty
  >;
}
