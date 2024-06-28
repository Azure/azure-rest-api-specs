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

@doc("Target Bindings Resource Properties")
model TargetBindingsResourceProperties {
    @doc("Use Case of the Target Bindings")
    useCase: string;

    @doc("Target of the Target Bindings")
    target: string;

    @doc("Active Instances of the Target Bindings")
    activeInstances: string;

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
