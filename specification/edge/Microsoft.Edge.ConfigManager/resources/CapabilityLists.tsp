import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/CapabilityLists_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

@doc("Capability Lists Resource")
@includeInapplicableMetadataInPayload(false)
model CapabilityListsResource is TrackedResource<CapabilityListsResourceProperties>{
    ...ResourceNameParameter<CapabilityListsResource>;
}

@armResourceOperations
interface CapabilityLists{
    @doc("Get a Capability Lists Resource")
    get is ArmResourceRead<CapabilityListsResource>;

    @doc("Create or update a Capability Lists Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<CapabilityListsResource>;

    @doc("update a Capability Lists Resource")
    update is ArmResourcePatchAsync<
        CapabilityListsResource,
        CapabilityListsResourceProperties
    >;

    @doc("Delete a Capability Lists Resource")
    delete is ArmResourceDeleteWithoutOkAsync<CapabilityListsResource>;
}