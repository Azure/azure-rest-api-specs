import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.DeviceRegistry;

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type: string;

  @doc("The extended location name.")
  name: string;
}
