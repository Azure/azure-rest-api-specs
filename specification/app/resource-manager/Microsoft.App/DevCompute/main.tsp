import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./SandboxGroup.tsp";
import "./VnetConnection.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.App Dev Compute management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in another service under the same provider namespace."
@armProviderNamespace("Microsoft.App")
@service(#{ title: "Microsoft.App Dev Compute management service" })
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

/** The available API versions. */
enum Versions {
  /** 2026-07-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_07_01: "2026-07-01",
}
