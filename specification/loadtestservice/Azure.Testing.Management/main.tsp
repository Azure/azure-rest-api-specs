import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";
import "../Azure.Testing.Shared";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.LoadTestService")
@service(#{ title: "Azure Testing service Management API" })
@doc("Azure Testing service provides access to Testing workspace resource and it's operations.")
@versioned(Versions)
namespace Azure.Testing.Management;

@doc("Azure Testing service Management API Versions.")
enum Versions {
  /** 2025-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Testing.Shared.Versions.v1_0)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",
}
