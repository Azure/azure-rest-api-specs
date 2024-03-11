using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.NetworkAnalytics;

@doc("The data connector resource")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectors is TrackedResource<DataConnectorsProperties> {
  @doc("The data connector name")
  @key("dataConnectorName")
  @segment("dataConnectors")
  @path
  name: string;
}

@doc("Details of the Data Connector Properties. The product details are to be added from the supported values which can be fetched by making a GET call on the Network Analytics Product resource.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectorsProperties {
  @doc("The data connector provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The network analytics product to which this connector belongs to")
  @visibility("create", "read")
  productName: string;

  @doc("The version of the corresponding product")
  @visibility("create", "read")
  productVersion: string;

  @doc("The product connector")
  @visibility("create", "read")
  productConnector: string;

  @doc("The product connector dataset")
  @visibility("create", "read")
  productConnectorDataset: string;

  @doc("An array of the ARM IDs for the Data Lake House resources")
  @visibility("create", "read")
  dataLakeHouses: string[];

  @doc("The data ingestion path")
  @visibility("read")
  dataIngestionPath?: string;

  @doc("The data connector configuration")
  @visibility("create", "read")
  dataConnectorConfiguration: DataConnectorConfiguration;
}

@doc("The data retention, dataset and compute configurations for the connector")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataConnectorConfiguration {
  @doc("The data retention configuration")
  dataRetentionProperties?: DataRetentionProperties;

  @doc("The datasets configuration array ")
  dataset?: DatasetConfiguration;

  @doc("The compute configuration")
  compute: ComputeConfiguration;
}

@doc("The data retention properties")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DataRetentionProperties {
  @doc("The Azure data explorer retention properties")
  dataExplorer?: RetentionProperties;

  @doc("The bronze storage account retention properties")
  bronzeStorageAccount?: RetentionProperties;

  @doc("The silver storage account retention properties")
  silverStorageAccount?: RetentionProperties;

  @doc("The gold storage account retention properties")
  goldStorageAccount?: RetentionProperties;
}

@doc("The retention properties model")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model RetentionProperties {
  @doc("The data retention period in days")
  retentionDays: int32;
}

@doc("The connector dataset information ")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model DatasetConfiguration {
  @doc("The name of the dataset")
  datasetName?: string;

  @doc("The column key holding the timestamp data")
  timestampKey?: utcDateTime;

  @doc("Columns to be masked")
  columnsToMask?: string[];
}

@doc("The compute configuration")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model ComputeConfiguration {
  @doc("The data connector throughput configuration.")
  throughput: Throughput;
}

@doc("The data connector throughput configuration")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
model Throughput {
  @doc("The data connector throughput tier.")
  tier: throughputTier;
}

@doc("The data connector throughput tier for the ADX cluster.")
@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
enum throughputTier {
  @doc("The Basic throughput tier.")
  Basic,

  @doc("The Standard throughput tier.")
  Standard,

  @doc("The Premium throughput tier.")
  Premium,
}

@added(Versions.v2023_03_31_preview)
@removed(Versions.v2023_11_15)
@armResourceOperations(DataConnectors)
interface DataConnector
  extends TrackedResourceOperations<DataConnectors, DataConnectorsProperties> {}
