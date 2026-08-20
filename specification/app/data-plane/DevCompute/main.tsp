import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./client.tsp";

using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

/** API for managing sandboxes, disk images, and related resources */
@service(#{ title: "ADC API" })
@server(
  "{endpoint}",
  "The Azure Dev Compute service endpoint.",
  {
    endpoint: url,
  }
)
@useAuth(AadOauth2Auth<["https://management.azuredevcompute.io/.default"]>)
@versioned(Versions)
@tagMetadata(#[
  #{ name: "DataPlaneConnectionAzure" },
  #{ name: "DataPlaneContentPackageAzure" },
  #{ name: "DataPlaneDiskImageAzure" },
  #{ name: "DataPlaneNamedEgressPolicyAzure" },
  #{ name: "DataPlaneSandboxAzure" },
  #{ name: "DataPlaneSandboxAzureFile" },
  #{ name: "DataPlaneSandboxAzureStream" },
  #{ name: "DataPlaneSandboxGroupCredentialAzure" },
  #{ name: "DataPlaneSecretAzure" },
  #{ name: "DataPlaneSnapshotAzure" },
  #{ name: "DataPlaneVolumeAzure" },
  #{ name: "DataPlaneVolumeAzureFile" }
])
namespace Azure.DevCompute;

/** The Azure Dev Compute service API versions. */
enum Versions {
  /** The 2026-08-01-preview API version. */
  #suppress "@azure-tools/typespec-azure-core/preview-version-last-member" "The preview contract predates the stable contract and contains members removed by the stable release."
  @Azure.Core.previewVersion
  v2026_08_01_preview: "2026-08-01-preview",

  /** The 2026-09-01 API version. */
  v2026_09_01: "2026-09-01",
}
