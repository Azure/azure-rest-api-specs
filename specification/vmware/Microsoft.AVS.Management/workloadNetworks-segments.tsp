namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkSegments {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListSegments")
  list is ArmResourceListByParent<
    WorkloadNetworkSegment,
    Response = ArmResponse<ResourceList<WorkloadNetworkSegment, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetSegment")
  get is ArmResourceRead<WorkloadNetworkSegment>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateSegments")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkSegment,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateSegments")
  @parameterVisibility
  update is ArmCustomPatchAsync<WorkloadNetworkSegment, WorkloadNetworkSegment>;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteSegment")
  deleteSegment is ArmResourceDeleteAsync<WorkloadNetworkSegment>;
}

@@clientName(WorkloadNetworkSegments.create::parameters.resource,
  "workloadNetworkSegment"
);

@@clientName(WorkloadNetworkSegments.update::parameters.properties,
  "workloadNetworkSegment"
);

@doc("Segment status")
union SegmentStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network Segment provisioning state")
union WorkloadNetworkSegmentProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("NSX Segment")
@parentResource(WorkloadNetwork)
model WorkloadNetworkSegment
  is ProxyResource<WorkloadNetworkSegmentProperties> {
  @doc("The ID of the NSX Segment")
  @pattern("^[-\\w\\._]+$")
  @key("segmentId")
  @path
  @segment("segments")
  name: string;
}

@doc("NSX Segment Properties")
model WorkloadNetworkSegmentProperties {
  @doc("Display name of the segment.")
  displayName?: string;

  @doc("Gateway which to connect segment to.")
  connectedGateway?: string;

  @doc("Subnet which to connect segment to.")
  subnet?: WorkloadNetworkSegmentSubnet;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Port Vif which segment is associated with.")
  @visibility("read")
  portVif?: WorkloadNetworkSegmentPortVif[];

  @doc("Segment status.")
  @visibility("read")
  status?: SegmentStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkSegmentProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("Subnet configuration for segment")
model WorkloadNetworkSegmentSubnet {
  @doc("DHCP Range assigned for subnet.")
  dhcpRanges?: string[];

  @doc("Gateway address.")
  gatewayAddress?: string;
}

@doc("Ports and any VIF attached to segment.")
model WorkloadNetworkSegmentPortVif {
  @doc("Name of port or VIF attached to segment.")
  portName?: string;
}
