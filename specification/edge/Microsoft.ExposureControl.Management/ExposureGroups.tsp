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

@doc("A exposure control group resource")
model ExposureGroup is ProxyResource<ExposureGroupProperties> {
  @doc("Name of Exposure Group")
  @pattern("^[-\\w\\._]+$")
  @key("groupName")
  @path
  @segment("exposureGroups")
  name: string;
}

@doc("Group Properties")
model ExposureGroupProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "Error items have no unique identifier."
  @doc("filter conditions.")
  @identifiers(#[])
  filterConditions: Array<FilterCondition>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Filter Conditions defined per group")
model FilterCondition {
  @doc("filter condition type.")
  type: string;

  @doc("filter condition values.")
  conditions: Array<string>;
}
