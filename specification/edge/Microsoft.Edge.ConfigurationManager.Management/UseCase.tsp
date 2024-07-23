import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./CapabilityList.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Types of deployment models")
union deploymentModelTypes {
    @doc("Deployment model Helm")
    Helm: "Helm",

    string,
}

@doc("Use Case Properties")
model UseCaseProperties {
    @doc("Current Version of use case")
    currentVersion: string;

    @doc("List of capabilities")
    @extension("x-ms-identifiers", [])
    capabilities: Capability[];

    @doc("Deployment Model of use case")
    deploymentModel: deploymentModelTypes.Helm;

    @doc("Description of use case")
    description: string;

    @doc("Provisioning state of resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Use Case Resource")
model UseCase is TrackedResource<UseCaseProperties> {
    ...ResourceNameParameter<UseCase>;
}

@armResourceOperations
interface UseCases {
    @doc("Get a Use Case resource")
    get is ArmResourceRead<UseCase>;

    @doc("Create or update a Use Case resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<UseCase>;

    @doc("update a Use Case resource")
    update is ArmResourcePatchSync<UseCase, UseCaseProperties>;

    @doc("Delete a Use Case resource")
    delete is ArmResourceDeleteSync<UseCase>;

    @doc("List by specified resource group")
    listByResourceGroup is ArmResourceListByParent<UseCase>;

    @doc("List by subscription")
    listBySubscription is ArmListBySubscription<UseCase>;
}
