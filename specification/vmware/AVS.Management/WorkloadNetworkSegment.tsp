import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("NSX Segment")
@parentResource(PrivateCloud)
model WorkloadNetworkSegment
  is ProxyResource<WorkloadNetworkSegmentProperties> {
  @doc("NSX Segment identifier. Generally the same as the Segment's display name")
  @path
  @key("segmentId")
  @segment("segments")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkSegments {
  @doc("Get a segment by id in a private cloud workload network.")
  getSegment is ArmResourceRead<WorkloadNetworkSegment>;
  @doc("Create a segment by id in a private cloud workload network.")
  createSegments is ArmResourceCreateOrUpdateAsync<WorkloadNetworkSegment>;
  @doc("Create or update a segment by id in a private cloud workload network.")
  updateSegments is ArmResourcePatchAsync<
    WorkloadNetworkSegment,
    WorkloadNetworkSegmentProperties
  >;
  @doc("Delete a segment by id in a private cloud workload network.")
  deleteSegment is ArmResourceDeleteAsync<WorkloadNetworkSegment>;
  @doc("List of segments in a private cloud workload network.")
  listSegments is ArmResourceListByParent<WorkloadNetworkSegment>;
}
