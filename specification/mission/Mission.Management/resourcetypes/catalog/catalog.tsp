import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("List of storage types support by catalog")
enum CatalogStorageType {
  @doc("Blob Storage Catalog Type")
  BlobCatalog,

  @doc("Git Storage Catalog Type")
  GitCatalog,
}

@doc("Catalog Connection properties.")
model CatalogConnectionParams {
  @doc("Catalog Storage's URI.")
  uri?: string;
}

@doc("Catalog Core properties.")
model CatalogCore {
  @doc("Catalog's storage type.")
  type?: CatalogStorageType;

  @doc("Catalog Connection properties.")
  catalogConnectionParams?: CatalogConnectionParams;
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

  @doc("Catalog Core.")
  catalogCore?: CatalogCore;
}
