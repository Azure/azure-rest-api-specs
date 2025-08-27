import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../AccessPoint.Management.Shared/sharedResources.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AccessPoint Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AccessPoint management service" })
@versioned(Microsoft.AccessPoint.Versions)
namespace Microsoft.AccessPoint;

/** The available API versions. */
enum Versions {
  /** 2024-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",
}
