import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("AssetVersion Definition")
model AssetVersion {
  @doc("Fully qualified resource Id: azureml://workspace/{workspaceName}/indexes/{name}/versions/{version} of the index.")
  @visibility("read")
  id: string;

  @doc("Update stage to 'Archive' to archive the asset. Default is Development, which means the asset is under development.")
  stage?: string = "Development";

  @doc("Description information of the asset.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Asset's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Asset's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;
}

@doc("Index resource Definition")
model Index is AssetVersion {
  @doc("Default workspace blob storage Uri. Should work across storage types and auth scenarios.")
  storageUri: string;
}

@doc("Paged collection of IndexVersion items.")
@pagedResult
model PagedIndex {
  @doc("The list of Indexes.")
  @extension("x-ms-identifiers", [])
  @items
  value: Index[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Index>;
}

@doc("Next version definition.")
model VersionInfo {
  @doc("Next version as defined by the server. The server keeps track of all versions that are string-representations of integers. If one exists, the nextVersion will be a string representation of the highest integer value + 1. Otherwise, the nextVersion will default to '1'.")
  nextVersion?: int64;

  @doc("Current latest version of the resource.")
  latestVersion: string;
}
