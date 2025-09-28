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

/** Microsoft.CapacityRestrictionPolicy Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.CapacityRestrictionPolicy management service" })
@versioned(Microsoft.CapacityRestrictionPolicy.Versions)
namespace Microsoft.CapacityRestrictionPolicy;

/** The available API versions. */
enum Versions {
  /** 2025-01-23-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2025-01-23-preview",
}
