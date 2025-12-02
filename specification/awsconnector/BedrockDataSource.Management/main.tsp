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

//---------------------------------------------- BedrockDataSources ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Bedrock Data Source",
    plural: "Bedrock Data Sources",
  },
  keywords: ["Microsoft.AwsConnector", "Bedrock", "Data", "Source"],
})
@doc("A Microsoft.AwsConnector resource")
model BedrockDataSource is TrackedResource<BedrockDataSourceProperties> {
  @doc("Name of BedrockDataSource")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("bedrockDataSources")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockDataSource")
model BedrockDataSourceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsBedrockDataSourceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsBedrockDataSource")
model AwsBedrockDataSourceProperties {
  @doc("The time at which the data source was created.")
  createdAt?: string;

  @doc("The deletion policy for the data source.")
  dataDeletionPolicy?: DataDeletionPolicy;

  @doc("Specifies a raw data source location to ingest.")
  dataSourceConfiguration?: DataSourceConfiguration;

  @doc("Identifier for a resource.")
  dataSourceId?: string;

  @doc("The status of a data source.")
  dataSourceStatus?: DataSourceStatus;

  @doc("Description of the Resource.")
  description?: string;

  @doc("The details of the failure reasons related to the data source.")
  failureReasons?: string[];

  @doc("The unique identifier of the knowledge base to which to add the data source.")
  knowledgeBaseId?: string;

  @doc("The name of the data source.")
  name?: string;

  @doc("Contains details about the server-side encryption for the data source.")
  serverSideEncryptionConfiguration?: ServerSideEncryptionConfiguration;

  @doc("The time at which the knowledge base was last updated.")
  updatedAt?: string;

  @doc("Details about how to chunk the documents in the data source. A chunk refers to an excerpt from a data source that is returned when the knowledge base that it belongs to is queried.")
  vectorIngestionConfiguration?: VectorIngestionConfiguration;
}

@doc("DataDeletionPolicy enum")
union DataDeletionPolicy {
  @doc("DataDeletionPolicy enum DELETE")
  DELETE: "DELETE",

  @doc("DataDeletionPolicy enum RETAIN")
  RETAIN: "RETAIN",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DataSourceConfiguration")
model DataSourceConfiguration {
  @doc("The configuration information to connect to Confluence as your data source.")
  confluenceConfiguration?: ConfluenceDataSourceConfiguration;

  @doc("The configuration information to connect to Amazon S3 as your data source.")
  s3Configuration?: S3DataSourceConfiguration;

  @doc("The configuration information to connect to Salesforce as your data source.")
  salesforceConfiguration?: SalesforceDataSourceConfiguration;

  @doc("The configuration information to connect to SharePoint as your data source.")
  sharePointConfiguration?: SharePointDataSourceConfiguration;

  @doc("The type of the data source location.")
  type?: DataSourceConfigurationType;

  @doc("Configures a web data source location.")
  webConfiguration?: WebDataSourceConfiguration;
}

@doc("DataSourceStatus enum")
union DataSourceStatus {
  @doc("DataSourceStatus enum AVAILABLE")
  AVAILABLE: "AVAILABLE",

  @doc("DataSourceStatus enum DELETE_UNSUCCESSFUL")
  DELETE_UNSUCCESSFUL: "DELETE_UNSUCCESSFUL",

  @doc("DataSourceStatus enum DELETING")
  DELETING: "DELETING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ServerSideEncryptionConfiguration")
model ServerSideEncryptionConfiguration {
  @doc("The ARN of the AWS KMS key used to encrypt the resource.")
  kmsKeyArn?: string;
}

@doc("DataSourceConfigurationType enum")
union DataSourceConfigurationType {
  @doc("DataSourceConfigurationType enum CONFLUENCE")
  CONFLUENCE: "CONFLUENCE",

  @doc("DataSourceConfigurationType enum CUSTOM")
  CUSTOM: "CUSTOM",

  @doc("DataSourceConfigurationType enum REDSHIFT_METADATA")
  REDSHIFT_METADATA: "REDSHIFT_METADATA",

  @doc("DataSourceConfigurationType enum S3")
  S3: "S3",

  @doc("DataSourceConfigurationType enum SALESFORCE")
  SALESFORCE: "SALESFORCE",

  @doc("DataSourceConfigurationType enum SHAREPOINT")
  SHAREPOINT: "SHAREPOINT",

  @doc("DataSourceConfigurationType enum WEB")
  WEB: "WEB",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VectorIngestionConfiguration")
model VectorIngestionConfiguration {
  @doc("Details about how to chunk the documents in the data source. A chunk refers to an excerpt from a data source that is returned when the knowledge base that it belongs to is queried.")
  chunkingConfiguration?: ChunkingConfiguration;

  @doc("Additional Enrichment Configuration for example when using GraphRag.")
  contextEnrichmentConfiguration?: ContextEnrichmentConfiguration;

  @doc("Settings for customizing steps in the data source content ingestion pipeline.")
  customTransformationConfiguration?: CustomTransformationConfiguration;

  @doc("Settings for parsing document contents")
  parsingConfiguration?: ParsingConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfluenceDataSourceConfiguration")
model ConfluenceDataSourceConfiguration {
  @doc("The configuration of the Confluence content. For example, configuring specific types of Confluence content.")
  crawlerConfiguration?: ConfluenceCrawlerConfiguration;

  @doc("The endpoint information to connect to your Confluence data source.")
  sourceConfiguration?: ConfluenceSourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3DataSourceConfiguration")
model S3DataSourceConfiguration {
  @doc("The ARN of the bucket that contains the data source.")
  bucketArn?: string;

  @doc("The account ID for the owner of the S3 bucket.")
  bucketOwnerAccountId?: string;

  @doc("A list of S3 prefixes that define the object containing the data sources.")
  inclusionPrefixes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SalesforceDataSourceConfiguration")
model SalesforceDataSourceConfiguration {
  @doc("The configuration of filtering the Salesforce content. For example, configuring regular expression patterns to include or exclude certain content.")
  crawlerConfiguration?: SalesforceCrawlerConfiguration;

  @doc("The endpoint information to connect to your Salesforce data source.")
  sourceConfiguration?: SalesforceSourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SharePointDataSourceConfiguration")
model SharePointDataSourceConfiguration {
  @doc("The configuration of the SharePoint content. For example, configuring specific types of SharePoint content.")
  crawlerConfiguration?: SharePointCrawlerConfiguration;

  @doc("The endpoint information to connect to your SharePoint data source.")
  sourceConfiguration?: SharePointSourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebDataSourceConfiguration")
model WebDataSourceConfiguration {
  @doc("Configuration for the web crawler.")
  crawlerConfiguration?: WebCrawlerConfiguration;

  @doc("A web source configuration.")
  sourceConfiguration?: WebSourceConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ChunkingConfiguration")
model ChunkingConfiguration {
  @doc("Knowledge base can split your source data into chunks. A chunk refers to an excerpt from a data source that is returned when the knowledge base that it belongs to is queried. You have the following options for chunking your data. If you opt for NONE, then you may want to pre-process your files by splitting them up such that each file corresponds to a chunk.")
  chunkingStrategy?: ChunkingConfigurationChunkingStrategy;

  @doc("Configurations for when you choose fixed-size chunking. If you set the chunkingStrategy as NONE, exclude this field.")
  fixedSizeChunkingConfiguration?: FixedSizeChunkingConfiguration;

  @doc("Configurations for when you choose hierarchical chunking. If you set the chunkingStrategy as NONE, exclude this field.")
  hierarchicalChunkingConfiguration?: HierarchicalChunkingConfiguration;

  @doc("Configurations for when you choose semantic chunking. If you set the chunkingStrategy as NONE, exclude this field.")
  semanticChunkingConfiguration?: SemanticChunkingConfiguration;
}

@doc("ChunkingConfigurationChunkingStrategy enum")
union ChunkingConfigurationChunkingStrategy {
  @doc("ChunkingConfigurationChunkingStrategy enum FIXED_SIZE")
  FIXED_SIZE: "FIXED_SIZE",

  @doc("ChunkingConfigurationChunkingStrategy enum HIERARCHICAL")
  HIERARCHICAL: "HIERARCHICAL",

  @doc("ChunkingConfigurationChunkingStrategy enum NONE")
  NONE: "NONE",

  @doc("ChunkingConfigurationChunkingStrategy enum SEMANTIC")
  SEMANTIC: "SEMANTIC",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ContextEnrichmentConfiguration")
model ContextEnrichmentConfiguration {
  @doc("Bedrock Foundation Model configuration to be used for Context Enrichment.")
  bedrockFoundationModelConfiguration?: BedrockFoundationModelContextEnrichmentConfiguration;

  @doc("Enrichment type to be used for the vector database.")
  type?: ContextEnrichmentConfigurationType;
}

@doc("ContextEnrichmentConfigurationType enum")
union ContextEnrichmentConfigurationType {
  @doc("ContextEnrichmentConfigurationType enum BEDROCK_FOUNDATION_MODEL")
  BEDROCK_FOUNDATION_MODEL: "BEDROCK_FOUNDATION_MODEL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CustomTransformationConfiguration")
model CustomTransformationConfiguration {
  @doc("A location for storing content from data sources temporarily as it is processed by custom components in the ingestion pipeline.")
  intermediateStorage?: IntermediateStorage;

  @doc("A list of Lambda functions that process documents.")
  @Azure.ResourceManager.identifiers(#[])
  transformations?: Transformation[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ParsingConfiguration")
model ParsingConfiguration {
  @doc("Settings for a Bedrock Data Automation used to parse documents for a data source.")
  bedrockDataAutomationConfiguration?: BedrockDataAutomationConfiguration;

  @doc("Settings for a foundation model used to parse documents for a data source.")
  bedrockFoundationModelConfiguration?: BedrockFoundationModelConfiguration;

  @doc("The parsing strategy for the data source.")
  parsingStrategy?: ParsingConfigurationParsingStrategy;
}

@doc("ParsingConfigurationParsingStrategy enum")
union ParsingConfigurationParsingStrategy {
  @doc("ParsingConfigurationParsingStrategy enum BEDROCK_DATA_AUTOMATION")
  BEDROCK_DATA_AUTOMATION: "BEDROCK_DATA_AUTOMATION",

  @doc("ParsingConfigurationParsingStrategy enum BEDROCK_FOUNDATION_MODEL")
  BEDROCK_FOUNDATION_MODEL: "BEDROCK_FOUNDATION_MODEL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfluenceCrawlerConfiguration")
model ConfluenceCrawlerConfiguration {
  @doc("The type of filtering that you want to apply to certain objects or content of the data source. For example, the PATTERN type is regular expression patterns you can apply to filter your content.")
  filterConfiguration?: CrawlFilterConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfluenceSourceConfiguration")
model ConfluenceSourceConfiguration {
  @doc("The supported authentication type to authenticate and connect to your Confluence instance.")
  authType?: ConfluenceSourceConfigurationAuthType;

  @doc("The Amazon Resource Name of an AWS Secrets Manager secret that stores your authentication credentials for your Confluence instance URL. For more information on the key-value pairs that must be included in your secret, depending on your authentication type, see Confluence connection configuration.")
  credentialsSecretArn?: string;

  @doc("The supported host type, whether online/cloud or server/on-premises.")
  hostType?: ConfluenceSourceConfigurationHostType;

  @doc("The Confluence host URL or instance URL.")
  hostUrl?: string;
}

@doc("ConfluenceSourceConfigurationAuthType enum")
union ConfluenceSourceConfigurationAuthType {
  @doc("ConfluenceSourceConfigurationAuthType enum BASIC")
  BASIC: "BASIC",

  @doc("ConfluenceSourceConfigurationAuthType enum OAUTH2_CLIENT_CREDENTIALS")
  OAUTH2_CLIENT_CREDENTIALS: "OAUTH2_CLIENT_CREDENTIALS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SalesforceCrawlerConfiguration")
model SalesforceCrawlerConfiguration {
  @doc("The type of filtering that you want to apply to certain objects or content of the data source. For example, the PATTERN type is regular expression patterns you can apply to filter your content.")
  filterConfiguration?: CrawlFilterConfiguration;
}

@doc("ConfluenceSourceConfigurationHostType enum")
union ConfluenceSourceConfigurationHostType {
  @doc("ConfluenceSourceConfigurationHostType enum SAAS")
  SAAS: "SAAS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SalesforceSourceConfiguration")
model SalesforceSourceConfiguration {
  @doc("The supported authentication type to authenticate and connect to your Salesforce instance.")
  authType?: SalesforceSourceConfigurationAuthType;

  @doc("The Amazon Resource Name of an AWS Secrets Manager secret that stores your authentication credentials for your Salesforce instance URL. For more information on the key-value pairs that must be included in your secret, depending on your authentication type, see Salesforce connection configuration.")
  credentialsSecretArn?: string;

  @doc("The Salesforce host URL or instance URL.")
  hostUrl?: string;
}

@doc("SalesforceSourceConfigurationAuthType enum")
union SalesforceSourceConfigurationAuthType {
  @doc("SalesforceSourceConfigurationAuthType enum OAUTH2_CLIENT_CREDENTIALS")
  OAUTH2_CLIENT_CREDENTIALS: "OAUTH2_CLIENT_CREDENTIALS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SharePointCrawlerConfiguration")
model SharePointCrawlerConfiguration {
  @doc("The type of filtering that you want to apply to certain objects or content of the data source. For example, the PATTERN type is regular expression patterns you can apply to filter your content.")
  filterConfiguration?: CrawlFilterConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SharePointSourceConfiguration")
model SharePointSourceConfiguration {
  @doc("The supported authentication type to authenticate and connect to your SharePoint site/sites.")
  authType?: SharePointSourceConfigurationAuthType;

  @doc("The Amazon Resource Name of an AWS Secrets Manager secret that stores your authentication credentials for your SharePoint site/sites. For more information on the key-value pairs that must be included in your secret, depending on your authentication type, see SharePoint connection configuration.")
  credentialsSecretArn?: string;

  @doc("The domain of your SharePoint instance or site URL/URLs.")
  domain?: string;

  @doc("The supported host type, whether online/cloud or server/on-premises.")
  hostType?: SharePointSourceConfigurationHostType;

  @doc("A list of one or more SharePoint site URLs.")
  siteUrls?: string[];

  @doc("The identifier of your Microsoft 365 tenant.")
  tenantId?: string;
}

@doc("SharePointSourceConfigurationAuthType enum")
union SharePointSourceConfigurationAuthType {
  @doc("SharePointSourceConfigurationAuthType enum OAUTH2_CLIENT_CREDENTIALS")
  OAUTH2_CLIENT_CREDENTIALS: "OAUTH2_CLIENT_CREDENTIALS",

  @doc("SharePointSourceConfigurationAuthType enum OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS")
  OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS: "OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebCrawlerConfiguration")
model WebCrawlerConfiguration {
  @doc("Limit settings for the web crawler.")
  crawlerLimits?: WebCrawlerLimits;

  @doc("A set of regular expression filter patterns for a type of object.")
  exclusionFilters?: string[];

  @doc("A set of regular expression filter patterns for a type of object.")
  inclusionFilters?: string[];

  @doc("The scope that a web crawl job will be restricted to.")
  scope?: WebCrawlerConfigurationScope;

  @doc("The suffix that will be included in the user agent header.")
  userAgent?: string;

  @doc("The full user agent header, including UUID and suffix.")
  userAgentHeader?: string;
}

@doc("SharePointSourceConfigurationHostType enum")
union SharePointSourceConfigurationHostType {
  @doc("SharePointSourceConfigurationHostType enum ONLINE")
  ONLINE: "ONLINE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebSourceConfiguration")
model WebSourceConfiguration {
  @doc("A url configuration.")
  urlConfiguration?: UrlConfiguration;
}

@doc("WebCrawlerConfigurationScope enum")
union WebCrawlerConfigurationScope {
  @doc("WebCrawlerConfigurationScope enum HOST_ONLY")
  HOST_ONLY: "HOST_ONLY",

  @doc("WebCrawlerConfigurationScope enum SUBDOMAINS")
  SUBDOMAINS: "SUBDOMAINS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of FixedSizeChunkingConfiguration")
model FixedSizeChunkingConfiguration {
  @doc("The maximum number of tokens to include in a chunk.")
  maxTokens?: int32;

  @doc("The percentage of overlap between adjacent chunks of a data source.")
  overlapPercentage?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HierarchicalChunkingConfiguration")
model HierarchicalChunkingConfiguration {
  @doc("Token settings for each layer.")
  @Azure.ResourceManager.identifiers(#[])
  levelConfigurations?: HierarchicalChunkingLevelConfiguration[];

  @doc("The number of tokens to repeat across chunks in the same layer.")
  overlapTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SemanticChunkingConfiguration")
model SemanticChunkingConfiguration {
  @doc("The dissimilarity threshold for splitting chunks.")
  breakpointPercentileThreshold?: int32;

  @doc("The buffer size.")
  bufferSize?: int32;

  @doc("The maximum number of tokens that a chunk can contain.")
  maxTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockFoundationModelContextEnrichmentConfiguration")
model BedrockFoundationModelContextEnrichmentConfiguration {
  @doc("Strategy to be used when using Bedrock Foundation Model for Context Enrichment.")
  enrichmentStrategyConfiguration?: EnrichmentStrategyConfiguration;

  @doc("The model's ARN.")
  modelArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IntermediateStorage")
model IntermediateStorage {
  @doc("An Amazon S3 location.")
  s3Location?: S3Location;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Transformation")
model Transformation {
  @doc("When the service applies the transformation.")
  stepToApply?: TransformationStepToApply;

  @doc("A Lambda function that processes documents.")
  transformationFunction?: TransformationFunction;
}

@doc("TransformationStepToApply enum")
union TransformationStepToApply {
  @doc("TransformationStepToApply enum POST_CHUNKING")
  POST_CHUNKING: "POST_CHUNKING",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockDataAutomationConfiguration")
model BedrockDataAutomationConfiguration {
  @doc("Determine how will parsed content be stored.")
  parsingModality?: BedrockDataAutomationConfigurationParsingModality;
}

@doc("BedrockDataAutomationConfigurationParsingModality enum")
union BedrockDataAutomationConfigurationParsingModality {
  @doc("BedrockDataAutomationConfigurationParsingModality enum MULTIMODAL")
  MULTIMODAL: "MULTIMODAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BedrockFoundationModelConfiguration")
model BedrockFoundationModelConfiguration {
  @doc("The model's ARN.")
  modelArn?: string;

  @doc("Determine how will parsed content be stored.")
  parsingModality?: BedrockFoundationModelConfigurationParsingModality;

  @doc("Instructions for interpreting the contents of a document.")
  parsingPrompt?: ParsingPrompt;
}

@doc("BedrockFoundationModelConfigurationParsingModality enum")
union BedrockFoundationModelConfigurationParsingModality {
  @doc("BedrockFoundationModelConfigurationParsingModality enum MULTIMODAL")
  MULTIMODAL: "MULTIMODAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CrawlFilterConfiguration")
model CrawlFilterConfiguration {
  @doc("The configuration of specific filters applied to your data source content. You can filter out or include certain content.")
  patternObjectFilter?: PatternObjectFilterConfiguration;

  @doc("The crawl filter type.")
  type?: CrawlFilterConfigurationType;
}

@doc("CrawlFilterConfigurationType enum")
union CrawlFilterConfigurationType {
  @doc("CrawlFilterConfigurationType enum PATTERN")
  PATTERN: "PATTERN",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of WebCrawlerLimits")
model WebCrawlerLimits {
  @doc("Maximum number of pages the crawler can crawl.")
  maxPages?: int32;

  @doc("Rate of web URLs retrieved per minute.")
  rateLimit?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UrlConfiguration")
model UrlConfiguration {
  @doc("A list of web urls.")
  @Azure.ResourceManager.identifiers(#[])
  seedUrls?: SeedUrl[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HierarchicalChunkingLevelConfiguration")
model HierarchicalChunkingLevelConfiguration {
  @doc("The maximum number of tokens that a chunk can contain in this layer.")
  maxTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnrichmentStrategyConfiguration")
model EnrichmentStrategyConfiguration {
  @doc("Enrichment Strategy method.")
  method?: EnrichmentStrategyConfigurationMethod;
}

@doc("EnrichmentStrategyConfigurationMethod enum")
union EnrichmentStrategyConfigurationMethod {
  @doc("EnrichmentStrategyConfigurationMethod enum CHUNK_ENTITY_EXTRACTION")
  CHUNK_ENTITY_EXTRACTION: "CHUNK_ENTITY_EXTRACTION",

  string,
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
@doc("Definition of TransformationFunction")
model TransformationFunction {
  @doc("A Lambda function that processes documents.")
  transformationLambdaConfiguration?: TransformationLambdaConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ParsingPrompt")
model ParsingPrompt {
  @doc("Instructions for interpreting the contents of a document.")
  parsingPromptText?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PatternObjectFilterConfiguration")
model PatternObjectFilterConfiguration {
  @doc("Contains information")
  @Azure.ResourceManager.identifiers(#[])
  filters?: PatternObjectFilter[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SeedUrl")
model SeedUrl {
  @doc("A web url.")
  url?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TransformationLambdaConfiguration")
model TransformationLambdaConfiguration {
  @doc("The function's ARN identifier.")
  lambdaArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PatternObjectFilter")
model PatternObjectFilter {
  @doc("A set of regular expression filter patterns for a type of object.")
  exclusionFilters?: string[];

  @doc("A set of regular expression filter patterns for a type of object.")
  inclusionFilters?: string[];

  @doc("The supported object type or content type of the data source.")
  objectType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface BedrockDataSources {
  get is ArmResourceRead<BedrockDataSource>;
  @doc("Create a BedrockDataSource. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<BedrockDataSource>;
  update is ArmCustomPatchAsync<
    BedrockDataSource,
    Azure.ResourceManager.Foundations.TagsUpdateModel<BedrockDataSource>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<BedrockDataSource>;
  listByResourceGroup is ArmResourceListByParent<BedrockDataSource>;
  listBySubscription is ArmListBySubscription<BedrockDataSource>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Bedrock::DataSource
//--------------------------------------------------------------------------------------------
