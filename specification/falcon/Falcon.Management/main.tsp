import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespace.tsp";
import "./fleetNamespace.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Falcon Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Falcon management service" })
@versioned(Versions)
namespace Microsoft.Falcon;

/** The available API versions. */
enum Versions {
  /** 2024-10-14-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_14_preview: "2024-10-14-preview",

  /** 2025-03-26-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_03_26_preview: "2025-03-26-preview",

  /** 2025-05-14-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_14_preview: "2025-05-14-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
