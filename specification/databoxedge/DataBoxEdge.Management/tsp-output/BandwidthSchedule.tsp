import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataBoxEdge;
@doc("The bandwidth schedule details.")
@parentResource(DataBoxEdgeDevice)
model BandwidthSchedule is ProxyResource<BandwidthScheduleProperties> {
  @doc("The bandwidth schedule name.")
  @key("name")
  @segment("bandwidthSchedules")
  name: string;
}

@armResourceOperations
interface BandwidthSchedules {
  @doc("Gets the properties of the specified bandwidth schedule.")
  get is ArmResourceRead<BandwidthSchedule>;

  @doc("Creates or updates a bandwidth schedule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BandwidthSchedule>;

  @doc("Deletes the specified bandwidth schedule.")
  delete is ArmResourceDeleteAsync<BandwidthSchedule>;

  @doc("Gets all the bandwidth schedules for a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<BandwidthSchedule>;
}
