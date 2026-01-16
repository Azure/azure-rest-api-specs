import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";
import "./resources.tsp";
import "./routes.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DependencyMap management service" })
@doc("Microsoft.DependencyMap management service")
@versioned(Microsoft.DependencyMap.Versions)
@armCommonTypesVersion("v3")
namespace Microsoft.DependencyMap;

/** The available API versions. */
enum Versions {
  /** 2025-01-31-preview version */
  v2025_01_31_preview: "2025-01-31-preview",

  /** 2025-05-01-preview version */
  v2025_05_01_preview: "2025-05-01-preview",

  /** 2025-07-01-preview version */
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
