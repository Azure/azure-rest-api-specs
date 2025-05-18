import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("List of storage types support by catalog")
union CatalogStorageType {
  string,

  @doc("Blob Storage Catalog Type")
  BlobCatalog: "BlobCatalog",
}

@doc("Blob Catalog type.")
model BlobCatalog {
  @doc("Catalog's storage type.")
  catalogStorageType?: CatalogStorageType;

  @doc("Catalog Storage's URI.")
  uri?: string;
}

@doc("Catalog Types.")
union Catalog {
  string,

  @doc("Blob Catalog")
  blob: BlobCatalog,
}

@doc("Package Properties")
model Package {
  @doc("Package Id.")
  id?: string;

  @doc("Package Name.")
  name?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This resource type is deprecated"
  @doc("Package metadata.")
  metadata?: Record<string>;
}

@doc("Catalog properties")
model CatalogProperties {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Owning Resource of the Catalog.")
  ownedBy?: string;

  @doc("Community Resource Id.")
  communityResourceId?: string;

  @doc("Virtual Enclave Resource Id.")
  enclaveResourceId?: string;

  @doc("Catalog Connection properties.")
  catalog?: Catalog;

  @doc("List of packages for catalog.")
  packageCollection?: Package[];
}

@doc("Catalog Patch Resource")
model CatalogPatchModel {
  @doc("Catalog Patch properties")
  properties?: Update<CatalogProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
