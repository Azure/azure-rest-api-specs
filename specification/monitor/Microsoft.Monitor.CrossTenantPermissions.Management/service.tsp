import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API was moved to its own service."
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Cross Tenant Permissions API" })
@versioned(Versions)
namespace Microsoft.Monitor;

enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("API Version 2025-06-03-preview")
  v2025_06_03_preview: "2025-06-03-preview",
}
