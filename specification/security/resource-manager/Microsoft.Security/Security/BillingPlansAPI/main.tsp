import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingPlan.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
 * API specification for Microsoft Defender for Cloud billing plans.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The provider-wide Microsoft.Security operations endpoint is defined by the separate OperationsAPI TypeSpec project."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Microsoft.Security TypeSpec projects use PascalCase namespaces with an uppercase 'API' suffix as a service-wide convention."
@armProviderNamespace("Microsoft.Security")
@service(#{ title: "Microsoft Defender for Cloud" })
@versioned(Versions)
namespace BillingPlansAPI;

/** The available API versions. */
enum Versions {
  /** The 2026-09-01-preview API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @previewVersion
  v2026_09_01_preview: "2026-09-01-preview",
}
