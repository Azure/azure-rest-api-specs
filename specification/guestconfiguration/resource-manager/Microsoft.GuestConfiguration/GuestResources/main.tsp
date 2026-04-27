import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.GuestConfiguration Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "GuestConfiguration" })
@versioned(Versions)
namespace Microsoft.GuestConfiguration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-03-01 API version.
   */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_01: "2026-03-01",
}

interface Operations extends Azure.ResourceManager.Operations {}
