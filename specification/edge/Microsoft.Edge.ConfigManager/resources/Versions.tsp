import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/Versions_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Use Case Version Resource")
model UseCaseVersionResource is ExtensionResource<UseCaseVersionResourceProperties>{
    ...ResourceNameParameter<UseCaseVersionResource>;

    @doc("Kind of the resource")
    kind: string = "UseCase";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Configuration Version Resource")
model ConfigurationVersionResource is ExtensionResource<ConfigurationVersionResourceProperties>{
    ...ResourceNameParameter<ConfigurationVersionResource>;

    @doc("Kind of the resource")
    kind: string = "Configuration";
}

@armResourceOperations
interface UseCaseVersion{
    @doc("Get a Capability Lists Resource")
    get is ArmResourceRead<UseCaseVersionResource>;

    @doc("Create or update a Capability Lists Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<UseCaseVersionResource>;

    @doc("update a Capability Lists Resource")
    update is ArmResourcePatchAsync<
        UseCaseVersionResource,
        UseCaseVersionResourceProperties
    >;

    @doc("Delete a Capability Lists Resource")
    delete is ArmResourceDeleteSync<UseCaseVersionResource>;
}

@armResourceOperations
interface ConfigurationVersion{
    @doc("Get a Capability Lists Resource")
    get is ArmResourceRead<ConfigurationVersionResource>;

    @doc("Create or update a Capability Lists Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigurationVersionResource>;

    @doc("update a Capability Lists Resource")
    update is ArmResourcePatchAsync<
        ConfigurationVersionResource,
        ConfigurationVersionResourceProperties
    >;

    @doc("Delete a Capability Lists Resource")
    delete is ArmResourceDeleteSync<ConfigurationVersionResource>;
}