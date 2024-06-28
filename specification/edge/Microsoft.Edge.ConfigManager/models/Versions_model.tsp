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

@doc("Use Case Version Resource Properties")
model UseCaseVersionResourceProperties {
    @doc("Helm Chart URI for the use case version")
    helmChartUri: string;

    @doc("Values Metadata File Path for the use case version")
    valuesMetadataFilePath: string;

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Configuration Version Resource Properties")
model ConfigurationVersionResourceProperties {
    @doc("Values for the configuration version")
    values: string;

    @doc("Provisioning state of the resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}