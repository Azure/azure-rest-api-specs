import "./models.tsp";
import "./providers.tsp";

using Azure.ResourceManager;

namespace Microsoft.Workloads.Provider;

@armResourceOperations
interface ProviderInstances {
    /**
     * Gets properties of a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    get is ArmResourceRead<ProviderInstance>;

    /**
     * Creates a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrReplaceAsync<
        ProviderInstance,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Deletes a provider instance for the specified subscription, resource group, SAP monitor name, and resource name.
     */
    delete is ArmResourceDeleteWithoutOkAsync<ProviderInstance>;

    listByMonitor is ArmResourceListByParent<ProviderInstance>;
}

@@doc(ProviderInstances.create::parameters.resource,
    "Request body representing a provider instance associated with a SAP monitor."
);
