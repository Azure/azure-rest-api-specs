import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./account.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.InferenceService Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.InferenceService management service" })
@versioned(Microsoft.InferenceService.Versions)
namespace Microsoft.InferenceService;

/** The available API versions. */
enum Versions {
  /** 2026-01-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_15_preview: "2026-01-15-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
