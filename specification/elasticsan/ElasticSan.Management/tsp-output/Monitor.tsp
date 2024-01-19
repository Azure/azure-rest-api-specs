import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
@doc("SAP monitor info on Azure (ARM properties and SAP monitor properties)")
model Monitor is TrackedResource<MonitorProperties> {
  @doc("Name of the SAP monitor resource.")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Monitors {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets properties of a SAP monitor for the specified subscription, resource group, and resource name.")
  @operationId("monitors_Get")
  get is ArmResourceRead<Monitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a SAP monitor for the specified subscription, resource group, and resource name.")
  @operationId("monitors_Create")
  create is ArmResourceCreateOrUpdateAsync<
    Monitor,
    BaseParameters<Monitor>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches the Tags field of a SAP monitor for the specified subscription, resource group, and SAP monitor name.")
  @operationId("monitors_Update")
  update is ArmCustomPatchSync<Monitor, UpdateMonitorRequest>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a SAP monitor with the specified subscription, resource group, and SAP monitor name.")
  @operationId("monitors_Delete")
  delete is ArmResourceDeleteAsync<
    Monitor,
    BaseParameters<Monitor>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of SAP monitors in the specified resource group.")
  @operationId("monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Monitor>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of SAP monitors in the specified subscription. The operations returns various properties of each SAP monitor.")
  @operationId("monitors_List")
  list is ArmListBySubscription<Monitor>;
}

@@projectedName(Monitors.create::parameters.resource,
  "json",
  "MonitorParameter"
);
@@extension(Monitors.create::parameters.resource,
  "x-ms-client-name",
  "MonitorParameter"
);
@@doc(Monitors.create::parameters.resource,
  "Request body representing a SAP monitor"
);
@@projectedName(Monitors.update::parameters.properties, "json", "body");
@@extension(Monitors.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Monitors.update::parameters.properties,
  "The Update SAP workload monitor request body."
);
