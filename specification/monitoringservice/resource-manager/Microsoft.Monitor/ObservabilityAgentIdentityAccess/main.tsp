import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./operations.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Advisory identity role inspection for Azure Monitor observability agents. */
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Observability Agent Identity Access" })
@versioned(Versions)
namespace Microsoft.Monitor;

/** Supported identity preflight API versions. */
enum Versions {
  /** The August 2026 preview API. */
  @Azure.Core.previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_08_01: "2026-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
