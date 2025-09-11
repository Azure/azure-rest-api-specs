import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./OnlineExperimentationWorkspace.tsp";
import "./PrivateEndpointConnection.tsp";
import "./PrivateLinkResource.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Microsoft.OnlineExperimentation Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.OnlineExperimentation management service" })
@versioned(Microsoft.OnlineExperimentation.Versions)
namespace Microsoft.OnlineExperimentation;

/** The available API versions. */
enum Versions {
  /** 2025-05-31-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_31_preview: "2025-05-31-preview",

  /** 2025-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
