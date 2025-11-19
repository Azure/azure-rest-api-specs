import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Enum to determine the type of data.")
union DatasetType {
  string,

  @doc("URI file.")
  uri_file: "uri_file",

  @doc("URI folder.")
  uri_folder: "uri_folder",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("DatasetVersion Definition")
@Rest.resource("datasets")
@discriminator("type")
@added(Versions.v2025_05_01)
model DatasetVersion {
  @doc("URI of the data. Example: https://go.microsoft.com/fwlink/?linkid=2202330")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;

  @doc("Dataset type")
  type: DatasetType;

  @doc("Indicates if the dataset holds a reference to the storage, or the dataset manages storage itself. If true, the underlying data will not be deleted when the dataset version is deleted")
  @visibility(Lifecycle.Read)
  isReference?: boolean;

  @doc("The Azure Storage Account connection name. Required if startPendingUploadVersion was not called before creating the Dataset")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectionName?: string;

  ...AssetBase;
}

@doc("FileDatasetVersion Definition")
@added(Versions.v2025_05_01)
model FileDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_file;
}

@doc("FileDatasetVersion Definition")
@added(Versions.v2025_05_01)
model FolderDatasetVersion extends DatasetVersion {
  @doc("Dataset type")
  type: DatasetType.uri_folder;
}
