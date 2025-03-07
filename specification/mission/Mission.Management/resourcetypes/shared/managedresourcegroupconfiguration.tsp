@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("ManagedResourceGroup related properties")
model ManagedResourceGroupConfiguration {
  @doc("Name of managed resource group")
  name?: string;

  @doc("The geo-location where the resource lives")
  location?: string;
}
