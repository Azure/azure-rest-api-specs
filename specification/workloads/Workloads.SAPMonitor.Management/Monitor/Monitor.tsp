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

namespace Microsoft.Workloads.Monitor;

@armResourceOperations
interface Monitors {
    /**
     * Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.
     */
    get is ArmResourceRead<Monitor>;

    /**
     * Creates a SAP monitor for the specified subscription, resource group, and resource name.
     */
    #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
    @Azure.Core.useFinalStateVia("azure-async-operation")
    create is ArmResourceCreateOrReplaceAsync<
        Monitor,
        LroHeaders = Azure.Core.Foundations.RetryAfterHeader
    >;

    /**
     * Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.
     */
    @parameterVisibility
    update is ArmCustomPatchAsync<Monitor, UpdateMonitorRequest>;

    /**
     * Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.
     */
    delete is ArmResourceDeleteWithoutOkAsync<Monitor>;

    /**
     * Gets a list of SAP monitors in the specified resource group.
     */
    listByResourceGroup is ArmResourceListByParent<Monitor>;

    /**
     * Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.
     */
    list is ArmListBySubscription<Monitor>;
}

@@doc(Monitors.create::parameters.resource,
    "Request body representing a SAP monitor"
);
@@doc(Monitors.update::parameters.properties,
    "The Update SAP workload monitor request body."
);
