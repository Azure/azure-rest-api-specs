import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SaaSHub;

/**
 * The available API versions.
 */
enum SaaSHubVersions {
  /**
   * The 2025-07-01-preview API version.
   */
  v2025_07_01_preview: "2025-07-01-preview",
}
