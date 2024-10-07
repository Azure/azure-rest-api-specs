import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./providers.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using TypeSpec.Versioning;

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
