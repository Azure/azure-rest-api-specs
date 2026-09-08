import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ServiceEntitlement.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
 * API specification for Microsoft Defender for Cloud service entitlements.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The provider-wide Microsoft.Security operations endpoint is defined by the separate OperationsAPI TypeSpec project."
@armProviderNamespace("Microsoft.Security")
@service(#{ title: "Microsoft Defender for Cloud" })
@versioned(Versions)
namespace ServiceEntitlementsApi;

/** The available API versions. */
enum Versions {
  /** The 2026-09-01-preview API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @previewVersion
  v2026_09_01_preview: "2026-09-01-preview",
}
