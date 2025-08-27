import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./fleet.tsp";
import "./baseVirtualMachineProfile.tsp";
import "./virtualMachineScaleSet.tsp";
import "./virtualMachine.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureFleet")
@service(#{ title: "Microsoft.AzureFleet" })
@versioned(Versions)
namespace Microsoft.AzureFleet;

/** Api versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("Private Preview Api version")
  v2023_11_01_preview: "2023-11-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("Public Preview Api version")
  v2024_05_01_preview: "2024-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("Public Api version")
  v2024_11_01: "2024-11-01",

  /** Private preview Api version. */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_07_01_preview: "2025-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
