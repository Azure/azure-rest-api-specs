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

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DataContainer Definition")
@discriminator("dataType")
model DataContainer extends AssetContainer {
  @doc("[Required] Specifies the type of data")
  @visibility("read", "create")
  dataType: DataType;
}

@doc("PagedDataContainer Definition")
@pagedResult
model PagedDataContainer {
  @doc("The list of DataContainers.")
  @extension("x-ms-identifiers", [])
  @items
  value: DataContainer[];

  @doc("The link to the next page of results, if any.")
  @nextLink
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DataVersionBase Definition")
@discriminator("dataType")
model DataVersionBase extends AssetBase {
  @doc("[Required] Uri of the data. Example: https://go.microsoft.com/fwlink/?linkid=2202330")
  @visibility("read", "create")
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;

  @doc("Data type")
  dataType: DataType;
}

@doc("PagedDataVersionBase Definition")
@pagedResult
model PagedDataVersionBase {
  @doc("The list of DataVersions.")
  @extension("x-ms-identifiers", [])
  @items
  value: DataVersionBase[];

  @doc("The link to the next page of results, if any.")
  @nextLink
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("UriFileDataVersion Definition")
model UriFileDataVersion extends DataVersionBase {
  @doc("[Required] Specifies the type of data.")
  dataType: DataType.uri_file;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("UriFolderDataVersion Definition")
model UriFolderDataVersion extends DataVersionBase {
  @doc("[Required] Specifies the type of data.")
  dataType: DataType.uri_folder;
}
