import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.CloudDevicePlatform Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.CloudDevicePlatform management service",
})
@versioned(Microsoft.CloudDevicePlatform.Versions)
namespace Microsoft.CloudDevicePlatform;

/** The available API version(s). */
enum Versions {
  /** 2024-05-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",
}
