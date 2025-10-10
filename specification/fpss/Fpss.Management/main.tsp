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

/** Microsoft.Fpss Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Fpss management service" })
@versioned(Microsoft.Fpss.Versions)
namespace Microsoft.Fpss;

/** The available API versions. */
enum Versions {
  /** 2025-09-29-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_09_29_preview: "2025-09-29-preview",
}
