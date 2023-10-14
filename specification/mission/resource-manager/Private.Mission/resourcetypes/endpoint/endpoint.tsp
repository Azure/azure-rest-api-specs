import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../virtualEnclave/virtualenclave.tsp";
import "../shared/endpointRule.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("Endpoint Resource properties")
model EndpointProperties {
  @doc("Endpoint Description.")
  description?: string;

  @extension("x-ms-identifiers", ["name"])
  @doc("Endpoint Rule Collection.")
  endpointRuleCollection?: EndpointRule[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
