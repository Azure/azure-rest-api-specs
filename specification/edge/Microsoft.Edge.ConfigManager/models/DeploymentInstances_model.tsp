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

@doc("Deployment Instances Resource Properties")
model DeploymentInstancesResourceProperties {
    @doc("Use case version of the deployment instance")
    useCaseVersion: string;

    @doc("Config Version of the deployment instance")
    configVersion: string;

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
