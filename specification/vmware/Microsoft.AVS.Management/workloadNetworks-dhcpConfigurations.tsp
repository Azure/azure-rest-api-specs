namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
// @armResourceOperations
interface WorkloadNetworkDhcpConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDhcp")
  list is ArmResourceListByParent<
    WorkloadNetworkDhcp,
    Response = ArmResponse<ResourceList<WorkloadNetworkDhcp>>
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DhcpIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDhcp")
  // get is ArmResourceRead<WorkloadNetworkDhcp>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dhcpConfigurations/{dhcpId}")
  @doc("Get a {name}", WorkloadNetworkDhcp)
  @get
  get(
    ...Foundations.BaseParameters<WorkloadNetworkDhcp>,
    ...DhcpIdParameter,
    ...PrivateCloudNameParameter,
  ): ArmResponse<WorkloadNetworkDhcp> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDhcp")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDhcp,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDhcp")
  @parameterVisibility
  update is ArmCustomPatchAsync<WorkloadNetworkDhcp, WorkloadNetworkDhcp>;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDhcp")
  delete is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;
}

@@clientName(WorkloadNetworkDhcpConfigurations.create::parameters.resource,
  "workloadNetworkDhcp"
);

@@clientName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "workloadNetworkDhcp"
);

@@clientName(WorkloadNetworkDhcpConfigurations.update::parameters.properties,
  "workloadNetworkDhcp"
);

@doc("Workload Network DHCP provisioning state")
union WorkloadNetworkDhcpProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("NSX DHCP")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDhcp is ProxyResource<WorkloadNetworkDhcpEntity> {
  @doc("The ID of the DHCP configuration")
  @pattern("^[-\\w\\._]+$")
  @key("dhcpId")
  @path
  @segment("dhcpConfigurations")
  name: string;
}

@doc("Parameter for dhcpId")
model DhcpIdParameter {
  @doc("The ID of the DHCP configuration")
  @pattern("^[-\\w\\._]+$")
  @path
  dhcpId: string;
}

@doc("Type of DHCP: SERVER or RELAY.")
union DhcpTypeEnum {
  SERVER: "SERVER",
  RELAY: "RELAY",
  string,
}
@doc("""
  Base class for WorkloadNetworkDhcpServer and WorkloadNetworkDhcpRelay to
  inherit from
  """)
@discriminator("dhcpType")
model WorkloadNetworkDhcpEntity {
  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum;

  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Segments consuming DHCP.")
  @visibility("read")
  segments?: string[];

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDhcpProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("NSX DHCP Server")
model WorkloadNetworkDhcpServer extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Server Address.")
  serverAddress?: string;

  @doc("DHCP Server Lease Time.")
  leaseTime?: int64;

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum.SERVER;
}

@doc("NSX DHCP Relay")
model WorkloadNetworkDhcpRelay extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Relay Addresses. Max 3.")
  @minItems(1)
  @maxItems(3)
  serverAddresses?: string[];

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum.RELAY;
}
