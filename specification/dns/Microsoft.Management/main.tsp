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

/** Microsoft.DnsInternal Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.DnsInternal management service" })
@versioned(Microsoft.DnsInternal.Versions)
namespace Microsoft.DnsInternal;

/** The available API versions. */
enum Versions {
  /** 2025-11-20-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_11_20_preview: "2025-11-20-preview",
}
