import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./mq.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/** ******************* */
/**
 * MQ datalakeconnectors resource type model details.
 *
 * Azure Resource - mq/dataLakeConnector
 * CRD - DataLakeConnector
 * CRD Version - v1alpha4
 */
@doc("MQ dataLakeConnector resource")
@parentResource(MqResource)
model DataLakeConnectorResource
  is TrackedResource<DataLakeConnectorProperties> {
  @doc("Name of MQ dataLakeConnector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dataLakeConnectorName")
  @path
  @segment("dataLakeConnector")
  name: string;

  ...ExtendedLocation;
}

@doc("MQ DataLakeConnector  Resource properties")
model DataLakeConnectorProperties {
  @doc("DataLake database format to use.")
  databaseFormat: DataLakeDatabaseFormat;

  @doc("The details of DataLakeConnector Docker Image.")
  image: ContainerImage;

  @doc("The number of DataLakeConnector pods to spin up.")
  @minValue(0)
  @maxValue(65535)
  instances?: int32;

  @doc("The details for connecting with Local Broker.")
  localBrokerConnection?: LocalBrokerConnectionSpec;

  @doc("The log level of the DataLake Connector instances.")
  logLevel?: string;

  @doc("The Node Tolerations for the DataLake Connector pods.")
  nodeTolerations?: NodeTolerations;

  @doc("The protocol to use for connecting with Brokers.")
  protocol: MqttProtocol;

  @doc("The protocol to use for connecting with Brokers. NOTE - Enum only storage is supported at at time.")
  target: DataLakeTargetStorage;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataLake possible database formats")
union DataLakeDatabaseFormat {
  string,

  @doc("Delta format.")
  "delta",

  @doc("Parquet format.")
  "parquet",
}

// GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
@doc("Target storage for the DataLake. NOTE - Enum only storage is supported at a time.")
model DataLakeTargetStorage {
  @doc("DataLake service storage details.")
  datalakeStorage?: DataLakeServiceStorage;

  @doc("Local storage details.")
  localStorage?: DataLakeLocalStorage;

  @doc("Fabric one lake storage details.")
  fabricOneLake?: DataLakeFabricStorage;
}

@doc("DataLake Service Storage details.")
model DataLakeServiceStorage {
  @doc("DataLake service storage endpoint to use.")
  endpoint: string;

  @doc("DataLake service storage authentication details. NOTE - Enum only one method is supported.")
  authentication: DataLakeServiceStorageAuthentication;
}

@doc("DataLake Service Storage authentication details. NOTE - Enum only one method is supported.")
model DataLakeServiceStorageAuthentication {
  @doc("Access token secret name.")
  accessTokenSecretName?: string;

  @doc("Configuration for managed identity authentication.")
  systemAssignedManagedIdentity?: ManagedIdentityAuthentication;
}

@doc("DataLake Local Storage details.")
model DataLakeLocalStorage {
  @doc("Volume name to write to.")
  volumeName: string;
}

// Add Fabric one lake storage details
@doc("DataLake Fabric Storage details.")
model DataLakeFabricStorage {
  @doc("DataLake fabric storage authentication details.")
  authentication: DataLakeFabricStorageAuthentication;

  @doc("DataLake fabric storage endpoint to use.")
  endpoint: string;

  @doc("Fabric path type to use.")
  fabricPath: FabricPathType;

  @doc("Fabric one lake Guids.")
  guids?: FabricGuids;

  @doc("Fabric one lake Names.")
  names?: FabricNames;
}

// Add Fabric one lake storage authentication details
@doc("DataLake Fabric Storage authentication details.")
model DataLakeFabricStorageAuthentication {
  @doc("Configuration for managed identity authentication.")
  systemAssignedManagedIdentity: ManagedIdentityAuthentication;
}

// Add Fabric path type
@doc("Fabric path type to use.")
union FabricPathType {
  string,

  @doc("Fabric path type is Files.")
  "files",

  @doc("Fabric path type is Tables.")
  "tables",
}

// Add Fabric one lake guids
@doc("Fabric one lake guids.")
model FabricGuids {
  @doc("Fabric one lake house guid.")
  lakehouseGuid: string;

  @doc("Fabric one lake workspace guid.")
  workspaceGuid: string;
}

// Add Fabric one lake names
@doc("Fabric one lake names.")
model FabricNames {
  @doc("Fabric one lake house name.")
  lakehouseName: string;

  @doc("Fabric one lake workspace name.")
  workspaceName: string;
}

/** ******************* */
/**
 * MQ dataLakeConnector/topicMap resource type model details.
 *
 * Azure Resource - mq/dataLakeConnector/topicMap
 * CRD - DataLakeTopicMap
 * CRD Version - v1alpha4
 */
@doc("MQ dataLakeConnector/topicMap resource")
@parentResource(DataLakeConnectorResource)
model DataLakeTopicMapResource
  is TrackedResource<DataLakeConnectorTopicMapProperties> {
  @doc("Name of MQ dataLakeConnector/topicMap resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("topicMapName")
  @path
  @segment("topicMap")
  name: string;

  ...ExtendedLocation;
}

@doc("MQ DataLakeConnector TopicMap Resource properties")
model DataLakeConnectorTopicMapProperties {
  @doc("DataLake Connector CRD to use.")
  dataLakeConnectorRef: string;

  @doc("TopicMap for DataLake connector.")
  mapping: DataLakeConnectorMap;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataLake connector map route properties")
model DataLakeConnectorMap {
  @doc("Allowed latency for transferring data.")
  @minValue(0)
  @maxValue(65535)
  allowedLatencySecs: int32;

  @doc("Client Id to use.")
  clientId: string;

  @doc("Maximum messages to send per Batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessagesPerBatch: int64;

  @doc("Message payload type.")
  messagePayloadType: string;

  @doc("Mqtt source topic.")
  mqttSourceTopic: string;

  @doc("Quality of Service.")
  @minValue(0)
  @maxValue(2)
  qos?: int32 = 1;

  @doc("Delta table properties to use.")
  table: DeltaTable;
}

@doc("Delta table properties")
model DeltaTable {
  @doc("Schema list supported.")
  @identifiers(#[])
  schema: DeltaTableSchema[];

  @doc("Delta table name.")
  tableName: string;

  @doc("Delta table path.")
  tablePath?: string;
}

@doc("Delta table schema properties")
model DeltaTableSchema {
  @doc("Delta table format supported.")
  format: DeltaTableFormatEnum;

  @doc("Delta table schema mapping.")
  mapping: string;

  @doc("Delta table schema name.")
  name: string;

  @doc("Delta table schema optional.")
  optional: boolean;
}

@doc("Delta table format properties")
union DeltaTableFormatEnum {
  string,

  @doc("Bool format")
  "boolean",

  @doc("Signed integer 8")
  "int8",

  @doc("Signed integer 16")
  "int16",

  @doc("Signed integer 32")
  "int32",

  @doc("Unsigned integer 8")
  "uInt8",

  @doc("Unsigned integer 16")
  "uInt16",

  @doc("Unsigned integer 32")
  "uInt32",

  @doc("Unsigned integer 64")
  "uInt64",

  @doc("Float 16")
  "float16",

  @doc("Float 32")
  "float32",

  @doc("Float 64")
  "float64",

  @doc("Date 32")
  "date32",

  @doc("Date 64")
  "date64",

  @doc("Binary data")
  "binary",

  @doc("UTF8 format")
  "utf8",
}
