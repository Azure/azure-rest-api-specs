import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Dashboard.tsp";
import "./back-compatible.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service(#{ title: "Microsoft.PortalServices" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Azure Portal Services API Reference")
namespace Microsoft.PortalServices;

@doc("Azure Portal Services Dashboards Management API versions.")
enum Versions {
  @doc("Azure Portal Services Dashboards Management API version 2024-01-01-preview.")
  v2024_01_01_preview: "2024-01-01-preview",

  @doc("Azure Portal Services Dashboards Management API version 2024-04-01-preview.")
  v2024_04_01_preview: "2024-04-01-preview",

  @doc("Azure Portal Services Dashboards Management API version 2024-07-01-preview.")
  v2024_07_01_preview: "2024-07-01-preview",

  @doc("Azure Portal Services Dashboards Management API version 2024-08-01-preview.")
  v2024_08_01_preview: "2024-08-01-preview",

  @doc("Azure Portal Services Dashboards Management API version 2024-09-01-preview.")
  v2024_09_01_preview: "2024-09-01-preview",
}
