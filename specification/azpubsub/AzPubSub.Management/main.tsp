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

/** Microsoft.AzPubSub Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AzPubSub management service" })
@versioned(Microsoft.AzPubSub.Versions)
namespace Microsoft.AzPubSub;

/** The available API versions. */
enum Versions {
  /** 2025-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_10_01_preview: "2025-10-01-preview",
}
