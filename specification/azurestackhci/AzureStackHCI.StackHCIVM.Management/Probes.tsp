import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Probe resource.")
@parentResource(LoadBalancer)
@added(Versions.v2025_09_01_preview)
model Probe is ProxyResource<ProbeProperties> {
  @doc("Name of the probe.")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("probeName")
  @segment("probes")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface Probes {
  @doc("Gets the specified probe.")
  get is ArmResourceRead<Probe>;

  @doc("Creates or updates a probe in the specified resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Probe>;

  @doc("Deletes the specified probe.")
  delete is ArmResourceDeleteWithoutOkAsync<Probe>;

  @doc("Gets all probes in a Load Balancer.")
  listByNetworkSecurityGroup is ArmResourceListByParent<Probe>;
}
