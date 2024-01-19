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

namespace Microsoft.Elastic;
@doc("Monitor resource.")
model ElasticMonitorResource is TrackedResource<MonitorProperties> {
  @doc("Monitor resource name")
  @path
  @key("monitorName")
  @segment("monitors")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ElasticMonitorResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the properties of a specific monitor resource.")
  @operationId("Monitors_Get")
  get is ArmResourceRead<ElasticMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a monitor resource.")
  @operationId("Monitors_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ElasticMonitorResource,
    BaseParameters<ElasticMonitorResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a monitor resource.")
  @operationId("Monitors_Update")
  update is ArmCustomPatchSync<
    ElasticMonitorResource,
    ElasticMonitorResourceUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a monitor resource.")
  @operationId("Monitors_Delete")
  delete is ArmResourceDeleteAsync<ElasticMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all monitors under the specified resource group.")
  @operationId("Monitors_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ElasticMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all monitors under the specified subscription.")
  @operationId("Monitors_List")
  list is ArmListBySubscription<ElasticMonitorResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the resources currently being monitored by the Elastic monitor resource.")
  @operationId("MonitoredResources_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    MonitoredResourceListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Fetch information regarding Elastic cloud deployment corresponding to the Elastic monitor resource.")
  @operationId("DeploymentInfo_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    DeploymentInfoResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the vm resources currently being monitored by the Elastic monitor resource.")
  @operationId("VMHost_List")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMHostListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the vm ingestion details that will be monitored by the Elastic monitor resource.")
  @operationId("VMIngestion_Details")
  details is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMIngestionDetailsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the vm details that will be monitored by the Elastic monitor resource.")
  @operationId("VMCollection_Update")
  update is ArmResourceActionSync<
    ElasticMonitorResource,
    VMCollectionUpdate,
    void
  >;
}

@@projectedName(ElasticMonitorResources.create::parameters.resource,
  "json",
  "body"
);
@@extension(ElasticMonitorResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ElasticMonitorResources.create::parameters.resource,
  "Elastic monitor resource model"
);
@@projectedName(ElasticMonitorResources.update::parameters.properties,
  "json",
  "body"
);
@@extension(ElasticMonitorResources.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(ElasticMonitorResources.update::parameters.properties,
  "Elastic resource model update parameters."
);
@@doc(ElasticMonitorResources.update::parameters.body, "VM resource Id");
