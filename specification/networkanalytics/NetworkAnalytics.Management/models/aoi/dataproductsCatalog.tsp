using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

@doc("The data catalog resource.")
@singleton
@added(Versions.v2023_11_15)
model DataProductsCatalog is ProxyResource<DataProductsCatalogProperties> {
  @doc("The data catalog name")
  @key("dataProductsCatalogName")
  @segment("dataProductsCatalogs")
  @path
  name: string;
}

@doc("Details for data catalog properties.")
@added(Versions.v2023_11_15)
model DataProductsCatalogProperties {
  @doc("The data catalog provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The data product publisher information.")
  @identifiers(#[])
  publishers: PublisherInformation[];
}

@doc("Details for Publisher Information.")
@added(Versions.v2023_11_15)
model PublisherInformation {
  @doc("Name of the publisher.")
  publisherName: string;

  @doc("Data product information.")
  @identifiers(#[])
  dataProducts: DataProductInformation[];
}

@added(Versions.v2023_11_15)
@doc("Data Product Information")
model DataProductInformation {
  @doc("Name of data product.")
  dataProductName: string;

  @doc("Description about data product.")
  description: string;

  @doc("Version information of data product.")
  @identifiers(#[])
  dataProductVersions: DataProductVersion[];
}

@doc("Data Product Version.")
@added(Versions.v2023_11_15)
model DataProductVersion {
  @doc("Version of data product")
  version: string;
}

@doc("Operations on data catalog resource.")
@added(Versions.v2023_11_15)
@armResourceOperations
interface DataProductsCatalogs {
  @doc("Retrieve data type resource.")
  get is ArmResourceRead<DataProductsCatalog>;

  @doc("List data catalog by resource group.")
  listByResourceGroup is ArmResourceListByParent<DataProductsCatalog>;

  @doc("List data catalog by subscription.")
  listBySubscription is ArmListBySubscription<DataProductsCatalog>;
}
