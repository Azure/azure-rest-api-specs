import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extensionmanager.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.HybridOnboarding Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.HybridOnboarding management service",
})
@versioned(Microsoft.HybridOnboarding.Versions)
namespace Microsoft.HybridOnboarding;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}
