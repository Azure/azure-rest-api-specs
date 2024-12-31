import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.OnlineExperimentation;

/**
 * The properties of an online experiment workspace.
 */
model OnlineExperimentWorkspaceProperties {
    /** The Id of the workspace. */
    @visibility("read")
    workspaceId?: string;

    /**
     * The provisioning state for the resource
     */
    @visibility("read")
    provisioningState?: ResourceProvisioningState;

    /**
     * The resource identifier of the Log Analytics workspace which online experiment workspace uses for generating experiment analysis results.
     */
    logAnalyticsWorkspaceResourceId?: Azure.Core.armResourceIdentifier<[
        {
            type: "Microsoft.OperationalInsights/workspaces";
        }
    ]>;

    /**
     * The resource identifier of storage account where logs are exported from Log Analytics workspace. Online Experiment workspace uses it generating experiment analysis results.
     */
    logsExporterStorageAccountResourceId?: Azure.Core.armResourceIdentifier<[
        {
            type: "Microsoft.Storage/storageAccounts";
        }
    ]>;
}
