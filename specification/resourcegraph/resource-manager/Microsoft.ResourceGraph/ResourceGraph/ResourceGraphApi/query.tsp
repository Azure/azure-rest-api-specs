import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../common/main.tsp";
import "./models.tsp";
import "./back-compatible.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Azure Resource Graph API Reference
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This query-only module is packaged with OnboardingApi, which owns the single provider-wide Operations endpoint. The original standalone main.tsp still declares its 2024-04-01 Operations endpoint."
@armProviderNamespace("Microsoft.ResourceGraph")
@service(#{ title: "Azure Resource Graph" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace ResourceGraphApi;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-04-01 API version.
   */
  v2024_04_01: "2024-04-01",
}
