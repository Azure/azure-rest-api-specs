import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./inferenceAccount.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.InferenceService Resource Provider.
 *  Provides managed inference accounts used to run inference and
 *  retrieval-augmented-generation (RAG) workloads in Azure.
 */
@armProviderNamespace
@service(#{ title: "Azure Inference Service" })
@versioned(Microsoft.InferenceService.Versions)
namespace Microsoft.InferenceService;

/** The available API versions. */
enum Versions {
  /** 2026-01-15-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_15_preview: "2026-01-15-preview",

  /** 2026-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  v2026_08_01_preview: "2026-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
