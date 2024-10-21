using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;

@parentResource(Monitor)
@added(Versions.v2024_02_01_preview)
model AlertTemplate is ProxyResource<AlertTemplateProperties> {
    /**
     * Name of the Alert Template instance.
     */
    @pattern("^[a-zA-Z0-9-_]+$")
    @path
    @key("alertTemplate")
    @segment("alertTemplates")
    @visibility("read")
    name: string;
}

@added(Versions.v2024_02_01_preview)
@armResourceOperations
interface AlertTemplates {
    /**
     * Gets an Alert Template in the specified SAP monitor. The operations returns various properties of each provider instances.
     */
    get is ArmResourceRead<AlertTemplate>;

    /**
     * Gets a list of Alert Template in the specified SAP monitor. The operations returns various properties of each provider instances.
     */
    listByMonitor is ArmResourceListByParent<AlertTemplate>;
}
