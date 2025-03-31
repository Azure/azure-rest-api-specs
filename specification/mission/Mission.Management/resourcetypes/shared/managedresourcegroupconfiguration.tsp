import "@azure-tools/typespec-azure-core";

using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("ManagedResourceGroup related properties")
model ManagedResourceGroupConfiguration {
  @doc("Name of managed resource group")
  name?: string;

  @doc("The geo-location where the resource lives")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;
}
