import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
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
}

interface Operations extends Azure.ResourceManager.Operations {}
