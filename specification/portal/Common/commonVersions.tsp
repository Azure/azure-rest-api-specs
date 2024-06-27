import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.Portal;

/**
 * The available API versions.
 */
enum Versions {
    /**
     * The 2022-12-01-preview API version.
     */
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2022_12_01_preview: "2022-12-01-preview",
  }