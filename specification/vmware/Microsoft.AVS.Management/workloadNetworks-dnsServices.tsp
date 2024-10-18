namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
// @armResourceOperations
@doc("Workload Network Dns Services")
interface WorkloadNetworkDnsServices {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListDnsServices")
  list is ArmResourceListByParent<
    WorkloadNetworkDnsService,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkDnsService,
      "{name}sList"
    >>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetDnsService")
  get is ArmResourceRead<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateDnsService")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkDnsService,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateDnsService")
  @parameterVisibility
  update is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsService
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "DnsServiceIdParameter should be last, but it is breaking to correct it."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteDnsService")
  // delete is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AVS/privateClouds/{privateCloudName}/workloadNetworks/default/dnsServices/{dnsServiceId}")
  @doc("Delete a {name}", WorkloadNetworkDnsService)
  @delete
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
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
  @visibility("read")
  status?: DnsServiceStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsServiceProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}
