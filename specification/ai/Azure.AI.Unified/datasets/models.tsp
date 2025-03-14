import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "../servicepatterns.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Unified;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",
}


@doc("DatasetVersion Definition")
@discriminator("datasetType")
model DatasetVersion is ServicePatterns.Versioned {
  @key
  @visibility("read")
  id: string;

  datasetUri: string;

  @doc("Data type")
  datasetType: DatasetType;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("UriFileDatasetVersion Definition")
model UriFileDatasetVersion extends DatasetVersion {
  @doc("[Required] Specifies the type of data.")
  datasetType: DatasetType.uri_file;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("UriFolderDatasetVersion Definition")
model UriFolderDatasetVersion extends DatasetVersion {
  @doc("[Required] Specifies the type of data.")
  datasetType: DatasetType.uri_folder;
}
