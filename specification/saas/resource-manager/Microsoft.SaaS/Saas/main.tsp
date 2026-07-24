import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./common.tsp";
import "./saasResource.tsp";
import "./subscriptionLevel.tsp";
import "./tenantLevel.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.SaaS Resource Provider - GA API */
@armProviderNamespace
@service(#{ title: "SaaS" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.SaaS;

/** API versions */
enum Versions {
  /** 2026-04-01 GA version */
  v2026_04_01: "2026-04-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
