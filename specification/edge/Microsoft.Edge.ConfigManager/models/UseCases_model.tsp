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

@doc("Use Cases Resource Properties")
model UseCasesResourceProperties {
    @doc("Current Version of the Use Cases")
    currentVersion: string;

    @doc("The list of capabilities")
    @extension("x-ms-identifiers", [])
    capabilities: Capability[];

    @doc("Metadata for the Use Cases")
    metadata: string;

    @doc("Values metadata for the Use Cases")
    valuesMetadata: string;

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
