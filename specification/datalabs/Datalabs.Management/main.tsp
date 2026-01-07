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

/** Microsoft.Datalabs Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Datalabs management service" })
@versioned(Microsoft.Datalabs.Versions)
namespace Microsoft.Datalabs;

/** The available API versions. */
enum Versions {
  /** 2024-07-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_07_01_preview: "2024-07-01-preview",
}
