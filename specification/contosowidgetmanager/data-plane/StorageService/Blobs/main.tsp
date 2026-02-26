// Blobs sub-service main.tsp - Data-plane sub-service TypeSpec project
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Contoso Blob Service",
})
@versioned(Versions)
@server(
  "{endpoint}/storage/blobs",
  "Contoso Blob Service",
  {
    endpoint: url,
  }
)
namespace Contoso.StorageService.Blobs;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_01_preview: "2024-01-01-preview",
}

@doc("A blob")
model Blob {
  @doc("Blob name")
  name: string;

  @doc("Container name")
  containerName: string;

  @doc("Blob size in bytes")
  size?: int64;

  @doc("Content type")
  contentType?: string;

  @doc("Last modified time")
  lastModified?: utcDateTime;
}

@doc("List blobs response")
model BlobListResult {
  @doc("List of blobs")
  value: Blob[];

  @doc("Next page link")
  nextLink?: url;
}

@route("/containers/{containerName}/blobs")
interface Blobs {
  @doc("List all blobs in a container")
  list(@path containerName: string): BlobListResult;

  @doc("Get a blob")
  @route("/{blobName}")
  get(@path containerName: string, @path blobName: string): Blob;

  @doc("Upload a blob")
  @route("/{blobName}")
  @put
  upload(@path containerName: string, @path blobName: string, @body content: bytes): Blob;

  @doc("Delete a blob")
  @route("/{blobName}")
  @delete
  delete(@path containerName: string, @path blobName: string): void;
}
