import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Flavor data for a model version, containing flavor-specific key/value pairs.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FlavorData {
  @doc("Flavor-specific key/value pairs, e.g. {\"loader_module\": \"mlflow.pyfunc\", \"python_version\": \"3.9\"}.")
  data?: Record<string>;
}

@doc("The destination asset for publishing a model version to a registry.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DestinationAsset {
  @doc("Target registry name to publish the model to.")
  registryName: string;

  @doc("Asset name in the destination registry. Defaults to the source asset name if not provided.")
  destinationName?: string;

  @doc("Version to assign in the destination registry. Defaults to the source version if not provided.")
  destinationVersion?: string;
}

@doc("Represents a model version resource.")
@Rest.resource("models")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model ModelVersion {
  @doc("Additional properties bag.")
  properties?: Record<string>;

  @doc("URI of the model artifact, typically a dataset ID returned by datasets.upload_folder().")
  modelUri?: string;

  @doc("The type of the model, e.g. \"custom_model\", \"mlflow_model\", \"triton_model\".")
  modelType?: string;

  @doc("Flavor data for the model version. Keys are flavor names, values contain flavor-specific properties.")
  flavors?: Record<FlavorData>;

  @doc("The lifecycle stage of the model version, e.g. \"Development\", \"Staging\", \"Production\", \"Archived\".")
  stage?: string;

  @doc("Whether the model version is archived.")
  isArchived?: boolean;

  @doc("Whether the model version is anonymous.")
  isAnonymous?: boolean;

  @doc("The name of the training job that produced this model version.")
  @visibility(Lifecycle.Read)
  jobName?: string;

  @doc("The provisioning state of the model version.")
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  ...AssetBase;
}
