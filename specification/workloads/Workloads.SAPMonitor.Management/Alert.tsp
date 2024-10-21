using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;
/**
 * A provider instance associated with SAP monitor.
 */
@parentResource(Monitor)
@added(Versions.v2024_02_01_preview)
model Alert is ProxyResource<AlertProperties> {
    /**
     * Name of the provider instance.
     */
    @pattern("^[a-zA-Z0-9-_]+$")
    @path
    @key("alert")
    @segment("alert")
    @visibility("read")
    name: string;
}

@added(Versions.v2024_02_01_preview)
@armResourceOperations
interface Alerts {
    /**
     * Gets properties of an Alert for the specified subscription, resource group, SAP monitor name, and resource name.
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
