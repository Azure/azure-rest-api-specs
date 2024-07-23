import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./UseCase.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Use Cases Resource Properties")
model HelmUseCaseProperties {
    @doc("Helm Chart URI of use case version")
    helmChartUri: string;

    @doc("Configuration schema of use case version")
    configurationSchema: string;

    @doc("Configuration template of use case version")
    configurationTemplate: string;

    @doc("Provisioning state of resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Use Case Resource")
@parentResource(UseCase)
model HelmUseCase is TrackedResource<HelmUseCaseProperties> {
    ...ResourceNameParameter<HelmUseCase>;
}

@armResourceOperations
interface HelmUseCases {
    @doc("Get a Use Case resource")
    get is ArmResourceRead<HelmUseCase>;

    @doc("Create or update a Use Case resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<HelmUseCase>;

    @doc("update a Use Case resource")
    update is ArmResourcePatchSync<HelmUseCase, HelmUseCaseProperties>;

    @doc("Delete a Use Case resource")
    delete is ArmResourceDeleteSync<HelmUseCase>;

    @doc("List by specified resource group")
    listByResourceGroup is ArmResourceListByParent<HelmUseCase>;

    @doc("List by subscription")
    listBySubscription is ArmListBySubscription<HelmUseCase>;
}
