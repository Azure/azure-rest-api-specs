import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./cloud.tsp";
import "./geography.tsp";
import "./region.tsp";
import "./availabilityzone.tsp";
import "./datacenter.tsp";
import "./cluster.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AzureCloudMetadata Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AzureCloudMetadata management service" })
@versioned(Microsoft.AzureCloudMetadata.Versions)
namespace Microsoft.AzureCloudMetadata;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2024-05-01-preview",

  /** 2025-10-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_01_preview: "2025-10-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
