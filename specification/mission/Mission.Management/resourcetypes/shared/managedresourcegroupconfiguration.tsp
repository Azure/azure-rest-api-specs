import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;
@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@removed(Microsoft.Mission.Versions.v2025_05_01_preview)
@doc("ManagedResourceGroup related properties")
model ManagedResourceGroupConfiguration {
  @doc("Name of managed resource group")
  name?: string;

  @doc("The geo-location where the resource lives")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: azureLocation;
}
