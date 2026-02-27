import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

@armProviderNamespace
@service(#{ title: "GRIP Service", version: "2023-07-13" })
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Grip;

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Jobs {
  get is ArmLocResourceRead<JobDefinitionResource>;
  create is ArmLocResourceCreateOrUpdateSync<JobDefinitionResource>;
  delete is ArmLocResourceDeleteSync<JobDefinitionResource>;
  listByResourceGroup is ArmLocResourceListByParent<JobDefinitionResource>;
  listBySubscription is ArmLocResourceListBySubscription<JobDefinitionResource>;
}

model LocationInstanceParameters<
  T extends ArmResource,
  TBaseParameters = BaseParameters<T>
> {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...KeysOf<T>;
}

model LocationCollectionParameters<T extends ArmResource> {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...ParentKeysOf<T>;
}

model LocationCollectionParametersSubscription<T extends ArmResource> {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ProviderNamespace<T>;
  ...LocationParameter;
  ...ParentKeysOf<T>;
}

/**
 * A resource list operation, at the scope of the resource's parent
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 * @template TParentName Optional. The name of the parent resource
 * @template TParentFriendlyName Optional. The friendly name of the parent resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Operation Template types must use PascalCase"
@autoRoute
@doc("List {name} resources by subscription ID", TResource)
@list(TResource)
@segmentOf(TResource)
@armResourceList(TResource)
@get
op ArmLocResourceListBySubscription<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName extends valueof string = "",
  TParentFriendlyName extends valueof string = ""
>(
  ...LocationCollectionParametersSubscription<TResource>,
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

@doc("Provisioning state")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is in the provisioning state.")
  Provisioning,

  @doc("Resource is in the updating state.")
  Updating,

  @doc("Resource is in the deleting state.")
  Deleting,

  @doc("Resource is in the accepted state.")
  Accepted,
}

@doc("Disk storage configuration")
model DiskStorageConfiguration {
  @doc("Flag determining if disk storage is enabled for a job.")
  enabled: boolean;

  @doc("Disk quota in megabytes.")
  quotaInMb: int64;
}

@doc("Trill configuration object")
model TrillConfiguration {
  @doc("Trill disorder policy.")
  disorderPolicy: string;

  @doc("Out of order ticks allowed in Trill. Event's that have timestamps that are out of order by the specified number of ticks will have their timestamp adjusted. Otherwise if the timestamp is out of order more than the specified ticks, the event is dropped.")
  maxOutOfOrderAllowedTicks: int64;

  @doc("This policy determines what Trill will do when a data stream ends. Valid values are either 'Flush', or 'None'.")
  onCompletedPolicy: string;

  @doc("Punctuation period determines how often punctuation events Trill will generate and ingress into the data stream. These events help progress Trill's timeline.")
  punctuationGenerationPeriod: int64;

  @doc("Trill data batch size. This size determines the number of events Trill will batch before flushing its buffer and outputting a value.")
  dataBatchSize: int32;

  @doc("Flag for determining if columnar mode is enabled in Trill, which will will sort stream data into columns. This is useful when properties on event's infrequently change.")
  clearColumnOnReturn: boolean;

  @doc("Flag determining if row execution mode is enabled in Trill.")
  forceRowBasedExecution: boolean;
}

@doc("Bond serializer path")
enum BondSerializerPath {
  @doc("json serialization.")
  ViaJson,

  @doc("Direct path")
  Direct,
}

@doc("Represents a CosmosDB connection scheme. This can be a connection string, or managed through Dsms.")
model TypeValue {
  @doc("Type of CosmosDB connection scheme.")
  type: string;

  @doc("Value of the connection scheme.")
  value: string;
}

@doc("Kafka source")
model KafkaSource {
  @doc("Kafka offset value a consumer will start from when a job is created.")
  offset: int32;

  @doc("Determines if events consumed from Kafka should have nested IRecord objects as properties before further processing in GRIP.")
  enableNestedRecords: boolean;

  @doc("Determines if events consumed from Kafka should have all nested properties flattened before further processing in GRIP.")
  enableFlattenRecords: boolean;

  @doc("Flag determining if a Kafka consumer should rebalance from a committed offset when a rebalance event is processed at runtime. This will start the consumer from an intermediate offset if enabled.")
  rebalanceFromCommittedOffset: boolean;

  @doc("Kafka connection endpoint.")
  endpoint: string;

  @doc("Kafka connection target. This is either 'AZ' or 'region', which is used to build the connection string to connect to a Kafka topic.")
  target: string;

  @doc("Type of connection for a Kafka topic. This can be a PF local, zonal, or regional type.")
  connectionType: string;

  @doc("Kafka topic name.")
  topic: string;

  @doc("Message schema type for the events consumed from the Kafka topic. This is a C# class path that points to a proto, json, or bond schema.")
  schema: string;

  @doc("Unsecure connection flag. If true, an HTTP connection is established instead of HTTPS.")
  useUnsecureConnection: boolean;

  @doc("Enable Kafka consumer logging. THis will log all consumer events from Kafka")
  enableLogging: boolean;

  @doc("Kafka message format. This can be json, proto, or bond.")
  format: string;
}

@doc("Producer buffer configuration")
model ProducerBufferConfiguration {
  @doc("Batch size in bytes.")
  batchSizeInBytes: int32;

  @doc("linger ms. This determines how long a producer will wait before producing an existing buffer of data.")
  lingerMs: int32;

  @doc("Retry count a producer will perform on a buffer.")
  retries: int32;

  @doc("Retry backoff ms. The amount of time a producer will wait before retrying to produce buffered data.")
  retryBackoffMs: int32;
}

@doc("Cosmos destination")
model CosmosDestination {
  @doc("The alias name of a cosmos output in a GRIP SQL query.")
  outputAlias: string;

  @doc("Partition key of a CosmosDB container.")
  partitionKey: string;

  @doc("The document id path that exists in an object being written to CosmosDB")
  documentId: string;

  @doc("CosmosDB producer configuration")
  producerConfiguration: ProducerBufferConfiguration;

  @doc("Ignore errors flag. If true, producer errors are ignored a job will not be restarted.")
  ignoreErrors: boolean;

  @doc("post process function that gets executed against messages that have been generated by the query.")
  postProcessFunction: string;
}

@doc("Kafka destination")
model KafkaDestination {
  @doc("partition key path")
  partitionKeyPath: string;

  @doc("Ignore errors flag. If true, producer errors are ignored a job will not be restarted.")
  ignoreErrors: boolean;

  @doc("Flag indicating if a reliable producer should be used when producing messages to Kafka.")
  useReliableProducer: boolean;

  @doc("Post process function that gets executed against messages generated by the query, just before being produced to Kafka.")
  postProcessFunction: string;

  @doc("Flag indicating if an async producer should be used when producing messages to Kafka.")
  useAsyncProducer: boolean;

  @doc("Flag determining if retries should be enabled for producer requests. If a request fails, it is retried.")
  useRetries: boolean;

  @doc("marker write interval in seconds")
  markerWriteIntervalInSeconds: int32;

  @doc("bond serializer path")
  bondSerializerPath: BondSerializerPath;

  @doc("Kafka  producer endpoint")
  endpoint: string;

  @doc("Kafka connection target string. This can be zonal or regional.")
  target: string;

  @doc("connection type")
  connectionType: string;

  @doc("Kafka topic name.")
  topic: string;

  @doc("Message schema. This can be json, proto, or bond.")
  schema: string;

  @doc("Use unsecure connection. If true, http is used instead of https.")
  useUnsecureConnection: boolean;

  @doc("Enable logging flag. Producer events will be logged if set to true.")
  enableLogging: boolean;

  @doc("Message format")
  format: string;
}

@doc("Cosmos reference source")
model CosmosReferenceSource {
  @doc("Cosmos input alias, which ")
  inputAlias: string;

  @doc("Refresh rate. This determines the frequency of reading data from CosmosDB.")
  refreshRate: string;

  @doc("CosmosDB SQL query to read reference data.")
  query: string;

  @doc("CosmosDB database name.")
  database: string;

  @doc("CosmosDB container name.")
  container: string;

  @doc("CosmosDB connection scheme. Either a connection string or managed by Dsms.")
  connectionScheme: TypeValue;

  @doc("Value indicating if bulk mode is enabled for write operation.")
  enableBulkMode: boolean;

  @doc("Preferred CosmosDB regions")
  preferredRegions: string[];

  @doc("Default time to live")
  defaultTimeToLive: int32;
}

@doc("Cosmos change feed source")
model CosmosChangeFeedSource {
  @doc("CosmosDB input alias in the job's SQL query.")
  inputAlias: string;

  @doc("CosmosDB lease container name.")
  leaseContainer: string;

  @doc("Input filter. This will filter out events consumed from CosmosDB by some predicate.")
  filter: string;

  @doc("CosmosDB database name.")
  database: string;

  @doc("CosmosDB container name.")
  container: string;

  @doc("CosmosDB connection scheme. This can be a connection string, or managed through Dsms.")
  connectionScheme: TypeValue;

  @doc("Value indicating if bulk mode is enabled for write operations.")
  enableBulkMode: boolean;

  @doc("Preferred CosmosDB regions to write to.")
  preferredRegions: string[];

  @doc("Default time to live of messages written to CosmosDB.")
  defaultTimeToLive: int32;
}

@doc("The properties of UserResource")
model JobDefinitionProperties {
  @doc("The GRIP job Id")
  jobId: string;

  @doc("Kafka input sources")
  kafkaSources: KafkaSource[];

  @doc("Cosmos reference input sources")
  cosmosReferenceSources: CosmosReferenceSource[];

  @doc("Cosmos change feed input sources")
  cosmosChangeFeedSources: CosmosChangeFeedSource[];

  @doc("Kafka output sources")
  kafkaOutputs: KafkaDestination[];

  @doc("Cosmos output sources")
  cosmosOutputs: CosmosDestination[];

  @doc("Flag determining if an output buffer is enabled. If true, messages generated by a query will be buffered before being produced.")
  outputBufferEnabled: boolean;

  @doc("Buffer size in bytes of all output sources in a job. This buffer stores messages that will be produced to CosmosDB.")
  bufferSize: int32;

  @doc("SQL Query string.")
  query: string;

  @doc("Number of streaming units. This determines the number of job partitions.")
  streamingUnits: int32;

  @doc("Disk storage configuration")
  diskStorageConfiguration: DiskStorageConfiguration;

  @doc("Trill configuration")
  trillConfiguration: TrillConfiguration;

  @doc("Inject fault interval in minutes. This will produce fault events in a job that will cause a job restart.")
  injectFaultInMins: int32;

  @doc("Enable ingress event logging flag")
  enableIngressEventLogging: boolean;

  @doc("Enable out of order event logging flag. Events that are consumed out of order will be logged.")
  enableOutOfOrderEventLogging: boolean;

  @doc("Data loss sensitivity setting. It can either be, 0 - None, 1 - Stateless, or 2 - Stateful.")
  dataLossSensitivity: int32;

  @doc("Checkpoint write interval. This is a timespan string of how often checkpoints are taken of a running job.")
  checkpointWriteInterval: string;

  @doc("Checkpoint write interval in milliseconds")
  checkpointWriteOperationWaitMs: int32;

  @doc("Log level. Values range from 0-7, where log level 0 will enable the most amount of logs. The higher the log level, the less logs that get generated within GRIP. Log levels should only be set to 0-2 for debugging purposes.")
  logLevel: int32;

  @doc("Yield output message processing flag. If true, this will yield each time a message is produced to Kafka. This is an experimental flag primarily used for performance testing.")
  yieldOutputMessageProcessing: boolean;

  @doc("Hosted functions runner count. This determines the amount of user defined functions that will be executed in GRIP when messages are being processed in the query.")
  hostedFunctionsRunnerCount: int32;

  @doc("Job tier. This determines memory/CPU limits")
  tier: int32;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

model JobDefinitionResource is ProxyResource<JobDefinitionProperties> {
  @doc("Job name")
  @pattern("^[a-zA-Z0-9-]{3,50}$")
  @key("jobName")
  @segment("jobs")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

/**
 * A resource GET operation
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
@autoRoute
@doc("Get a {name}", TResource)
@get
@armResourceRead(TResource)
op ArmLocResourceRead<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...LocationInstanceParameters<TResource>,
): ArmResponse<TResource> | ErrorResponse;

/**
 * A resource list operation, at the scope of the resource's parent
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 * @template TParentName Optional. The name of the parent resource
 * @template TParentFriendlyName Optional. The friendly name of the parent resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Operation Template types must use PascalCase"
@autoRoute
@get
@listsResource(TResource)
@segmentOf(TResource)
@armRenameListByOperation(TResource, TParentName, TParentFriendlyName) // This must come before @armResourceList!
@armResourceList(TResource)
op ArmLocResourceListByParent<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>,
  TParentName extends valueof string = "",
  TParentFriendlyName extends valueof string = ""
>(
  ...LocationCollectionParameters<TResource>,
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

/**
 * A resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmLocResourceCreateOrUpdateSync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...LocationInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  body: TResource,
): ArmResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

/**
 * Delete a resource synchronously
 * @template TResource The resource being deleted
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "Template"
@autoRoute
@doc("Delete a {name}", TResource)
@armResourceDelete(TResource)
@delete
op ArmLocResourceDeleteSync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...LocationInstanceParameters<TResource, TBaseParameters>,
): ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse;
