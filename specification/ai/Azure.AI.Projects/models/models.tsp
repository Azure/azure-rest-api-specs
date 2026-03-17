import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Provisioning state for the model version.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union AssetProvisioningState {
  string,

  @doc("Succeeded")
  Succeeded: "Succeeded",

  @doc("Failed")
  Failed: "Failed",

  @doc("Canceled")
  Canceled: "Canceled",

  @doc("Creating")
  Creating: "Creating",

  @doc("Updating")
  Updating: "Updating",

  @doc("Deleting")
  Deleting: "Deleting",
}

@doc("Flavor data for a model, containing flavor-specific key/value pairs.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FlavorData {
  @doc("Model flavor-specific data.")
  data?: Record<string>;
}

@doc("The destination asset for publishing a model to a registry.")
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

@doc("Model details.")
@Rest.resource("models")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model Model {
  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("The URI path to the model contents.")
  modelUri?: string;

  @doc("The storage format for this entity. Used for NCD.")
  modelType?: string;

  @doc("Mapping of model flavors to their properties.")
  flavors?: Record<FlavorData>;

  @doc("Stage in the model lifecycle assigned to this model.")
  stage?: string;

  @doc("Is the asset archived?")
  isArchived?: boolean;

  @doc("If the name version are system generated (anonymous registration).")
  isAnonymous?: boolean;

  @doc("Name of the training job which produced this model.")
  @visibility(Lifecycle.Read)
  jobName?: string;

  @doc("Provisioning state for the model version.")
  @visibility(Lifecycle.Read)
  provisioningState?: AssetProvisioningState;

  @doc("Fully qualified resource ID for the resource.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the resource.")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("Version identifier. This is case-sensitive.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;
}
