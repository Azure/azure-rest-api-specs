import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Diagnostics package resource.")
@parentResource(PacketCoreControlPlane)
model MobileNetworkDiagnosticsPackage
  is ProxyResource<DiagnosticsPackagePropertiesFormat> {
  @doc("The name of the diagnostics package.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("diagnosticsPackageName")
  @segment("diagnosticsPackages")
  name: string;
}

@armResourceOperations
interface MobileNetworkDiagnosticsPackages {
  @doc("Gets information about the specified diagnostics package.")
  get is ArmResourceRead<MobileNetworkDiagnosticsPackage>;
  @doc("Creates or updates a diagnostics package.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkDiagnosticsPackage>;
  @doc("Deletes the specified diagnostics package.")
  delete is ArmResourceDeleteAsync<MobileNetworkDiagnosticsPackage>;
  @doc("Lists all the diagnostics packages under a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<MobileNetworkDiagnosticsPackage>;
}
