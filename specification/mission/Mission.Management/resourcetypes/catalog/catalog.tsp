import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("List of storage types support by catalog")
union CatalogStorageType {
  @doc("Blob Storage Catalog Type")
  BlobCatalog: "BlobCatalog",

  string,
}

@doc("Base type for catalog.")
model CatalogBase {
  @doc("Catalog's storage type.")
  catalogStorageType?: CatalogStorageType;
}

@doc("Blob Catalog type.")
model BlobCatalog is CatalogBase {
  @doc("Catalog Storage's URI.")
  uri?: string;
}

@doc("Catalog Types.")
union Catalog {
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
  @visibility("read")
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
