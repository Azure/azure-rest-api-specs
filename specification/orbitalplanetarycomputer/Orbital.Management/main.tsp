import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "partial service -- no operations needed"
@armProviderNamespace("Microsoft.Orbital")
@service({
  title: "Microsoft.Orbital.AOPC",
  version: "2024-01-31-preview",
})
@doc("AOPC Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Spatio;

// Operations API is explicitly excluded since this specification
// represents a partial service that will be deployed under an ARM
// partial manifest.
// interface Operations extends Azure.ResourceManager.Operations {}

@doc("A AOPC catalog resource")
model GeoCatalog is TrackedResource<GeoCatalogProperties> {
  @doc("The name of the catalog")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("catalogName")
  @path
  @segment("geoCatalogs")
  name: string;
}

@doc("The Azure Orbital Planetary Computer GeoCatalog tier")
enum CatalogTier {
  @doc("The basic tier that utilizes shared resources across catalog instances")
  Basic,
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The catalog is being provisioned.")
  Provisioning,

  @doc("The catalog is being updated.")
  Updating,

  @doc("The catalog is being deleted.")
  Deleting,

  @doc("The catalog request has been accepted.")
  Accepted,
}

@doc("Details of the AOPC GeoCatalog.")
model GeoCatalogProperties {
  @doc("Tier of the catalog. This cannot be changed after the catalog is created.")
  tier?: CatalogTier;

  @visibility("read")
  @doc("The URI of the catalog management UI.")
  catalogUri?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(GeoCatalog)
interface GeoCatalogs {
  get is ArmResourceRead<GeoCatalog>;
  create is ArmResourceCreateOrUpdateAsync<GeoCatalog>;
  update is ArmResourcePatchSync<GeoCatalog, GeoCatalogProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<GeoCatalog>;
  listByResourceGroup is ArmResourceListByParent<GeoCatalog>;
  listBySubscription is ArmListBySubscription<GeoCatalog>;
}
