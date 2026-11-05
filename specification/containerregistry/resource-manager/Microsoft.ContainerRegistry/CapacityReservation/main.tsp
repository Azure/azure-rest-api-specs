import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./CapacityReservation.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/** Manages Azure Container Registry capacity reservations. */
@armProviderNamespace
@service(#{ title: "ContainerRegistryCapacityReservationManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ContainerRegistry;

/** The API versions supported by capacity reservations. */
enum Versions {
  /** The January 2027 preview API version. */
  @previewVersion
  vLatestPreview: "2027-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
