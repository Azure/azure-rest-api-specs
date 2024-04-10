import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/DiagnosticsPackagModels.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Diagnostics package resource.")
@resource("diagnosticsPackages")
@parentResource(PacketCoreControlPlane)
model DiagnosticsPackage is ProxyResource<DiagnosticsPackagePropertiesFormat> {
  @doc("The name of the diagnostics package.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("diagnosticsPackageName")
  @segment("diagnosticsPackages")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface DiagnosticsPackages {
  @doc("Gets information about the specified diagnostics package.")
  get is ArmResourceRead<DiagnosticsPackage>;

  @doc("Creates or updates a diagnostics package.")
  createOrUpdate is ArmResourceCreateOrUpdateAsyncWithNoBody<DiagnosticsPackage>;

  @doc("Deletes the specified diagnostics package.")
  delete is ArmResourceDeleteWithoutOkAsync<DiagnosticsPackage>;

  @doc("Lists all the diagnostics packages under a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<DiagnosticsPackage>;
}
