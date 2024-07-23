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

namespace Microsoft.Edge;

@doc("Target Binding Properties")
model TargetBindingProperties {
    @doc("Use Case of target binding")
    useCase: string;

    @doc("Deployment Target of target binding")
    deploymentTarget: string;

    @doc("Active Deployment Instance of target binding")
    activeDeploymentInstance: string;

    @doc("Scope of target binding")
    scope: string;

    @doc("Provisioning state of resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Target Binding Resource")
model TargetBinding is TrackedResource<TargetBindingProperties> {
    ...ResourceNameParameter<TargetBinding>;
}

@armResourceOperations
interface TargetBindings {
    @doc("Get a Target Binding Resource")
    get is ArmResourceRead<TargetBinding>;

    @doc("Create or update a Target Binding Resource")
    createOrUpdate is ArmResourceCreateOrReplaceAsync<TargetBinding>;

    @doc("update a Target Binding Resource")
    update is ArmResourcePatchSync<TargetBinding, TargetBindingProperties>;

    @doc("Delete a Target Binding Resource")
    delete is ArmResourceDeleteSync<TargetBinding>;

    @doc("List by specified resource group")
    listByResourceGroup is ArmResourceListByParent<TargetBinding>;

    @doc("List by subscription")
    listBySubscription is ArmListBySubscription<TargetBinding>;

    @doc("Post request to deploy for Deployment Target Resource")
    deploy is ArmResourceActionNoResponseContentAsync<TargetBinding, void>;
}
