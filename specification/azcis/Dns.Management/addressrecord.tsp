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

@doc("AddressRecord properties")
model AddressRecordResourceProperties {
  @doc("Gets or sets the dns name")
  dnsName: string;

  @doc("Gets or sets the IP Address in String format")
  ipAddress: string;

  @doc("Gets or sets the ttl")
  ttl: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: AddressRecordProvisioningState;
}

@doc("AddressRecord Resource")
model AddressRecordResource is ProxyResource<AddressRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("addressRecords") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
union AddressRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface AddressRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AddressRecordResource>;
  listBySubscription is ArmListBySubscription<AddressRecordResource>;
  listByResourceGroup is ArmResourceListByParent<AddressRecordResource>;
  get is ArmResourceRead<AddressRecordResource>;
}
