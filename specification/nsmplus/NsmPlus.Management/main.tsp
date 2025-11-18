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

/** Microsoft.NsmPlus Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.NsmPlus management service" })
@versioned(Microsoft.NsmPlus.Versions)
namespace Microsoft.NsmPlus;

/** The available API versions. */
enum Versions {
  /** 2025-04-03-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_03_preview: "2025-04-03-preview",
}
