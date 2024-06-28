import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "@typespec/openapi";

using TypeSpec.OpenAPI;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Edge;

@doc("Capability Properties")
model Capability {
    @doc("Name of the capability")
    name: string;

    @doc("Description of the capability")
    description: string;
}

@doc("Capability List Resource Properties")
model CapabilityListsResourceProperties {
    @doc("List of capabilities")
    @extension("x-ms-identifiers", [])
    capabilities: Capability[];

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
