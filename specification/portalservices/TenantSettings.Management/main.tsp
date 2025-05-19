import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./TenantSettings.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

@armProviderNamespace
@service(#{ title: "Microsoft.PortalServices" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Azure Portal Services API Reference")
namespace Microsoft.PortalServices;

@doc("Azure Portal Services tenant settings management API versions.")
enum Versions {
  @doc("Azure Portal Services tenant settings management API version 2024-09-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_09_01_preview: "2024-09-01-preview",

  @doc("Azure Portal Services tenant settings management API version 2025-04-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2025_04_01_preview: "2025-04-01-preview",
}
