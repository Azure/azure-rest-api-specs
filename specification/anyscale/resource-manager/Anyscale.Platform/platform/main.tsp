import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./cloud.tsp";
import "./cloudResource.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Anyscale.Platform Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Anyscale.Platform management service" })
@versioned(Versions)
namespace Anyscale.Platform;

/** The available API versions. */
enum Versions {
  /** The 2023-04-01-preview API version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2023_04_01_preview: "2023-04-01-preview",
}

/** Operations interface */
interface Operations extends Azure.ResourceManager.Operations {}
