import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../models/DeploymentInstances_model.tsp";
import "./TargetBindings.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Deployment Instances Resource")
@parentResource(TargetBindingsResource)
model DeploymentInstancesResource is ProxyResource<DeploymentInstancesResourceProperties>{
    ...ResourceNameParameter<DeploymentInstancesResource>;
}

@armResourceOperations
interface DeploymentInstances{
    @doc("Get a Deployment Instances Resource")
    get is ArmResourceRead<DeploymentInstancesResource>;

    @doc("Create or update a Deployment Instances Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentInstancesResource>;

    @doc("update a Deployment Instances Resource")
    update is ArmResourcePatchAsync<
        DeploymentInstancesResource,
        DeploymentInstancesResourceProperties
    >;

    @doc("Delete a Deployment Instances Resource")
    delete is ArmResourceDeleteSync<DeploymentInstancesResource>;
}