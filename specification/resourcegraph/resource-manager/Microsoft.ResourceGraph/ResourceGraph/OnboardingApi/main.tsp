import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Azure Resource Graph onboarding control plane. Partners declare an offering, the ontology
 * (demand) they need, and the query endpoints that consume it; Azure Resource Graph resolves the
 * required publisher supply (data onboardings) and rolls the result out region by region.
 */
@armProviderNamespace("Microsoft.ResourceGraph")
@service(#{ title: "Azure Resource Graph Onboarding" })
@versioned(Versions)
// The aggregate ResourceGraph client uses v5. All common types referenced by
// onboarding have the same wire schemas in v5 and v6.
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace OnboardingApi;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-05-01-preview API version.
   */
  v2026_05_01_preview: "2026-05-01-preview",
}
