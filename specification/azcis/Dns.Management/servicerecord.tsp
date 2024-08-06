import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("ServiceRecord properties")
model ServiceRecordResourceProperties {
  @doc("Gets or sets the dns name")
  dnsName: string;

  @doc("Gets or sets the priority field of a service record")
  priority: string;

  @doc("Gets or sets the weight field of a service record")
  weight: string;

  @doc("Gets or sets the port field of a service record")
  port: string;

  @doc("Gets or sets the canonical hostname of the target machine providing the service")
  canonicalName: string;

  @doc("Gets or sets the ttl")
  ttl: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ServiceRecordProvisioningState;
}

@doc("ServiceRecord Resource")
model ServiceRecordResource is ProxyResource<ServiceRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("serviceRecords") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
union ServiceRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface ServiceRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceRecordResource>;
  listBySubscription is ArmListBySubscription<ServiceRecordResource>;
  listByResourceGroup is ArmResourceListByParent<ServiceRecordResource>;
  get is ArmResourceRead<ServiceRecordResource>;
}
