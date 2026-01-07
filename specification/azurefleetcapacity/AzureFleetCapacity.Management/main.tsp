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

/** Microsoft.AzureFleetCapacity Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AzureFleetCapacity management service" })
@versioned(Microsoft.AzureFleetCapacity.Versions)
namespace Microsoft.AzureFleetCapacity;

/** The available API versions. */
enum Versions {
  /** 2025-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}
