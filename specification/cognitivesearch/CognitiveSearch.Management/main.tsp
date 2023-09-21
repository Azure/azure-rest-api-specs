import "./index.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("CognitiveSearch Indexer Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.CognitiveSearch;

@parentResource(Index)
@doc("An indexer resource is a child tracked resource of index")
model Indexer is TrackedResource<IndexerProperties> {
  @path
  @key("indexerName")
  @segment("indexers")
  @visibility("read")
  @doc("The name of the indexer resource.")
  name: string;
}

@armResourceOperations
interface IndexerOperations {
  get is ArmResourceRead<Indexer>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Indexer>;
  update is ArmResourcePatchAsync<Indexer, IndexerProperties>;
  delete is ArmResourceDeleteAsync<Indexer>;
}

@doc("The properties of the indexer.")
model IndexerProperties {
  @doc("The description of the indexer resource.")
  description?: string;

  @visibility("read")
  @doc("The current provisioning state of the indexer.")
  provisioningState?: ProvisioningState;

  @doc("The failure policy.")
  failurePolicy: FailurePolicy;

  @doc("Connection and container information for DataSource")
  dataSource: DataSource;
}

@doc("datasource object")
model DataSource {
  @doc("Data source Connection definition")
  connection: Connection;

  @doc("other datasource Properties")
  properties: DataSourceProperties;
}

@discriminator("authenticationType")
@doc("Parent connection")
model Connection {}

@doc("Credentials definition")
model Credentials extends Connection {
  @doc("Connection type")
  authenticationType: "Credentials";

  @doc("Connection string")
  @secret
  connectionString: string;
}

@discriminator("kind")
@doc("Datasource properties types")
model DataSourceProperties {}

@doc("CosmosDb/NoSql Datasource")
model CosmosDbNoSql extends DataSourceProperties {
  @doc("CosmosDb datasource type")
  kind: "CosmosDb/NoSql";

  @doc("CosmosDB/NoSql Database name")
  collectionName: string;

  @doc("Query information")
  query: string;
}

@doc("Sql/AzureSql Datasource")
model AzureSql extends DataSourceProperties {
  @doc("Sql/AzureSql datasource type")
  kind: "Sql/AzureSql";

  @doc("Sql/AzureSql Database name")
  tableOrViewName: string;
}

@doc("Storage Blob Datasource")
model AzureStorageBlob extends DataSourceProperties {
  @doc("AzureStorage Blob datasource type")
  kind: "Storage/AzureBlob";

  @doc("Azure Blob container name")
  containerName: string;

  @doc("Query information")
  query: string;
}

@doc("AzureStorage Table Datasource")
model AzureStorageTable extends DataSourceProperties {
  @doc("AzureStorage Table datasource type")
  kind: "Storage/AzureTable";

  @doc("Azure Table container name")
  containerName: string;

  @doc("Query information")
  query: string;
}

@doc("Failure policy parent")
model FailurePolicy {
  @doc("Failure policy type")
  type: FailurePolicyType;
}

@doc("Supported Failure policy")
enum FailurePolicyType {
  @doc("Indexer will stop after the first failure.")
  FailOnFirstFailure,

  @doc("Indexer will not stop for the specified number of failures")
  TolerateFailures,
}
