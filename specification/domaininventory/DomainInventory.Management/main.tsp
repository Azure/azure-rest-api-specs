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

/** Microsoft.DomainInventory Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.DomainInventory management service" })
@versioned(Microsoft.DomainInventory.Versions)
namespace Microsoft.DomainInventory;

/** The available API versions. */
enum Versions {
  /** 2025-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_01_preview: "2025-03-01-preview",
}
