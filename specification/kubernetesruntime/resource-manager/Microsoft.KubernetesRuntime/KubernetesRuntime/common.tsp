import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.KubernetesRuntime")
@service(#{ title: "Microsoft.KubernetesRuntime" })
@versioned(Microsoft.KubernetesRuntime.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.KubernetesRuntime;

@doc("Versions of KubernetesRuntime service")
enum Versions {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract; tracked by Azure/typespec-azure#5977."
  @doc("2023-10-01-preview")
  v2023_10_01_preview: "2023-10-01-preview",

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Retain common-types v5 for this existing API version to preserve its emitted contract; tracked by Azure/typespec-azure#5977."
  @doc("2024-03-01, added bgpPeers field in LoadBalancer")
  v2024_03_01: "2024-03-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}
