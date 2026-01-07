import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Copilots.tsp";
import "./back-compatible.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.PortalServices" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Azure Portal Services API Reference")
namespace Microsoft.PortalServices;

@doc("Azure Portal Services Copilots Management API versions.")
enum Versions {
  @doc("Azure Portal Services Copilots Management API version 2025-10-01-preview.")
  v2025_10_01_preview: "2025-10-01-preview",
}
