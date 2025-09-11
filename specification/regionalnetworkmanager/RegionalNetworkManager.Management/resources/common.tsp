import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Inventory.CommonTypes;

namespace Microsoft.RegionalNetworkManager;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2025-04-02-preview version */
  @useDependency(Microsoft.Inventory.CommonTypes.Versions.v2024_01_01)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_02_preview: "2025-04-02-preview",
}
