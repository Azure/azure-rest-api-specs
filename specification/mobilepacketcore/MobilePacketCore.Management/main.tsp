import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./amfdeployment.tsp";
import "./smfdeployment.tsp";
import "./upfdeployment.tsp";
import "./nrfdeployment.tsp";
import "./nssfdeployment.tsp";
import "./clusterservice.tsp";
import "./observabilityservice.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Mobile Packet Core Management API")
@armProviderNamespace("Microsoft.MobilePacketCore")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "Microsoft.MobilePacketCore Mobile Packet Core Service",
})
@versioned(Versions)
namespace Microsoft.MobilePacketCore;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("October 15, 2023 Preview API Version")
  v2023_10_15_preview: "2023-10-15-preview",
}
