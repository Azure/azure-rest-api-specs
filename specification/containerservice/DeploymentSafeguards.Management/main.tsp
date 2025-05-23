import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./deploymentsafeguards.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

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
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_04_02_preview: "2025-04-02-preview",

  /** 2025-04-01 version */
  @doc("Deployment Safeguards api version 2025-04-01")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_04_01: "2025-04-01",
}
