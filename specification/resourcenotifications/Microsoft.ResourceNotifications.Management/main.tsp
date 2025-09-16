/**
 * Resource Notifications API
 * Generated for Microsoft.ResourceNotifications resource provider
 */
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Microsoft Resource Notifications Resource Provider REST API.
 */
@armProviderNamespace
@service(#{
  title: "Microsoft Resource Notifications Resource Provider REST API.",
})
@versioned(Versions)
namespace Microsoft.ResourceNotifications;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-12-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
