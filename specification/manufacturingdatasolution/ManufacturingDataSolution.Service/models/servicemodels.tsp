import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "./common.tsp";

using Azure.Core;
using MdsCommon;
using TypeSpec.Rest;

namespace ServiceModels;

@doc("Represents the health status of the MDS.")
model MdsHealth {
  @doc("The identifier for the health status.")
  id: string;

  @doc("The version of the health status.")
  version: int32;

  @doc("The message associated with the health status.")
  message?: string;

  @doc("The setup status of the MDS.")
  setupStatus: OperationStatus;

  @doc("The setup information of the MDS.")
  setupInfo: MdsHealthSetupInfo;

  @doc("The error messages associated with the health status.")
  errorMessage?: string[];
}

@doc("Represents the setup information of the MDS health status.")
model MdsHealthSetupInfo {
  @doc("The status of the entity registration.")
  registerEntityStatus: OperationStatus;

  @doc("The status of the data version.")
  dataVersionStatus: OperationStatus;

  @doc("The status of the vectorization table creation.")
  vectorizationTableCreationStatus: OperationStatus;

  @doc("The status of the ADX table creation.")
  adxTableCreationStatus: OperationStatus;

  @doc("The status of the ADX functions creation.")
  adxFunctionsCreationStatus: OperationStatus;
}

@doc("Represents a mappings table model.")
@resource("normalizationTable")
model NormalizationTable {
  @doc("The name of the normalizationTable.")
  @key
  @visibility(Lifecycle.Read, Lifecycle.Update)
  name: string;

  @doc("The version of the table.")
  @visibility(Lifecycle.Read)
  version: string = "";

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" ""
  @doc("The mapping table records.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  normalizationRecords: NormalizationTableRecord[];

  @doc("The available versions of the table.")
  @visibility(Lifecycle.Read)
  availableVersions?: Record<string>;
}

@doc("Represents a record in the normalization table.")
model NormalizationTableRecord {
  @doc("The name of the property.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  key: string;

  @doc("The value of the property.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  value: string = "";

  @doc("Flag indicating if used in Ingestion")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  usedInIngestion: boolean = false;
}

@doc("Represents a response model for OPC UA mapping.")
@resource("opcuamapping")
model OpcuaMappingModel {
  @doc("The name of the entity.")
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create)
  entityName: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Mapping Data")
  mappingData: OpcuaMappingData[];

  @doc("The target entity for the response.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetEntity?: string;

  @doc("Indicates if related nodes were updated.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  updateRelatedNode: boolean;

  @doc("The type of relationship for the response.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  relationshipType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
model OpcuaMappingData {
  @doc("The DMM keys for the response.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dmmKeys: [];

  @doc("The OPC UA name for the response.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  opcuaName: string;
}

/**
 * Represents the status response of an entity update job.
 */
model UpdateEntityJobStatusResponse {
  /**
   * The status of the job to delete ADX properties.
   */
  deleteAdxPropertiesJobStatus?: string;

  /**
   * The status of the job to delete ADX relationships.
   */
  deleteAdxRelationshipsJobStatus?: string;

  /**
   * The final status of the entity update job.
   */
  finalEntityStatus?: JobStatus;
}

@doc("Represents the status response of a job.")
@resource("entity/status")
model JobStatusResponse {
  @key
  @doc("The identifier of the job.")
  @visibility(Lifecycle.Read)
  jobId: string;

  @doc("The type of the job.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("The message of the job status.")
  message?: UpdateEntityJobStatusResponse;

  @doc("The URL of the resource location.")
  resourceLocationUrl?: string;

  @doc("The date and time when the resource was created.")
  createdDateTime?: utcDateTime;

  @doc("The final status of the job.")
  @lroResult
  status: JobStatus;
}

@doc("Represents storage information.")
model StorageInfo {
  @doc("The default data store.")
  defaultStore: DataStore;

  @doc("The ADT model ID.")
  adtModelId?: string;

  @doc("The ADX table name.")
  adxTableName?: string;
}

@doc("Represents a base column.")
model BaseColumn {
  @doc("The name of the column.")
  name: string;

  @doc("The mapping table used for normalization.")
  mappingTableForNormalization: string = "";

  @doc("Indicates if the column is a proper noun.")
  isProperNoun?: boolean;
}

@doc("Represents a column in an entity.")
model Column is BaseColumn {
  @doc("The display name of the column.")
  displayName?: string;

  @doc("The description of the column.")
  description?: string;

  @doc("The data type of the column.")
  type: SupportedDatatypes;

  @doc("Indicates if the column is mandatory.")
  mandatory: boolean;

  @doc("Indicates if the column is semantically relevant.")
  semanticRelevantFlag: boolean;

  @doc("Indicates if the column is a primary key.")
  primaryKey: boolean;

  @doc("Indicates if the column is used for grouping.")
  groupBy: boolean;

  @doc("The enumeration values for the column, if applicable.")
  enumValues?: string[];
}

@doc("Represents a data store.")
union DataStore {
  @doc("ADX data store.")
  ADX: "ADX",

  @doc("Cosmos data store.")
  Cosmos: "Cosmos",

  @doc("Blob data store.")
  Blob: "Blob",

  @doc("Any other data store.")
  string,
}

@doc("Represents data sampling rates.")
union DataSamplingRate {
  @doc("Undefined sampling rate.")
  Undefined: "Undefined",

  @doc("Milliseconds sampling rate.")
  MilliSeconds: "MilliSeconds",

  @doc("Seconds sampling rate.")
  Seconds: "Seconds",

  @doc("Minutes sampling rate.")
  Minutes: "Minutes",

  @doc("Hours sampling rate.")
  Hours: "Hours",

  @doc("Any other sampling rate.")
  string,
}

@doc("Represents the type of an entity.")
union EntityDataType {
  @doc("Undefined entity type.")
  Undefined: "Undefined",

  @doc("Reference entity type.")
  Reference: "Reference",

  @doc("Operational entity type.")
  Operational: "Operational",

  @doc("Any other entity type.")
  string,
}

@doc("Represents the format used for ingestion.")
union IngestionFormat {
  @doc("Undefined ingestion format.")
  Undefined: "Undefined",

  @doc("Batch ingestion format.")
  Batch: "Batch",

  @doc("Stream ingestion format.")
  Stream: "Stream",

  @doc("Any other ingestion format.")
  string,
}

@doc("Represents the rate at which data is ingested.")
union IngestionRate {
  @doc("Undefined ingestion rate.")
  Undefined: "Undefined",

  @doc("Ingestion rate in minutes.")
  Minutes: "Minutes",

  @doc("Ingestion rate hourly.")
  Hourly: "Hourly",

  @doc("Ingestion rate daily.")
  Daily: "Daily",

  @doc("Ingestion rate weekly.")
  Weekly: "Weekly",

  @doc("Ingestion rate monthly.")
  Monthly: "Monthly",

  @doc("Any other ingestion rate.")
  string,
}

@doc("Represents storage types.")
union StorageType {
  @doc("Undefined storage type.")
  Undefined: "Undefined",

  @doc("Hot storage type.")
  Hot: "Hot",

  @doc("Warm storage type.")
  Warm: "Warm",

  @doc("Cold storage type.")
  Cold: "Cold",

  @doc("Any other storage type.")
  string,
}

@doc("Represents metadata associated with an entity.")
model EntityMetadata {
  @doc("The type of the entity.")
  entityDataType?: EntityDataType;

  @doc("The format used for ingestion.")
  ingestionFormat?: IngestionFormat;

  @doc("The rate at which data is ingested.")
  ingestionRate?: IngestionRate;

  @doc("The type of storage used.")
  storageType?: StorageType;

  @doc("The rate at which data is sampled.")
  dataSamplingRate?: DataSamplingRate;
}

@resource("entity")
@doc("Represents an entity basic information.")
model EntityInfo {
  @doc("The name of the entity.")
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("The columns associated with the entity.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  columns?: Column[];
}

@doc("Represents an entity in the MDS.")
model Entity is EntityInfo {
  @doc("The identifier for the entity.")
  id?: string;

  @doc("The version of the entity.")
  version: int32 = 1;

  @doc("Indicates if the entity is the default entity.")
  isDefault: boolean;

  @doc("The metadata tags associated with the entity.")
  tags: EntityMetadata;

  @doc("The URL of the DTDL schema.")
  dtdlSchemaUrl?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Represents Json object"
  @doc("The DTDL schema of the entity.")
  dtdlSchema?: Record<string>;

  @doc("Indicates if the entity is a base entity.")
  isBaseEntity?: boolean;

  @doc("The storage information of the entity.")
  storageInfo: StorageInfo;

  @doc("Indicates if the entity is semantically relevant.")
  semanticRelevantFlag: boolean;
}

@doc("Represents supported data types.")
union SupportedDatatypes {
  @doc("String data type.")
  String: "String",

  @doc("Integer data type.")
  Integer: "Integer",

  @doc("Double data type.")
  Double: "Double",

  @doc("Enum data type.")
  Enum: "Enum",

  @doc("Alphanumeric data type.")
  Alphanumeric: "Alphanumeric",

  @doc("URI reference data type.")
  URIreference: "URIreference",

  @doc("DateTime data type.")
  DateTime: "DateTime",

  @doc("Dynamic data type.")
  Dynamic: "Dynamic",

  @doc("Any other data type.")
  string,
}

@doc("Represents the status of an operation.")
union OperationStatus {
  @doc("Operation accepted.")
  Accepted: "Accepted",

  @doc("Operation in progress.")
  InProgress: "InProgress",

  @doc("Operation encountered a transient failure.")
  TransientFailure: "TransientFailure",

  @doc("Operation succeeded.")
  Succeeded: "Succeeded",

  @doc("Operation failed.")
  Failed: "Failed",

  @doc("Operation is being deleted.")
  Deleting: "Deleting",

  @doc("Operation canceled.")
  Canceled: "Canceled",

  @doc("Operation status unknown.")
  Unknown: "Unknown",

  @doc("Operation skipped.")
  Skipped: "Skipped",

  @doc("Any other operation status.")
  string,
}
