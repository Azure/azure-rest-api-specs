import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.OrionDB")
namespace Microsoft.OrionDB;

/**
 * The available API versions.
 */
enum ApiVersions {
  @doc("The 2025-08-01-preview API version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2, Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_08_01_preview: "2025-08-01-preview",
}
