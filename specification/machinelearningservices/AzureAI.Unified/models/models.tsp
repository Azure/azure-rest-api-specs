import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("Model Container Definition")
model ModelContainer extends AssetContainer {
  @doc("Provisioning state for the model container.")
  @visibility("read")
  provisioningState?: AssetProvisioningState;
}

@doc("Model Version Definition")
model ModelVersion extends AssetBase {
  @doc("Mapping of model flavors to their properties.")
  flavors?: Record<FlavorData>;

  @doc("Name of the training job which produced this model.")
  jobName?: string;

  @doc("The storage format for this entity. Used for NCD.")
  modelType?: string;

  @doc("The URI path to the model contents.")
  modelUri?: string;

  @doc("Provisioning state for the model version.")
  @visibility("read")
  provisioningState: AssetProvisioningState;

  @doc("Stage in the model lifecycle assigned to this model.")
  stage?: string;
}

@doc("Paged collection of ModelVersion items.")
@pagedResult
model PagedModelVersion {
  @doc("The list of model versions.")
  @extension("x-ms-identifiers", [])
  @items
  value: ModelVersion[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<ModelVersion>;
}

@doc("Asset Provisioning State Definition")
enum AssetProvisioningState {
  @doc("The operation succeeded.")
  Succeeded: "Succeeded",

  @doc("The operation failed.")
  Failed: "Failed",

  @doc("The operation was canceled.")
  Canceled: "Canceled",

  @doc("The operation is creating.")
  Creating: "Creating",

  @doc("The operation is updating.")
  Updating: "Updating",

  @doc("The operation is deleting.")
  Deleting: "Deleting",
}

@doc("Flavor Data Definition")
model FlavorData {
  @doc("Model flavor-specific data.")
  data?: Record<string>;
}
