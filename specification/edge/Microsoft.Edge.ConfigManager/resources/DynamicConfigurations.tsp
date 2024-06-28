import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/DynamicConfigurations_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

model Configuration is TrackedResource<ConfigurationProperties> {
    ...ResourceNameParameter<Configuration>;
}


@doc("Dynamic Configuration Resource")
@includeInapplicableMetadataInPayload(false)
@parentResource(Configuration)
model DynamicConfigurationResource is ProxyResource<DynamicConfigurationResourceProperties>{
    ...ResourceNameParameter<DynamicConfigurationResource>;
}

@armResourceOperations
interface DynamicConfiguration{
    @doc("Get a Dynamic Configuration Resource")
    get is ArmResourceRead<DynamicConfigurationResource>;

    @doc("Create or update a Dynamic Configuration Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<DynamicConfigurationResource>;

    @doc("update a Dynamic Configuration Resource")
    update is ArmResourcePatchAsync<
        DynamicConfigurationResource,
        DynamicConfigurationResourceProperties
    >;

    @doc("Delete a Dynamic Configuration Resource")
    delete is ArmResourceDeleteWithoutOkAsync<DynamicConfigurationResource>;
}
