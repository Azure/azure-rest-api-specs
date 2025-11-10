import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./onboarding.tsp";
import "./policy.tsp";
import "./devicestate.tsp";
import "./discoveryServices.tsp";
import "./ownershipVoucherPublicKeys.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DeviceOnboarding" })
@versioned(Versions)
namespace Microsoft.DeviceOnboarding;

/** Services API versions */
enum Versions {
  @doc("Microsoft.DeviceOnboarding Resource Provider management API version 2024-11-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_11_01_preview: "2024-11-01-preview",

  @doc("Microsoft.DeviceOnboarding Resource Provider management API version 2024-12-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",

  @doc("Microsoft.DeviceOnboarding Resource Provider management API version 2025-05-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01_preview: "2025-05-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T>;
