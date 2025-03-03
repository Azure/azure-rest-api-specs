import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureCis;

@doc("azCopy properties")
model AzCopyResourceProperties {
  @doc("Specifies the azcopy command to run. Acceptable values: cp, copy, rm, remove. Default: cp.")
  command: CommandType;

  @doc("The SAS token for the source object. This should be the full URL. This can target an account, container, virtual directory, or blob.")
  source: string;

  @doc("The SAS token for the destination object. This should be the full URL. This can target an account, container, virtual directory, or blob.")
  destination: string;

  @doc("Source and destination combo. Any combination of Blob and/or File side by side (ex. BlobBlob, FileBlob).")
  fromTo: FromToType;

  @doc("Only for Blob-Blob transfers. Specifies the blob type to use when uploading blobs. Acceptable values: BlockBlob, PageBlob, AppendBlob.")
  blobType: BlobType;

  @doc("Specifies whether the root of the source is considered a part of the transfer.")
  asSubdir?: boolean;

  @doc("Overwrite Options.")
  overwrite?: OverwriteType;

  @doc("The Azure location")
  azureLocation?: azureLocation;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: AzCopyProvisioningState;

  @doc("Raw value of AzCopy result response message.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  azCopy?: string;
}

@doc("AzCopy Resource")
model AzCopyResource is ProxyResource<AzCopyResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("azCopies")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface AzCopy {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AzCopyResource>;
  get is ArmResourceRead<AzCopyResource>;
  listByResourceGroup is ArmResourceListByParent<AzCopyResource>;
  listBySubscription is ArmListBySubscription<AzCopyResource>;
}

@doc("Command Type")
union CommandType {
  @doc("Copying")
  cp: "cp",

  @doc("Copying")
  copy: "copy",

  string,
}

@doc("FromTo Type")
union FromToType {
  @doc("Copying from Blob to Blob")
  BlobBlob: "BlobBlob",

  @doc("Copying from Blob to BlobFS")
  BlobBlobFS: "BlobBlobFS",

  @doc("Copying from BlobFS to Blob")
  BlobFSBlob: "BlobFSBlob",

  @doc("Copying from BlobFS to BlobFS")
  BlobFSBlobFS: "BlobFSBlobFS",

  @doc("Copying from BlobFS to File")
  BlobFSFile: "BlobFSFile",

  @doc("Copying from BlobFS to Local")
  BlobFSLocal: "BlobFSLocal",

  @doc("Copying from Blob to File")
  BlobFile: "BlobFile",

  @doc("Copying from Blob to Local")
  BlobLocal: "BlobLocal",

  @doc("Copying from Blob to Pipe")
  BlobPipe: "BlobPipe",

  @doc("Copying from File to Blob")
  FileBlob: "FileBlob",

  @doc("Copying from File to BlobFS")
  FileBlobFS: "FileBlobFS",

  @doc("Copying from File to File")
  FileFile: "FileFile",

  @doc("Copying from File to Local")
  FileLocal: "FileLocal",

  @doc("Copying from File to Pipe")
  FilePipe: "FilePipe",

  @doc("Copying from GCP to Blob")
  GCPBlob: "GCPBlob",

  @doc("Copying from Local to Blob")
  LocalBlob: "LocalBlob",

  @doc("Copying from Local to BlobFS")
  LocalBlobFS: "LocalBlobFS",

  @doc("Copying from Local to File")
  LocalFile: "LocalFile",

  @doc("Copying from Pipe to Blob")
  PipeBlob: "PipeBlob",

  @doc("Copying from Pipe to File")
  PipeFile: "PipeFile",

  @doc("Copying from S3 to Blob")
  S3Blob: "S3Blob",

  @doc("Copying from Blob to Trash")
  BlobTrash: "BlobTrash",

  @doc("Copying from File to Trash")
  FileTrash: "FileTrash",

  @doc("Copying from BlobFS to Trash")
  BlobFSTrash: "BlobFSTrash",

  string,
}

@doc("Blob Type")
union BlobType {
  @doc("Detect type")
  Detect: "Detect",

  @doc("BlockBlob type")
  BlockBlob: "BlockBlob",

  @doc("PageBlob type")
  PageBlob: "PageBlob",

  @doc("AppendBlob type")
  AppendBlob: "AppendBlob",

  string,
}

@doc("Overwrite Type")
union OverwriteType {
  @doc("True value")
  True: "True",

  @doc("False value")
  False: "False",

  @doc("IfSourceNewer value")
  IfSourceNewer: "IfSourceNewer",

  string,
}
