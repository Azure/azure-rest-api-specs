import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./KubernetesResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * APIs for K8s inventory reports under Microsoft.KubernetesConfiguration.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "KubernetesResources is a proxy resource provider under Microsoft.Kubernetes; no independent operations endpoint is registered."
@armProviderNamespace
@service(#{ title: "KubernetesResourcesClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.KubernetesConfiguration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-07-01-preview API version.
   */
  @Azure.Core.previewVersion
  v2026_07_01_preview: "2026-07-01-preview",
}
