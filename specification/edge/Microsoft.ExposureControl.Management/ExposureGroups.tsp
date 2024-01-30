import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
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

@doc("A exposure control group resource")
model ExposureGroup is ProxyResource<ExposureGroupProperties> {
  @doc("Name of Group")
  @pattern("^[-\\w\\._]+$")
  @key("groupName")
  @path
  @segment("groups")
  name: string;
}

@doc("Group Properties")
model ExposureGroupProperties {
  
  @doc("filter conditions.")
  filterConditions: Array<FilterCondition>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Filter Conditions")
model FilterCondition {
  @doc("type.")
  type: string;

  @doc("values.")
  values: Array<string>;
}

