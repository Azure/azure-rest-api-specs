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

/** Microsoft.DefenderAgentSecurity Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.DefenderAgentSecurity management service" })
@versioned(Versions)
namespace Microsoft.DefenderAgentSecurity;

/** DefenderAgentSecurity API versions */
enum Versions {
  /** 2025-05-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_01_preview: "2025-05-01-preview",
}
