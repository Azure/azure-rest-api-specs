import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./networkfunction.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Mobile Packet Core Network Function Management API")
@armProviderNamespace("Microsoft.MobilePacketCore")
@service({
  title: "Microsoft.MobilePacketCore Network Function resource",
})
@versioned(Versions)
namespace Microsoft.MobilePacketCore;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("May 15, 2023 Preview API Version")
  v2023_05_15_preview: "2023-05-15-preview",
}
