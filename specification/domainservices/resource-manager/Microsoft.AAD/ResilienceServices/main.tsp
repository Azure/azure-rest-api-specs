import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./resilience.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AAD Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is the published name of the already existing RP. AAD is short for Azure Active Directory."
@armProviderNamespace
@service(#{ title: "Microsoft.AAD management service" })
@versioned(Microsoft.AAD.Versions)
namespace Microsoft.AAD;

/** The available API versions. */
enum Versions {
  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
