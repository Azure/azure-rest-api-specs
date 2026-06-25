import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./scheduler.tsp";
import "./taskhub.tsp";
import "./retentionpolicy.tsp";
import "./transparentDataEncryption.tsp";
import "./client.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DurableTask" })
@versioned(Versions)
namespace Microsoft.DurableTask;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-10-01-preview")
  v2024_10_01_Preview: "2024-10-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-04-01-preview")
  v2025_04_01_Preview: "2025-04-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-11-01")
  v2025_11_01: "2025-11-01",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2026-02-01")
  v2026_02_01: "2026-02-01",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2026-05-01-preview")
  v2026_05_01_Preview: "2026-05-01-preview",
}

@doc("The status of the current operation")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}
