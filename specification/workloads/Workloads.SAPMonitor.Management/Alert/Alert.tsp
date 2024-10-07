import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using TypeSpec.Versioning;

namespace Microsoft.Workloads.Alert;

@added(Versions.v2024_02_01_preview)
@armResourceOperations
interface Alerts {
    /**
     * Gets proprties of an Alert for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    get is ArmResourceRead<Alert>;

    /**
     * Creates An Alert for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrReplaceAsync<
        Alert,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Deletes a Alert for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    delete is ArmResourceDeleteWithoutOkAsync<Alert>;

    /**
     * Gets a list of Alert in the specified SAP monitor. The operations returns various properties of each provider instances.
     */
    listByMonitor is ArmResourceListByParent<Alert>;
}
