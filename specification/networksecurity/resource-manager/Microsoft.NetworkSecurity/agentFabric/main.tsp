import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./resourceNames.tsp";
import "./agentFabric.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.NetworkSecurity Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.NetworkSecurity management service" })
@versioned(Microsoft.NetworkSecurity.Versions)
namespace Microsoft.NetworkSecurity;

/** The available API versions. */
enum Versions {
  /** 2026-04-16-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_04_16_preview: "2026-04-16-preview",

  /** 2026-07-21-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_07_21_preview: "2026-07-21-preview",

  /** 2026-10-07-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_10_07_preview: "2026-10-07-preview",

  /** 2026-11-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_11_01_preview: "2026-11-01-preview",

  /** 2026-11-02-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_11_02_preview: "2026-11-02-preview",

  /** 2026-11-03-preview version */
  @previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_11_03_preview: "2026-11-03-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
