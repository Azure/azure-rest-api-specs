import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DatasetVersion Definition")
@discriminator("type")
model DatasetVersion {
  @doc("[Required] Uri of the data. Example: https://go.microsoft.com/fwlink/?linkid=2202330")
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  datasetUri: string;

  @doc("Dataset type")
  type: DatasetType;

  ...AssetBase;
}

@doc("FileDatasetVersion Definition")
model FileDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_file;

  @doc("Indicates OpenAI Purpose. FileDatasets created with this field will be compatible with OpenAI-specific features")
  openAIPurpose: string;
}

@doc("FileDatasetVersion Definition")
model FolderDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_folder;
}


@doc("PagedDataVersionBase Definition")
@pagedResult
model PagedDatasetVersion {
  @doc("The list of DatasetVersions.")
  @extension("x-ms-identifiers", [])
  @items
  value: DatasetVersion[];

  @doc("The link to the next page of results, if any.")
  @nextLink
  nextLink?: string;
}
