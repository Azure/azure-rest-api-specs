import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CloudInventory.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * API spec for Microsoft.Security (Microsoft Defender for Cloud) CloudInventory RP Lite resource type.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations endpoint is defined at the Microsoft.Security provider level."
@armProviderNamespace("Microsoft.Security")
@service(#{ title: "Microsoft Defender for Cloud" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace CloudInventoryApi;

/**
 * The available API versions for Microsoft.Security/cloudInventory.
 */
enum Versions {
  /**
   * The 2024-01-01 API version (matches DSagArgPublisher ArgApiVersion).
   */
  v2024_01_01: "2024-01-01",
}
