import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/UseCases_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

@doc("Use Case Resource")
@includeInapplicableMetadataInPayload(false)
model UseCasesResource is TrackedResource<UseCasesResourceProperties>{
    ...ResourceNameParameter<UseCasesResource>;
}

@armResourceOperations
interface UseCases{
    @doc("Get a Use Case resource")
    get is ArmResourceRead<UseCasesResource>;

    @doc("Create or update a Use Case resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<UseCasesResource>;

    @doc("update a Use Case resource")
    update is ArmResourcePatchAsync<
        UseCasesResource,
        UseCasesResourceProperties
    >;

    @doc("Delete a Use Case resource")
    delete is ArmResourceDeleteWithoutOkAsync<UseCasesResource>;

    @doc("List by specified resource group")
    listByResourceGroup is ArmResourceListByParent<UseCasesResource>;

    @doc("List by subscription")
    listBySubscription is ArmListBySubscription<UseCasesResource>;
}