namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network Dns Services")
interface WorkloadNetworkDnsServices {
  list is ArmResourceListByParent<
    WorkloadNetworkDnsService,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkDnsService,
      "{name}sList"
    >>
  >;

  get is ArmResourceRead<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDnsService,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsService
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Can not change existing response codes."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsServiceIdParameter should be last, but it is breaking to correct it."
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @doc("Delete a {name}", WorkloadNetworkDnsService)
  @armResourceDelete(WorkloadNetworkDnsService)
  delete(
    ...Foundations.BaseParameters<WorkloadNetworkDnsService>,
    ...DnsServiceIdParameter,
    ...PrivateCloudNameParameter,
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}

@@clientName(WorkloadNetworkDnsServices.create::parameters.resource,
  "workloadNetworkDnsService"
);

@@clientName(WorkloadNetworkDnsServices.update::parameters.properties,
  "workloadNetworkDnsService"
);

@doc("DNS service log level")
union DnsServiceLogLevelEnum {
  string,

  @doc("is debug")
  DEBUG: "DEBUG",

  @doc("is info")
  INFO: "INFO",

  @doc("is warning")
  WARNING: "WARNING",

  @doc("is error")
  ERROR: "ERROR",

  @doc("is fatal")
  FATAL: "FATAL",
}

@doc("DNS service status")
union DnsServiceStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network DNS Service provisioning state")
union WorkloadNetworkDnsServiceProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("NSX DNS Service")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsService
  is ProxyResource<WorkloadNetworkDnsServiceProperties> {
  @doc("ID of the DNS service.")
  @pattern("^[-\\w\\._]+$")
  @key("dnsServiceId")
  @path
  @segment("dnsServices")
  name: string;
}

@doc("Parameter for dnsServiceId")
model DnsServiceIdParameter {
  @doc("ID of the DNS service.")
  @pattern("^[-\\w\\._]+$")
  @path
  dnsServiceId: string;
}

@doc("NSX DNS Service Properties")
model WorkloadNetworkDnsServiceProperties {
  @doc("Display name of the DNS Service.")
  displayName?: string;

  @doc("DNS service IP of the DNS Service.")
  dnsServiceIp?: string;

  @doc("Default DNS zone of the DNS Service.")
  defaultDnsZone?: string;

  @doc("FQDN zones of the DNS Service.")
  fqdnZones?: string[];

  @doc("DNS Service log level.")
  logLevel?: DnsServiceLogLevelEnum;

  @doc("DNS Service status.")
  @visibility(Lifecycle.Read)
  status?: DnsServiceStatusEnum;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkDnsServiceProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}
