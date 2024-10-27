import "./models.tsp";

using Azure.ResourceManager;
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
