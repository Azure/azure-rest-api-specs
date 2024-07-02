import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "@typespec/openapi";
import "./CapabilityLists_model.tsp";

using TypeSpec.OpenAPI;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

@doc("Deployment Targets Resource Properties")
model DeploymentTargetsResourceProperties {
    @doc("Display Name of the Deployment Targets Resource")
    displayName: string;
    
    @doc("Custom location for the deployment target")
    customLocation: string;

    @doc("List of capabilities")
    @extension("x-ms-identifiers", [])
    capabilities: Capability[];

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
