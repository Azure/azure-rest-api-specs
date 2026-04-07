import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./namespace.tsp";
import "./environment.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Versioning;

@doc("Microsoft.Cosmic Resource Provider Management API.")
@armProviderNamespace
@service(#{ title: "Microsoft.Cosmic Management Service" })
@versioned(global.Microsoft.Cosmic.Versions)
namespace Microsoft.Cosmic;

@doc("The available API versions.")
enum Versions {
  @doc("2026-03-01-preview version")
  @previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_01_preview: "2026-03-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
