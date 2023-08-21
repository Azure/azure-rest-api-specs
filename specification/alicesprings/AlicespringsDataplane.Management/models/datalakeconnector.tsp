import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./e4k.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.AlicespringsDataplane;

/** ******************* */
/**
 * E4K datalakeconnectors resource type model details.
 *
 * Azure Resource - e4k/datalakeconnector
 * CRD - datalakeconnectors
 * CRD Version - v1alpha2
 */
@doc("E4K dataLakeConnector resource")
@parentResource(E4kResource)
model DatalakeConnectorResource
  is TrackedResource<DatalakeConnectorProperties> {
  @doc("Name of E4K dataLakeConnector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dataLakeConnectorName")
  @path
  @segment("dataLakeConnector")
  name: string;

  ...ExtendedLocation;
}

@doc("E4k DatalakeConnector  Resource properties")
model DatalakeConnectorProperties {
  @doc("Datalake database format to use.")
  databaseFormat: DatalakeDatabaseFormat;

  @doc("The details of DatalakeConnector Docker Image.")
  image: ContainerImage;

  @doc("The number of DatalakeConnector pods to spin up.")
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

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Datalake possible database formats")
enum DatalakeDatabaseFormat {
  @doc("Delta format.")
  delta,

  @doc("Parquet format.")
  parquet,
}

// GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
@doc("Target storage for the Datalake. NOTE - Enum only storage is supported at a time.")
model DataLakeTargetStorage {
  @doc("Datalake service storage details.")
  datalakeStorage?: DataLakeServiceStorage;

  @doc("Local storage details.")
  localStorage?: DataLakeLocalStorage;
}

@doc("DataLake Service Storage details.")
model DataLakeServiceStorage {
  @doc("Datalake service storage endpoint to use.")
  endpoint: string;

  @doc("Datalake service storage authentication details. NOTE - Enum only one method is supported.")
  authentication: DataLakeServiceStorageAuthentication;
}

@doc("DataLake Service Storage authentication details. NOTE - Enum only one method is supported.")
model DataLakeServiceStorageAuthentication {
  @doc("Access token secret name.")
  accessTokenSecretName?: string;

  @doc("MSI to connect to service.")
  managedIdentity?: boolean;
}

@doc("DataLake Local Storage details.")
model DataLakeLocalStorage {
  @doc("Volume name to write to.")
  volumeName: string;
}

/** ******************* */
/**
 * E4K datalakeconnectors/topicmap resource type model details.
 *
 * Azure Resource - e4k/datalakeconnector/topicmap
 * CRD - datalakeconnectortopicmaps
 * CRD Version - v1alpha2
 */
@doc("E4K dataLakeConnector/topicMap resource")
@parentResource(DatalakeConnectorResource)
model DatalakeConnectorTopicMapResource
  is TrackedResource<DatalakeConnectorTopicMapProperties> {
  @doc("Name of E4K dataLakeConnector/topicMap resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("topicMapName")
  @path
  @segment("topicMap")
  name: string;

  ...ExtendedLocation;
}

@doc("E4k DatalakeConnector TopicMap Resource properties")
model DatalakeConnectorTopicMapProperties {
  @doc("DataLake Connector CRD to use.")
  dataLakeConnectorRef: string;

  @doc("TopicMap for DataLake connector.")
  mapping: DataLakeConnectorMap;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataLake connector map route properties")
model DataLakeConnectorMap {
  @doc("Allowed latency for transferring data.")
  @minValue(0)
  @maxValue(65535)
  allowedLatency: int32;

  @doc("Client Id to use.")
  clientId: string;

  @doc("Delta table properties to use.")
  deltaTable: DeltaTable;

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
}

@doc("Delta table properties")
model DeltaTable {
  @doc("Schema list supported.")
  @OpenAPI.extension("x-ms-identifiers", [])
  schema: DeltaTableSchema[];

  @doc("Delta table name.")
  tableName: string;
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
enum DeltaTableFormatEnum {
  @doc("Bool format")
  boolean,

  @doc("Signed integer 8")
  int8,

  @doc("Signed integer 16")
  int16,

  @doc("Signed integer 32")
  int32,

  @doc("Unsigned integer 8")
  uInt8,

  @doc("Unsigned integer 16")
  uInt16,

  @doc("Unsigned integer 32")
  uInt32,

  @doc("Unsigned integer 64")
  uInt64,

  @doc("Float 16")
  float16,

  @doc("Float 32")
  float32,

  @doc("Float 64")
  float64,

  @doc("Date 32")
  date32,

  @doc("Date 64")
  date64,

  @doc("Binary data")
  binary,

  @doc("UTF8 format")
  utf8,
}
