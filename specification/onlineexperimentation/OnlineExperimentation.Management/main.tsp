import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./OnlineExperimentWorkspace.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.OnlineExperimentation Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.OnlineExperimentation management service" })
@versioned(Microsoft.OnlineExperimentation.Versions)
namespace Microsoft.OnlineExperimentation;

/** The available API versions. */
enum Versions {
  /** 2025-05-31-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_31_preview: "2025-05-31-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
