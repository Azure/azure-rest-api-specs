import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./deploymentsafeguards.tsp";
import "./back-compatible.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "ContainerServiceDeploymentSafeguardsClient" })
@doc("Azure Kubernetes Service Deployment Safeguards API Client.")
@versioned(Versions)
namespace Microsoft.ContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
@doc("Azure Kubernetes Service Deployment Safeguards api versions.")
enum Versions {
  /** 2025-04-02-preview version */
  @doc("Deployment Safeguards api version 2025-04-02-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_04_02_preview: "2025-04-02-preview",

  /** 2025-04-01 version */
  @doc("Deployment Safeguards api version 2025-04-01")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_04_01: "2025-04-01",

  /** 2025-05-02-preview version */
  @doc("Deployment Safeguards api version 2025-05-02-preview")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_05_02_preview: "2025-05-02-preview",

  /** 2025-07-01 version */
  @doc("Deployment Safeguards api version 2025-07-01")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01: "2025-07-01",
}
