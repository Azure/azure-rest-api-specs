namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network DNS Zones")
interface WorkloadNetworkDnsZones {
  list is ArmResourceListByParent<
    WorkloadNetworkDnsZone,
    Response = ArmResponse<ResourceList<WorkloadNetworkDnsZone, "{name}sList">>
  >;

  get is ArmResourceRead<WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDnsZone,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<WorkloadNetworkDnsZone, WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Can not change existing response codes."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsZoneIdParameter should be last, but it is breaking to correct it."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsZones/{dnsZoneId}")
  @doc("Delete a {name}", WorkloadNetworkDnsZone)
  @armResourceDelete(WorkloadNetworkDnsZone)
  delete(
    ...Foundations.BaseParameters<WorkloadNetworkDnsZone>,
    ...DnsZoneIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@clientName(WorkloadNetworkDnsZones.create::parameters.resource,
  "workloadNetworkDnsZone"
);

@@clientName(WorkloadNetworkDnsZones.update::parameters.properties,
  "workloadNetworkDnsZone"
);

@doc("Workload Network DNS Zone provisioning state")
union WorkloadNetworkDnsZoneProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("NSX DNS Zone")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsZone
  is ProxyResource<WorkloadNetworkDnsZoneProperties> {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @key("dnsZoneId")
  @path
  @segment("dnsZones")
  name: string;
}

@doc("Parameter for dnsZoneId")
model DnsZoneIdParameter {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @path
  dnsZoneId: string;
}

@doc("NSX DNS Zone Properties")
model WorkloadNetworkDnsZoneProperties {
  @doc("Display name of the DNS Zone.")
  displayName?: string;

  @doc("Domain names of the DNS Zone.")
  domain?: string[];

  @doc("DNS Server IP array of the DNS Zone.")
  dnsServerIps?: string[];

  @doc("Source IP of the DNS Zone.")
  sourceIp?: string;

  @doc("Number of DNS Services using the DNS zone.")
  dnsServices?: int64;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkDnsZoneProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("The type of DNS zone.")
union DnsZoneType {
  string,

  @doc("Primary DNS zone.")
  Public: "Public",

  @doc("Private DNS zone.")
  Private: "Private",
}
