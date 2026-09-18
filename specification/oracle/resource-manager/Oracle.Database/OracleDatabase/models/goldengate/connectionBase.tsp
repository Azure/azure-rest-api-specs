import "../common.tsp";
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260301_preview)
@doc("Allowed network traffic routing method.")
union RoutingMethod {
  @doc("Indicates that traffic flows through the GoldenGate service network to public hosts.")
  SharedServiceEndpoint: "SHARED_SERVICE_ENDPOINT",

  @doc("Indicates that traffic flows from the assigned deployment's private endpoint through the deployment's subnet.")
  SharedDeploymentEndpoint: "SHARED_DEPLOYMENT_ENDPOINT",

  @doc("Indicates that a dedicated private endpoint is created in the target VCN subnet for the connection.")
  DedicatedEndpoint: "DEDICATED_ENDPOINT",

  string,
}

@added(Versions.v20260301_preview)
@doc("Possible lifecycle states for connection.")
union ConnectionLifecycleState {
  @doc("Indicates that the resource is in creating state.")
  Creating: "CREATING",

  @doc("Indicates that the resource is in updating state.")
  Updating: "UPDATING",

  @doc("Indicates that the resource is in active state.")
  Active: "ACTIVE",

  @doc("Indicates that the resource is in deleting state.")
  Deleting: "DELETING",

  @doc("Indicates that the resource is in deleted state.")
  Deleted: "DELETED",

  @doc("Indicates that the resource is in failed state.")
  Failed: "FAILED",

  string,
}

@added(Versions.v20260301_preview)
@doc("Known values for connection type.")
union ConnectionType {
  @doc("A GoldenGate Connection")
  GoldenGate: "GOLDENGATE",

  @doc("A Kafka Connection")
  Kafka: "KAFKA",

  @doc("A Kafka (e.g. Confluent) Schema Registry Connection")
  KafkaSchemaRegistry: "KAFKA_SCHEMA_REGISTRY",

  @doc("A MySQL Connection")
  MySQL: "MYSQL",

  @doc("A Java Message Service Connection")
  JavaMessageService: "JAVA_MESSAGE_SERVICE",

  @doc("A Microsoft SQL Server Connection")
  MicrosoftSqlServer: "MICROSOFT_SQLSERVER",

  @doc("An OCI Object Storage Connection")
  OciObjectStorage: "OCI_OBJECT_STORAGE",

  @doc("An Oracle Database Connection")
  Oracle: "ORACLE",

  @doc("An Azure Data Lake Storage Connection")
  AzureDataLakeStorage: "AZURE_DATA_LAKE_STORAGE",

  @doc("A PostgreSQL Database Connection")
  PostgreSql: "POSTGRESQL",

  @doc("An Azure Synapse Analytics Connection")
  AzureSynapseAnalytics: "AZURE_SYNAPSE_ANALYTICS",

  @doc("A Snowflake Connection")
  Snowflake: "SNOWFLAKE",

  @doc("An Amazon S3 Connection")
  AmazonS3: "AMAZON_S3",

  @doc("A Hadoop Distributed File System Connection")
  Hdfs: "HDFS",

  @doc("An Oracle NoSQL Connection")
  OracleNoSQL: "ORACLE_NOSQL",

  @doc("A MongoDB Connection")
  MongoDbConnection: "MONGODB",

  @doc("An Amazon Kinesis Connection")
  AmazonKinesis: "AMAZON_KINESIS",

  @doc("An Amazon Redshift Connection")
  AmazonRedshift: "AMAZON_REDSHIFT",

  @doc("A DB2 Connection")
  Db2Connection: "DB2",

  @doc("A Redis Database Connection")
  Redis: "REDIS",

  @doc("An Elasticsearch Connection")
  Elasticsearch: "ELASTICSEARCH",

  @doc("A Generic Connection")
  Generic: "GENERIC",

  @doc("A Google Cloud Storage Connection")
  GoogleCloudStorage: "GOOGLE_CLOUD_STORAGE",

  @doc("A Google BigQuery Connection")
  GoogleBigQuery: "GOOGLE_BIGQUERY",

  @doc("A Databricks Connection")
  Databricks: "DATABRICKS",

  @doc("A Google PubSub Connection")
  GooglePubSub: "GOOGLE_PUBSUB",

  @doc("A Microsoft Fabric Connection")
  MicrosoftFabric: "MICROSOFT_FABRIC",

  @doc("An Iceberg Connection")
  Iceberg: "ICEBERG",

  string,
}

@added(Versions.v20260301_preview)
@discriminator("connectionType")
@doc("GoldenGate Connection base resource model.")
model ConnectionBaseProperties {
  @doc("The connection type to be created.")
  connectionType: ConnectionType;

  @doc("The connection display name.")
  @minLength(1)
  @maxLength(255)
  displayName: string;

  @doc("The corresponding resource anchor Azure ID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: ResourceAnchorResourceId;

  @doc("The corresponding network anchor Azure ID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkAnchorId: NetworkAnchorResourceId;

  @doc("The OCID of the compartment being referenced.")
  @visibility(Lifecycle.Read)
  compartmentId?: Ocid;

  @doc("The OCID of the connection being referenced.")
  @visibility(Lifecycle.Read)
  ocid?: Ocid;

  @doc("Controls the network traffic direction to the target.")
  routingMethod?: RoutingMethod;

  @doc("The customer's vault OCID.")
  vaultId?: Ocid;

  @doc("The customer's master key OCID.")
  keyId?: Ocid;

  @doc("Indicates whether secret OCIDs are used for credential fields.")
  doesUseSecretIds?: boolean;

  @doc("Connection provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("The connection lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleState?: ConnectionLifecycleState;

  @doc("The description of lifecycle state in detail.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("The date time the resource was created in OCI.")
  @visibility(Lifecycle.Read)
  timeCreated?: string;

  @doc("The date time the resource was last updated in OCI.")
  @visibility(Lifecycle.Read)
  timeUpdated?: string;
}
