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

namespace Microsoft.Workloads.AlertTemplate;

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
