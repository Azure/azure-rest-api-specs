import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OnlineExperimentation;

/*
An online experiment workspace resource
*/
model OnlineExperimentWorkspace
    is Azure.ResourceManager.TrackedResource<OnlineExperimentWorkspaceProperties> {
    ...ResourceNameParameter<
        Resource = OnlineExperimentWorkspace,
        KeyName = "workspaceName",
        SegmentName = "workspaces"
    >;
    ...Azure.ResourceManager.ManagedServiceIdentityProperty;
    ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface OnlineExperimentWorkspaces {
    /**
     * Gets an experiment workspace
     */
    get is ArmResourceRead<OnlineExperimentWorkspace>;

    /**
     * Create an experiment workspace, or update an existing workspace
     */
    createOrUpdate is ArmResourceCreateOrUpdateAsync<OnlineExperimentWorkspace>;

    /**
     * Patch an experiment workspace
     */
    @parameterVisibility
    patch is ArmResourcePatchAsync<
        OnlineExperimentWorkspace,
        OnlineExperimentWorkspace
    >;

    /**
     * Deletes an experiment workspace
     */
    delete is ArmResourceDeleteWithoutOkAsync<OnlineExperimentWorkspace>;

    /**
     * Gets all experiment workspaces in a resource group.
     */
    listByResourceGroup is ArmResourceListByParent<OnlineExperimentWorkspace>;

    /**
     * Gets all experiment workspaces in the specified subscription.
     */
    listBySubscription is ArmListBySubscription<OnlineExperimentWorkspace>;
}
