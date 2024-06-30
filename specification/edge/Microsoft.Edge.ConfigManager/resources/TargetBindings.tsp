import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/TargetBindings_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

@doc("Target Bindings Resource")
@includeInapplicableMetadataInPayload(false)
model TargetBindingsResource is TrackedResource<TargetBindingsResourceProperties>{
    ...ResourceNameParameter<TargetBindingsResource>;
}

@armResourceOperations
interface TargetBindings{
    @doc("Get a Target Bindings Resource")
    get is ArmResourceRead<TargetBindingsResource>;

    @doc("Create or update a Target Bindings Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<TargetBindingsResource>;

    @doc("update a Target Bindings Resource")
    update is ArmResourcePatchAsync<
        TargetBindingsResource,
        TargetBindingsResourceProperties
    >;

    @doc("Delete a Target Bindings Resource")
    delete is ArmResourceDeleteWithoutOkAsync<TargetBindingsResource>;

    @doc("List by specified resource group")
    listByResourceGroup is ArmResourceListByParent<TargetBindingsResource>;

    @doc("List by subscription")
    listBySubscription is ArmListBySubscription<TargetBindingsResource>;
}