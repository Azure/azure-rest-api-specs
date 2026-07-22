import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./CostDetails.tsp";
import "./CostComponent.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Cost details for workloads.")
model CostDetailsV2 {
  ...CostDetails;

  @doc("License cost details for workloads.")
  @visibility(Lifecycle.Read)
  licenseCostDetails: LicenseCostDetails;
}

@doc("Details of license costs for on-premises workloads.")
model LicenseCostDetails {
  @doc("Total license cost for on-premises workloads.")
  licenseCost: float32;

  @doc("List of license cost components.")
  @identifiers(#[])
  licenseCostComponents: CostComponent[];
}
