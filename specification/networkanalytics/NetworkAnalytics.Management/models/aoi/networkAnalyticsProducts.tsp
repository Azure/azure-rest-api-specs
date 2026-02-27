using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "Suppressing updateable property warning for network analytics products for now"
@doc("The network analytics product resource")
@singleton
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProducts
  is ProxyResource<NetworkAnalyticsProductsProperties> {
  @doc("The network analytics product name")
  @key("networkAnalyticsProductName")
  @segment("networkAnalyticsProducts")
  @path
  name: string;
}

@doc("Details of the network analytics product properties")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductsProperties {
  @doc("The network analytics product provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The network analytics product information")
  @identifiers(#["productName"])
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkAnalyticsProductInformation: NetworkAnalyticsProductInformation[];
}

@doc("The network analytics product information")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductInformation {
  @doc("Name of the network analytics product")
  @minLength(3)
  @maxLength(63)
  productName: string;

  @doc("The available versions for the product")
  productVersions: string[];

  @doc("The connectors supported by the product")
  @identifiers(#["connectorName"])
  productConnectors: NetworkAnalyticsProductConnectorInformation[];
}

@doc("Data Connector Information")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model NetworkAnalyticsProductConnectorInformation {
  @doc("The connector name")
  @minLength(3)
  @maxLength(63)
  connectorName: string;

  @doc("The datasets supported by the connector")
  datasets: string[];
}

@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
@armResourceOperations(NetworkAnalyticsProducts)
interface NetworkAnalyticsProduct
  extends TrackedResourceOperations<
      NetworkAnalyticsProducts,
      NetworkAnalyticsProductsProperties
    > {}
