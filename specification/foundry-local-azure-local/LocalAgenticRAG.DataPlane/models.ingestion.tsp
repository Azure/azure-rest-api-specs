import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace FoundryLocal.AgenticRAG;

// ──── Ingestion enums ────

/** The kind of data source for ingestion. */
union IngestionDatasourceKind {
  string,

  /** An NFS v3 file share data source. */
  nfsv3: "nfsv3",

  /** A SharePoint data source. */
  sharepoint: "sharepoint",
}

/** The document parsing mode for ingestion. */
union ParsingMode {
  string,

  /** Basic parsing mode. */
  basic: "basic",

  /** Advanced parsing mode with enhanced document understanding. */
  advanced: "advanced",
}

/** The status of an ingestion job. */
union IngestionJobStatus {
  string,

  /** The job is pending execution. */
  PENDING: "PENDING",

  /** The job is currently running. */
  RUNNING: "RUNNING",

  /** The job completed successfully. */
  COMPLETED: "COMPLETED",

  /** The job failed. */
  FAILED: "FAILED",
}

// ──── Ingestion models ────

/** Request body for creating an ingestion job. */
model CreateIngestionRequest {
  /** The data source configuration for ingestion. */
  datasource: IngestionDatasource;

  /** Target collection name. Must exist. */
  collectionName?: string = "edgeragapp";

  /** -1 = one-time, 1/4/24 = recurring. */
  dataRefreshIntervalInHours?: int32 = -1;

  /** The parsing mode to use for document processing. */
  parsingMode?: ParsingMode = ParsingMode.basic;

  /** Whether to exclude LGR failure updates. */
  excludeLgrFailureUpdate?: boolean;
}

/** Data source configuration for an ingestion job. */
model IngestionDatasource {
  /** The kind of data source. */
  kind: IngestionDatasourceKind;

  /** Connection details for the data source. */
  connection?: IngestionDatasourceConnection;

  /** Chunking configuration for document processing. */
  chunking: ChunkingConfig;
}

/** Connection details for an ingestion data source. */
model IngestionDatasourceConnection {
  /** NFS server path (server_ip:/path). Required when kind is nfsv3. */
  nfsServerPath?: string;

  /** The NFS user identifier. */
  nfsUid?: int32;

  /** The NFS group identifier. */
  nfsGid?: int32;

  /** SharePoint site URL. Required when kind is sharepoint. */
  sharePointUrl?: string;

  /** The folder path within the SharePoint site. */
  sharePointFolderPath?: string;

  /** Format: DOMAIN\\username */
  sharePointUsername?: string;

  /** RSA-encrypted base64-encoded password. */
  @secret
  sharePointPassword?: string;
}

/** Configuration for document chunking during ingestion. */
model ChunkingConfig {
  /** Chunk size in characters. Must be a string. */
  chunkSize: string;

  /** Overlap between chunks. Must be a string. */
  chunkOverlap: string;
}

/** Response returned after creating an ingestion job. */
model IngestionCreateResponse {
  /** The status of the ingestion job creation. */
  status?: string;

  /** Additional details about the ingestion job creation. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Message payload structure varies by ingestion type"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Message payload structure varies by ingestion type"
  message?: Record<unknown>;
}

/** A list of ingestion job runs. */
model IngestionJobList {
  /** The list of ingestion job runs. */
  jobRuns?: IngestionJobRun[];
}

/** Represents an ingestion job run. */
model IngestionJobRun {
  /** The identifier of the ingestion job. */
  jobId?: string;

  /** The identifier of the run. */
  runId?: string;

  /** The current status of the job run. */
  status?: IngestionJobStatus;

  /** The timestamp when the run started. */
  startTime?: utcDateTime;

  /** The timestamp when the run ended. */
  endTime?: utcDateTime;

  /** The identifier of the user who created the job. */
  createdBy?: string;

  /** The name of the target collection. */
  collectionName?: string;
}

/** Detailed information about an ingestion run. */
model IngestionRunDetail {
  /** The identifier of the ingestion job. */
  jobId?: string;

  /** The identifier of the run. */
  runId?: string;

  /** The current status of the run. */
  status?: IngestionJobStatus;

  /** The total number of items to process. */
  totalItems?: int32;

  /** The number of items that have been processed. */
  processedItems?: int32;

  /** The number of items that failed processing. */
  failedItems?: int32;

  /** Error details if the run failed. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Error info structure varies by failure type"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Error info structure varies by failure type"
  errorInfo?: Record<unknown>;
}
