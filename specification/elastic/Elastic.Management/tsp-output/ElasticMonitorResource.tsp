import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Elastic;
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
  @doc("Get the properties of a specific monitor resource.")
  get is ArmResourceRead<ElasticMonitorResource>;
  @doc("Create a monitor resource.")
  create is ArmResourceCreateOrUpdateAsync<ElasticMonitorResource>;
  @doc("Update a monitor resource.")
  update is ArmTagsPatchSync<ElasticMonitorResource>;
  @doc("Delete a monitor resource.")
  delete is ArmResourceDeleteAsync<ElasticMonitorResource>;
  @doc("List all monitors under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<ElasticMonitorResource>;
  @doc("List all monitors under the specified subscription.")
  list is ArmListBySubscription<ElasticMonitorResource>;
  @doc("List the resources currently being monitored by the Elastic monitor resource.")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    MonitoredResourceListResponse
  >;
  @doc("Fetch information regarding Elastic cloud deployment corresponding to the Elastic monitor resource.")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    DeploymentInfoResponse
  >;
  @doc("List the vm resources currently being monitored by the Elastic monitor resource.")
  list is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMHostListResponse
  >;
  @doc("List the vm ingestion details that will be monitored by the Elastic monitor resource.")
  details is ArmResourceActionSync<
    ElasticMonitorResource,
    void,
    VMIngestionDetailsResponse
  >;
  @doc("Update the vm details that will be monitored by the Elastic monitor resource.")
  update is ArmResourceActionSync<
    ElasticMonitorResource,
    VMCollectionUpdate,
    void
  >;
}
