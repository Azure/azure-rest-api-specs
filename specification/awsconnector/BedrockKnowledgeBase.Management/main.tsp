import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.AwsConnector" })
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
}

//---------------------------------------------- BedrockKnowledgeBases ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Knowledge Base",
    plural: "Bedrock Knowledge Bases",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Knowledge", "Base"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockKnowledgeBase is TrackedResource<BedrockKnowledgeBaseProperties> {
  @doc("Name of BedrockKnowledgeBase")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockKnowledgeBases")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockKnowledgeBase")
model BedrockKnowledgeBaseProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockKnowledgeBaseProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockKnowledgeBase")
model AwsBedrockKnowledgeBaseProperties {
  @doc("The time at which the knowledge base was created.")
  createdAt?: string;

  @doc("Description of the Resource.")
  description?: string;

  @doc("A list of reasons that the API operation on the knowledge base failed.")
  failureReasons?: string[];

  @doc("The ARN of the knowledge base.")
  knowledgeBaseArn?: string;

  @doc("Contains details about the embeddings model used for the knowledge base.")
  knowledgeBaseConfiguration?: KnowledgeBaseConfiguration;

  @doc("The unique identifier of the knowledge base.")
  knowledgeBaseId?: string;

  @doc("The name of the knowledge base.")
  name?: string;

  @doc("The ARN of the IAM role with permissions to invoke API operations on the knowledge base. The ARN must begin with AmazonBedrockExecutionRoleForKnowledgeBase_")
  roleArn?: string;

  @doc("The status of a knowledge base.")
  status?: Status;

  @doc("The vector store service in which the knowledge base is stored.")
  storageConfiguration?: StorageConfiguration;

  @doc("A map of tag keys and values")
  tags?: Record<string>;

  @doc("The time at which the knowledge base was last updated.")
  updatedAt?: string;
}

@doc("Status enum")
union Status {
  @doc("Status enum ACTIVE")
  ACTIVE: "ACTIVE",

  @doc("Status enum CREATING")
  CREATING: "CREATING",

  @doc("Status enum DELETE_UNSUCCESSFUL")
  DELETE_UNSUCCESSFUL: "DELETE_UNSUCCESSFUL",

  @doc("Status enum DELETING")
  DELETING: "DELETING",

  @doc("Status enum FAILED")
  FAILED: "FAILED",

  @doc("Status enum UPDATING")
  UPDATING: "UPDATING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KnowledgeBaseConfiguration")
model KnowledgeBaseConfiguration {
  @doc("Configurations for a Kendra knowledge base")
  kendraKnowledgeBaseConfiguration?: KendraKnowledgeBaseConfiguration;

  @doc("Configurations for a SQL knowledge base")
  sqlKnowledgeBaseConfiguration?: SqlKnowledgeBaseConfiguration;

  @doc("The type of a knowledge base.")
  type?: KnowledgeBaseConfigurationType;

  @doc("Contains details about the model used to create vector embeddings for the knowledge base.")
  vectorKnowledgeBaseConfiguration?: VectorKnowledgeBaseConfiguration;
}

@doc("KnowledgeBaseConfigurationType enum")
union KnowledgeBaseConfigurationType {
  @doc("KnowledgeBaseConfigurationType enum KENDRA")
  KENDRA: "KENDRA",

  @doc("KnowledgeBaseConfigurationType enum SQL")
  SQL: "SQL",

  @doc("KnowledgeBaseConfigurationType enum VECTOR")
  VECTOR: "VECTOR",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StorageConfiguration")
model StorageConfiguration {
  @doc("Contains the storage configuration of the knowledge base in MongoDb Atlas Cloud.")
  mongoDbAtlasConfiguration?: MongoDbAtlasConfiguration;

  @doc("Contains the configurations to use Neptune Analytics as Vector Store.")
  neptuneAnalyticsConfiguration?: NeptuneAnalyticsConfiguration;

  @doc("Contains the storage configuration of the knowledge base in Amazon OpenSearch Service.")
  opensearchManagedClusterConfiguration?: OpenSearchManagedClusterConfiguration;

  @doc("Contains the storage configuration of the knowledge base in Amazon OpenSearch Service.")
  opensearchServerlessConfiguration?: OpenSearchServerlessConfiguration;

  @doc("Contains the storage configuration of the knowledge base in Pinecone.")
  pineconeConfiguration?: PineconeConfiguration;

  @doc("Contains details about the storage configuration of the knowledge base in Amazon RDS. For more information, see Create a vector index in Amazon RDS.")
  rdsConfiguration?: RdsConfiguration;

  @doc("The storage type of a knowledge base.")
  type?: StorageConfigurationType;
}

@doc("StorageConfigurationType enum")
union StorageConfigurationType {
  @doc("StorageConfigurationType enum MONGO_DB_ATLAS")
  MONGO_DB_ATLAS: "MONGO_DB_ATLAS",

  @doc("StorageConfigurationType enum NEPTUNE_ANALYTICS")
  NEPTUNE_ANALYTICS: "NEPTUNE_ANALYTICS",

  @doc("StorageConfigurationType enum OPENSEARCH_MANAGED_CLUSTER")
  OPENSEARCH_MANAGED_CLUSTER: "OPENSEARCH_MANAGED_CLUSTER",

  @doc("StorageConfigurationType enum OPENSEARCH_SERVERLESS")
  OPENSEARCH_SERVERLESS: "OPENSEARCH_SERVERLESS",

  @doc("StorageConfigurationType enum PINECONE")
  PINECONE: "PINECONE",

  @doc("StorageConfigurationType enum RDS")
  RDS: "RDS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KendraKnowledgeBaseConfiguration")
model KendraKnowledgeBaseConfiguration {
  @doc("Arn of a Kendra index")
  kendraIndexArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SqlKnowledgeBaseConfiguration")
model SqlKnowledgeBaseConfiguration {
  @doc("Configurations for a Redshift knowledge base")
  redshiftConfiguration?: RedshiftConfiguration;

  @doc("SQL query engine type")
  type?: SqlKnowledgeBaseConfigurationType;
}

@doc("SqlKnowledgeBaseConfigurationType enum")
union SqlKnowledgeBaseConfigurationType {
  @doc("SqlKnowledgeBaseConfigurationType enum REDSHIFT")
  REDSHIFT: "REDSHIFT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VectorKnowledgeBaseConfiguration")
model VectorKnowledgeBaseConfiguration {
  @doc("The ARN of the model used to create vector embeddings for the knowledge base.")
  embeddingModelArn?: string;

  @doc("The embeddings model configuration details for the vector model used in Knowledge Base.")
  embeddingModelConfiguration?: EmbeddingModelConfiguration;

  @doc("Configurations for supplemental data storage.")
  supplementalDataStorageConfiguration?: SupplementalDataStorageConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MongoDbAtlasConfiguration")
model MongoDbAtlasConfiguration {
  @doc("Name of the collection within MongoDB Atlas.")
  collectionName?: string;

  @doc("The ARN of the secret that you created in AWS Secrets Manager that is linked to your Amazon Mongo database.")
  credentialsSecretArn?: string;

  @doc("Name of the database within MongoDB Atlas.")
  databaseName?: string;

  @doc("MongoDB Atlas endpoint.")
  endpoint?: string;

  @doc("MongoDB Atlas endpoint service name.")
  endpointServiceName?: string;

  @doc("Contains the names of the fields to which to map information about the vector store.")
  fieldMapping?: MongoDbAtlasFieldMapping;

  @doc("Name of a MongoDB Atlas text index.")
  textIndexName?: string;

  @doc("Name of a MongoDB Atlas index.")
  vectorIndexName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeptuneAnalyticsConfiguration")
model NeptuneAnalyticsConfiguration {
  @doc("A mapping of Bedrock Knowledge Base fields to Neptune Analytics fields.")
  fieldMapping?: NeptuneAnalyticsFieldMapping;

  @doc("ARN for Neptune Analytics graph database.")
  graphArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchManagedClusterConfiguration")
model OpenSearchManagedClusterConfiguration {
  @doc("The Amazon Resource Name (ARN) of the OpenSearch domain.")
  domainArn?: string;

  @doc("The endpoint URL the OpenSearch domain.")
  domainEndpoint?: string;

  @doc("A mapping of Bedrock Knowledge Base fields to OpenSearch Managed Cluster field names")
  fieldMapping?: OpenSearchManagedClusterFieldMapping;

  @doc("The name of the vector store.")
  vectorIndexName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchServerlessConfiguration")
model OpenSearchServerlessConfiguration {
  @doc("The ARN of the OpenSearch Service vector store.")
  collectionArn?: string;

  @doc("A mapping of Bedrock Knowledge Base fields to OpenSearch Serverless field names")
  fieldMapping?: OpenSearchServerlessFieldMapping;

  @doc("The name of the vector store.")
  vectorIndexName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PineconeConfiguration")
model PineconeConfiguration {
  @doc("The endpoint URL for your index management page.")
  connectionString?: string;

  @doc("The ARN of the secret that you created in AWS Secrets Manager that is linked to your Pinecone API key.")
  credentialsSecretArn?: string;

  @doc("Contains the names of the fields to which to map information about the vector store.")
  fieldMapping?: PineconeFieldMapping;

  @doc("The namespace to be used to write new data to your database.")
  `namespace`?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsConfiguration")
model RdsConfiguration {
  @doc("The ARN of the secret that you created in AWS Secrets Manager that is linked to your Amazon RDS database.")
  credentialsSecretArn?: string;

  @doc("The name of your Amazon RDS database.")
  databaseName?: string;

  @doc("Contains the names of the fields to which to map information about the vector store.")
  fieldMapping?: RdsFieldMapping;

  @doc("The ARN of the vector store.")
  resourceArn?: string;

  @doc("The name of the table in the database.")
  tableName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftConfiguration")
model RedshiftConfiguration {
  @doc("Configurations for Redshift query engine")
  queryEngineConfiguration?: RedshiftQueryEngineConfiguration;

  @doc("Configurations for generating Redshift engine queries")
  queryGenerationConfiguration?: QueryGenerationConfiguration;

  @doc("List of configurations for available Redshift query engine storage types")
  @Azure.ResourceManager.identifiers(#[])
  storageConfigurations?: RedshiftQueryEngineStorageConfiguration[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EmbeddingModelConfiguration")
model EmbeddingModelConfiguration {
  @doc("The vector configuration details for the Bedrock embeddings model.")
  bedrockEmbeddingModelConfiguration?: BedrockEmbeddingModelConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SupplementalDataStorageConfiguration")
model SupplementalDataStorageConfiguration {
  @doc("List of supplemental data storage locations.")
  @Azure.ResourceManager.identifiers(#[])
  supplementalDataStorageLocations?: SupplementalDataStorageLocation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MongoDbAtlasFieldMapping")
model MongoDbAtlasFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the vector embeddings for your data sources.")
  vectorField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of NeptuneAnalyticsFieldMapping")
model NeptuneAnalyticsFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchManagedClusterFieldMapping")
model OpenSearchManagedClusterFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the vector embeddings for your data sources.")
  vectorField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenSearchServerlessFieldMapping")
model OpenSearchServerlessFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the vector embeddings for your data sources.")
  vectorField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PineconeFieldMapping")
model PineconeFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RdsFieldMapping")
model RdsFieldMapping {
  @doc("The name of the field in which Amazon Bedrock stores custom metadata about the vector store.")
  customMetadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores metadata about the vector store.")
  metadataField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the ID for each entry.")
  primaryKeyField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the raw text from your data. The text is split according to the chunking strategy you choose.")
  textField?: string;

  @doc("The name of the field in which Amazon Bedrock stores the vector embeddings for your data sources.")
  vectorField?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftQueryEngineConfiguration")
model RedshiftQueryEngineConfiguration {
  @doc("Configurations for provisioned Redshift query engine")
  provisionedConfiguration?: RedshiftProvisionedConfiguration;

  @doc("Configurations for serverless Redshift query engine")
  serverlessConfiguration?: RedshiftServerlessConfiguration;

  @doc("Redshift query engine type")
  type?: RedshiftQueryEngineConfigurationType;
}

@doc("RedshiftQueryEngineConfigurationType enum")
union RedshiftQueryEngineConfigurationType {
  @doc("RedshiftQueryEngineConfigurationType enum PROVISIONED")
  PROVISIONED: "PROVISIONED",

  @doc("RedshiftQueryEngineConfigurationType enum SERVERLESS")
  SERVERLESS: "SERVERLESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryGenerationConfiguration")
model QueryGenerationConfiguration {
  @doc("Max query execution timeout")
  executionTimeoutSeconds?: int32;

  @doc("Context used to improve query generation")
  generationContext?: QueryGenerationContext;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftQueryEngineStorageConfiguration")
model RedshiftQueryEngineStorageConfiguration {
  @doc("Configurations for Redshift query engine AWS Data Catalog backed storage")
  awsDataCatalogConfiguration?: RedshiftQueryEngineAwsDataCatalogStorageConfiguration;

  @doc("Configurations for Redshift query engine Redshift backed storage")
  redshiftConfiguration?: RedshiftQueryEngineRedshiftStorageConfiguration;

  @doc("Redshift query engine storage type")
  type?: RedshiftQueryEngineStorageConfigurationType;
}

@doc("RedshiftQueryEngineStorageConfigurationType enum")
union RedshiftQueryEngineStorageConfigurationType {
  @doc("RedshiftQueryEngineStorageConfigurationType enum AWS_DATA_CATALOG")
  AWS_DATA_CATALOG: "AWS_DATA_CATALOG",

  @doc("RedshiftQueryEngineStorageConfigurationType enum REDSHIFT")
  REDSHIFT: "REDSHIFT",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockEmbeddingModelConfiguration")
model BedrockEmbeddingModelConfiguration {
  @doc("The dimensions details for the vector configuration used on the Bedrock embeddings model.")
  dimensions?: int32;

  @doc("The data type for the vectors when using a model to convert text into vector embeddings.")
  embeddingDataType?: BedrockEmbeddingModelConfigurationEmbeddingDataType;
}

@doc("BedrockEmbeddingModelConfigurationEmbeddingDataType enum")
union BedrockEmbeddingModelConfigurationEmbeddingDataType {
  @doc("BedrockEmbeddingModelConfigurationEmbeddingDataType enum BINARY")
  BINARY: "BINARY",

  @doc("BedrockEmbeddingModelConfigurationEmbeddingDataType enum FLOAT32")
  FLOAT32: "FLOAT32",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SupplementalDataStorageLocation")
model SupplementalDataStorageLocation {
  @doc("An Amazon S3 location.")
  s3Location?: S3Location;

  @doc("Supplemental data storage location type.")
  supplementalDataStorageLocationType?: SupplementalDataStorageLocationSupplementalDataStorageLocationType;
}

@doc("SupplementalDataStorageLocationSupplementalDataStorageLocationType enum")
union SupplementalDataStorageLocationSupplementalDataStorageLocationType {
  @doc("SupplementalDataStorageLocationSupplementalDataStorageLocationType enum S3")
  S3: "S3",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftProvisionedConfiguration")
model RedshiftProvisionedConfiguration {
  @doc("Configurations for Redshift query engine provisioned auth setup")
  authConfiguration?: RedshiftProvisionedAuthConfiguration;

  @doc("Redshift cluster identifier")
  clusterIdentifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftServerlessConfiguration")
model RedshiftServerlessConfiguration {
  @doc("Configurations for Redshift query engine serverless auth setup")
  authConfiguration?: RedshiftServerlessAuthConfiguration;

  @doc("Workgroup arn")
  workgroupArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryGenerationContext")
model QueryGenerationContext {
  @doc("List of example queries and results")
  @Azure.ResourceManager.identifiers(#[])
  curatedQueries?: CuratedQuery[];

  @doc("List of tables used for Redshift query generation context")
  @Azure.ResourceManager.identifiers(#[])
  tables?: QueryGenerationTable[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftQueryEngineAwsDataCatalogStorageConfiguration")
model RedshiftQueryEngineAwsDataCatalogStorageConfiguration {
  @doc("List of table names in AWS Data Catalog. Must follow two part notation")
  tableNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftQueryEngineRedshiftStorageConfiguration")
model RedshiftQueryEngineRedshiftStorageConfiguration {
  @doc("Redshift database name")
  databaseName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3Location")
model S3Location {
  @doc("The location's URI")
  uri?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftProvisionedAuthConfiguration")
model RedshiftProvisionedAuthConfiguration {
  @doc("Redshift database user")
  databaseUser?: string;

  @doc("Provisioned Redshift auth type")
  type?: RedshiftProvisionedAuthConfigurationType;

  @doc("Arn of a SecretsManager Secret")
  usernamePasswordSecretArn?: string;
}

@doc("RedshiftProvisionedAuthConfigurationType enum")
union RedshiftProvisionedAuthConfigurationType {
  @doc("RedshiftProvisionedAuthConfigurationType enum IAM")
  IAM: "IAM",

  @doc("RedshiftProvisionedAuthConfigurationType enum USERNAME")
  USERNAME: "USERNAME",

  @doc("RedshiftProvisionedAuthConfigurationType enum USERNAME_PASSWORD")
  USERNAME_PASSWORD: "USERNAME_PASSWORD",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RedshiftServerlessAuthConfiguration")
model RedshiftServerlessAuthConfiguration {
  @doc("Serverless Redshift auth type")
  type?: RedshiftServerlessAuthConfigurationType;

  @doc("Arn of a SecretsManager Secret")
  usernamePasswordSecretArn?: string;
}

@doc("RedshiftServerlessAuthConfigurationType enum")
union RedshiftServerlessAuthConfigurationType {
  @doc("RedshiftServerlessAuthConfigurationType enum IAM")
  IAM: "IAM",

  @doc("RedshiftServerlessAuthConfigurationType enum USERNAME_PASSWORD")
  USERNAME_PASSWORD: "USERNAME_PASSWORD",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CuratedQuery")
model CuratedQuery {
  @doc("Question for the curated query")
  naturalLanguage?: string;

  @doc("Answer for the curated query")
  sql?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryGenerationTable")
model QueryGenerationTable {
  @doc("List of Redshift query generation columns")
  @Azure.ResourceManager.identifiers(#[])
  columns?: QueryGenerationColumn[];

  @doc("Description for the attached entity")
  description?: string;

  @doc("Include or Exclude status for an entity")
  inclusion?: QueryGenerationTableInclusion;

  @doc("Query generation table name. Must follow three-part notation")
  name?: string;
}

@doc("QueryGenerationTableInclusion enum")
union QueryGenerationTableInclusion {
  @doc("QueryGenerationTableInclusion enum EXCLUDE")
  EXCLUDE: "EXCLUDE",

  @doc("QueryGenerationTableInclusion enum INCLUDE")
  INCLUDE: "INCLUDE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of QueryGenerationColumn")
model QueryGenerationColumn {
  @doc("Description for the attached entity")
  description?: string;

  @doc("Include or Exclude status for an entity")
  inclusion?: QueryGenerationColumnInclusion;

  @doc("Query generation column name")
  name?: string;
}

@doc("QueryGenerationColumnInclusion enum")
union QueryGenerationColumnInclusion {
  @doc("QueryGenerationColumnInclusion enum EXCLUDE")
  EXCLUDE: "EXCLUDE",

  @doc("QueryGenerationColumnInclusion enum INCLUDE")
  INCLUDE: "INCLUDE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockKnowledgeBases {
  get is ArmResourceRead<BedrockKnowledgeBase>;
  @doc("Create a BedrockKnowledgeBase. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockKnowledgeBase>;
  update is ArmCustomPatchAsync<
    BedrockKnowledgeBase,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockKnowledgeBase>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockKnowledgeBase>;
  listByResourceGroup is ArmResourceListByParent<BedrockKnowledgeBase>;
  listBySubscription is ArmListBySubscription<BedrockKnowledgeBase>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::KnowledgeBase
//--------------------------------------------------------------------------------------------
