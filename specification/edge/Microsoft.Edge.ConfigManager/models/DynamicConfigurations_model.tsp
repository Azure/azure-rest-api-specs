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

@doc("Configuration Properties")
model ConfigurationProperties {
    @doc("Timezone")
    timezone: string;

    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Dynamic Configuration Resource Properties")
model DynamicConfigurationResourceProperties {
    @doc("Current Version of the Dynamic Configuration")
    currentVersion: string;

    @doc("Target Resource of the Dynamic Configuration")
    targetResource?: string;

    @doc("Parent ID of the Dynamic Configuration")
    parentId?: string;
    
    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}