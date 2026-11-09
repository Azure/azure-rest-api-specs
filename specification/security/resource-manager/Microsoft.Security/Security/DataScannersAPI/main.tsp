import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataScanner.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;
/**
 * API spec for Microsoft.Security (Azure Security Center) data scanners resource provider.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations are defined in a separate operations.json spec for Microsoft.Security."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Microsoft.Security TypeSpec projects use PascalCase namespaces with an uppercase 'API' suffix as a service-wide convention. Changing this project's namespace alone would break naming consistency across the Microsoft.Security resource provider."
@armProviderNamespace("Microsoft.Security")
@service(#{ title: "Security Center" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace DataScannersAPI;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-08-01 stable API version.
   */
  v2026_08_01: "2026-08-01",
}
