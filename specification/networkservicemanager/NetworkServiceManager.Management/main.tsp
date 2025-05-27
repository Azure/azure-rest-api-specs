import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";
import "./resources/publicipaddress.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.NetworkServiceManager Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.NetworkServiceManager management service" })
@versioned(Microsoft.NetworkServiceManager.Versions)
namespace Microsoft.NetworkServiceManager;

/** The available API versions. */
enum Versions {
  /** 2025-04-02-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_02_preview: "2025-04-02-preview",

  /** 2025-05-21-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Microsoft.Inventory.CommonTypes.Versions.v2024_01_01)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_21_preview: "2025-05-21-preview",
}
