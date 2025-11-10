import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./updaterules.tsp";
import "./InventoryConfiguration.tsp";
import "./InventoryConfigurationAssignments.tsp";
import "./SoftwareCollection.tsp";
import "./SoftwareManifest.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.UpdateManager Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.UpdateManager service" })
@versioned(Microsoft.UpdateManager.Versions)
namespace Microsoft.UpdateManager;

/** The available API versions. */
enum Versions {
  /** 2024-11-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_11_01_preview: "2024-11-01-preview",

  /** 2024-12-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",

  /** 2025-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_06_01_preview: "2025-06-01-preview",

  /** 2025-08-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_01_preview: "2025-08-01-preview",
}

@lroStatus
@doc("The provisioning state.")
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

interface Operations extends Azure.ResourceManager.Operations {}
