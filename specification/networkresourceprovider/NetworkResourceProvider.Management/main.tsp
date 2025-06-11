import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.NetworkResourceProvider Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.NetworkResourceProvider management service" })
@versioned(Microsoft.NetworkResourceProvider.Versions)
namespace Microsoft.NetworkResourceProvider;

/** The available API versions. */
enum Versions {
  /** 2025-06-06-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_06_preview: "2025-06-06-preview",
}
