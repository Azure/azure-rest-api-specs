import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/DeploymentTargets_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

@doc("Deployment Targets Resource")
@includeInapplicableMetadataInPayload(false)
model DeploymentTargetsResource is TrackedResource<DeploymentTargetsResourceProperties>{
    ...ResourceNameParameter<DeploymentTargetsResource>;

    @doc("Display Name of the Deployment Targets Resource")
    displayName: string;
}

@armResourceOperations
interface DeploymentTargets{
    @doc("Get a Deployment Targets Resource")
    get is ArmResourceRead<DeploymentTargetsResource>;

    @doc("Create or update a Deployment Targets Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentTargetsResource>;

    @doc("update a Deployment Targets Resource")
    update is ArmResourcePatchAsync<
        DeploymentTargetsResource,
        DeploymentTargetsResourceProperties
    >;

    @doc("Delete a Deployment Targets Resource")
    delete is ArmResourceDeleteWithoutOkAsync<DeploymentTargetsResource>;
}