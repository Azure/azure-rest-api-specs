import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./policy/customRules/customRule.tsp";
import "./policy/customRules/matchCondition.tsp";
import "./policy/logScrubbing.tsp";
import "./policy/managedRules.tsp";
import "./policy/managedRulesCustomization.tsp";
import "./policy/policySettings.tsp";
import "./policy/webProtection.tsp";
import "./policy/botProtection.tsp";
import "./policy/protectedEndpoint.tsp";
import "./policy/policy.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;
using OpenAPI;

@doc("APIs to manage AppSecurity resources")
@armProviderNamespace("Microsoft.AppSecurity")
@service({
  title: "Microsoft.AppSecurity",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@versioned(Versions)
namespace Microsoft.AppSecurity;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("AppSecurity versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Version 2023-02-06-preview")
  v2023_02_06_preview: "2023-02-06-preview",
}
