import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./CommonResources.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@doc("An exposure control feature resource")
model ExposureFeature is ProxyResource<ExposureFeatureProperties> {
  @doc("Name of Feature")
  @pattern("^[-\\w\\._]+$")
  @key("featureName")
  @path
  @segment("exposureFeatures")
  name: string;
}

@doc("Exposure Feature Properties")
model ExposureFeatureProperties {
  @doc("Exposure Feature description.")
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
