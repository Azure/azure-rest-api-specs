import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./TargetBinding.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Deployment Instance Properties")
model DeploymentInstanceProperties {
    @doc("Use case version of deployment instance")
    useCaseVersion: string;

    @doc("Config Version of deployment instance")
    configVersion: string;

    @doc("Provisioning state of resource")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}

@doc("Deployment Instance Resource")
@parentResource(TargetBinding)
model DeploymentInstance is ProxyResource<DeploymentInstanceProperties> {
    ...ResourceNameParameter<DeploymentInstance>;
}

@armResourceOperations
interface DeploymentInstances {
    @doc("Get a Deployment Instance Resource")
    get is ArmResourceRead<DeploymentInstance>;

    @doc("Delete a Deployment Instance Resource")
    delete is ArmResourceDeleteWithoutOkAsync<DeploymentInstance>;

    @doc("List Deployment Instance Resources")
    listByParent is ArmResourceListByParent<DeploymentInstance>;
}
