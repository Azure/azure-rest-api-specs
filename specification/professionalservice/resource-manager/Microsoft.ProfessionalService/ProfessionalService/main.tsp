import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./common.tsp";
import "./professionalServiceResource.tsp";
import "./subscriptionLevel.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.ProfessionalService Resource Provider - GA API */
@armProviderNamespace
@service(#{ title: "ProfessionalService" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ProfessionalService;

/** API versions */
enum Versions {
  /** 2026-05-01 GA version */
  v2026_05_01: "2026-05-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
