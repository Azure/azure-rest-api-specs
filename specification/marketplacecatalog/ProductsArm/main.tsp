import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./product.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Marketplace Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Marketplace management service" })
@versioned(Versions)
namespace Microsoft.Marketplace;

/** The available API versions. */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01: "2025-05-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
