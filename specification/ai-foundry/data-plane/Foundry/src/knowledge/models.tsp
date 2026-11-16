import "../common/service.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const KnowledgeRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.knowledge_v1_preview],
};

/** A project model deployment and its actual backing model name. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeBaseModelReference {
  /** The deployment name in the current Foundry project. */
  deploymentName: string;

  /** The actual model name, which can differ from the deployment name. */
  modelName: string;
}

/** A reusable knowledge source referenced by a knowledge base. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceReference {
  /** The source name in the current project. */
  name: string;

  /** Whether extracted images can be served during retrieval. */
  enableImageServing?: boolean;

  /** Whether freshness-aware retrieval is enabled for this source. */
  enableFreshness?: boolean;
}

/** The output produced when the knowledge base is used for retrieval. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
union KnowledgeRetrievalOutputMode {
  string,

  /** Return source content without answer synthesis. */
  extractiveData: "extractiveData",

  /** Synthesize an answer from the source content. */
  answerSynthesis: "answerSynthesis",
}

/** Retrieval reasoning settings. */
@discriminator("kind")
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeRetrievalReasoningEffort {
  /** The reasoning effort kind. */
  kind: string;
}

/** Retrieve without query planning or source selection. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeRetrievalMinimalReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The reasoning effort kind. */
  kind: "minimal";
}

/** Retrieve with low reasoning effort. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeRetrievalLowReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The reasoning effort kind. */
  kind: "low";
}

/** Retrieve with medium reasoning effort. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeRetrievalMediumReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The reasoning effort kind. */
  kind: "medium";
}

/** Cross-origin access settings for the knowledge base. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeBaseCorsConfig {
  /** Origins allowed to access the knowledge base. */
  allowedOrigins: string[];

  /** The duration, in seconds, for which a preflight response can be cached. */
  maxAgeInSeconds?: int64;
}

/** A project-scoped knowledge-base definition. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeBase {
  /** The name of the knowledge base in the current project. */
  name: string;

  /** A description of the knowledge base. */
  description?: string | null;

  /** Sources to use when the knowledge base is queried. */
  knowledgeSources: KnowledgeSourceReference[];

  /** Model/deployment pairs used for retrieval planning and synthesis. */
  models?: KnowledgeBaseModelReference[];

  /** The retrieval output mode. */
  outputMode?: KnowledgeRetrievalOutputMode;

  /** Instructions used for retrieval. */
  retrievalInstructions?: string | null;

  /** Instructions used for answer synthesis. */
  answerInstructions?: string | null;

  /** Retrieval reasoning settings. */
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;

  /** Cross-origin access settings. */
  corsOptions?: KnowledgeBaseCorsConfig;

  /** The saved definition's concurrency token. Pass it through If-Match, not the request body. */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "@odata.etag")
  etag?: string;
}

/** Source kinds exposed by the baseline managed Knowledge experience. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
union KnowledgeSourceKind {
  string,

  /** Files uploaded to a managed source. */
  file: "file",

  /** Content ingested from an Azure Blob connection. */
  azureBlob: "azureBlob",

  /** Content retrieved from the web. */
  web: "web",
}

/** A reusable, project-scoped knowledge source. */
@discriminator("kind")
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSource {
  ...Record<unknown>;

  /** The source name in the current project. */
  name: string;

  /** The source kind. Unknown kinds can be returned without enabling their creation. */
  kind: KnowledgeSourceKind;

  /** A description of the knowledge source. */
  description?: string | null;
}

/** A source summary returned by the managed list operation. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceListItem {
  ...Record<unknown>;

  /** The source name in the current project. */
  name: string;

  /** The source kind. */
  kind: KnowledgeSourceKind;

  /** A description of the source. */
  description?: string | null;
}

/** Files uploaded to managed storage for ingestion. Upload acceptance is not retrieval readiness. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model FileKnowledgeSource extends KnowledgeSource {
  /** The source kind. */
  kind: KnowledgeSourceKind.file;

  /** The project embedding deployment name, not the backing model name. */
  embeddingModelName: string;

  /** The content extraction mode used during file ingestion. */
  contentExtractionMode?: string | null;

  /** Metadata for the currently embedded page of files. */
  @visibility(Lifecycle.Read)
  files?: KnowledgeSourceFile[];

  /** Continuation for an embedded file page. Use the source's file-list operation for full iteration. */
  @visibility(Lifecycle.Read)
  filesNextLink?: url;
}

/** An Azure Blob source using an explicitly provisioned project connection. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSource extends KnowledgeSource {
  /** The source kind. */
  kind: KnowledgeSourceKind.azureBlob;

  /** Storage location and ingestion settings. */
  azureBlobParameters: AzureBlobKnowledgeSourceParameters;
}

/** Managed Blob location settings. Credentials, identities and backing Search endpoints are not exposed. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceParameters {
  /** Project connection name or ID. Required on creation; omit on update to retain the saved connection. Never returned on reads. */
  projectConnectionId?: string;

  /** The Blob container to ingest. */
  containerName: string;

  /** An optional path prefix within the container. */
  folderPath?: string | null;

  /** Whether the source uses ADLS Gen2 semantics. */
  isADLSGen2?: boolean;

  /** Source-specific ingestion settings. */
  ingestionParameters?: AzureBlobKnowledgeSourceIngestionParameters | null;
}

/** Deployment/model pairs and content extraction settings for managed Blob ingestion. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceIngestionParameters {
  /** The content extraction mode. */
  contentExtractionMode?: string | null;

  /** The project embedding deployment name. */
  embeddingModel?: string | null;

  /** The actual backing model name for the embedding deployment. */
  embeddingModelName?: string | null;

  /** The project chat completion deployment name. */
  chatCompletionModel?: string | null;

  /** The actual backing model name for the chat completion deployment. */
  chatCompletionModelName?: string | null;
}

/** A managed web knowledge source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSource extends KnowledgeSource {
  /** The source kind. */
  kind: KnowledgeSourceKind.web;

  /** Web domain configuration. */
  webParameters?: WebKnowledgeSourceParameters;
}

/** Parameters that control the domains used for web retrieval. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceParameters {
  /** Domain allow and block configuration. */
  domains?: WebKnowledgeSourceDomains;
}

/** Domain allow and block configuration. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceDomains {
  /** Domains allowed in web results. */
  allowedDomains?: WebKnowledgeSourceDomain[];

  /** Domains blocked from web results. */
  blockedDomains?: WebKnowledgeSourceDomain[];
}

/** A domain used by a web knowledge source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceDomain {
  /** The domain address. */
  address: string;

  /** Whether subpages of the domain can be returned. */
  includeSubpages?: boolean;
}

/** Mutable source fields accepted by the existing named POST update operation. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceUpdate {
  /** The source name, when supplied. Must match the route name. */
  name?: string;

  /** The source kind, when supplied. Must match the saved kind. */
  kind?: KnowledgeSourceKind;

  /** The source description. */
  description?: string | null;

  /** File embedding deployment, when supplied. Must match the saved value. */
  embeddingModelName?: string;

  /** The content extraction mode used during file ingestion. */
  contentExtractionMode?: string | null;

  /** Blob location and ingestion settings. */
  azureBlobParameters?: AzureBlobKnowledgeSourceParameters;

  /** Web domain settings. */
  webParameters?: WebKnowledgeSourceParameters;
}

/** Public metadata for an uploaded file. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceFile {
  /** The returned file identifier used for deletion. */
  fileId?: string;

  /** The original file name. */
  fileName: string;

  /** The file size, in bytes. */
  fileSizeBytes?: int64;

  /** When the file was created. */
  createdAt?: utcDateTime;

  /** When the file was last updated. */
  lastUpdatedAt?: utcDateTime;

  /** Processing failure information. A successful upload can still include this field. */
  errorMessage?: string | null;

  /** The directory-like prefix derived from the file name. */
  prefix?: string;

  /** Custom file metadata. */
  metadata?: Record<string>;

  /** The parsing mode applied to the file. */
  parsingMode?: string;

  /** The extraction mode applied to the file. */
  extractionMode?: string;
}

/** Existing Search synchronization diagnostics, not a per-upload readiness guarantee. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceStatus {
  ...Record<unknown>;

  /** The source kind, when supplied by the selected Search version. */
  kind?: KnowledgeSourceKind;

  /** Source provisioning/synchronization status. Active does not mean a specific upload is searchable. */
  synchronizationStatus?: string;

  /** The synchronization interval, when configured. */
  synchronizationInterval?: string | null;

  /** Diagnostics for the current synchronization run. */
  currentSynchronizationState?: KnowledgeSourceSynchronizationState | null;

  /** Diagnostics for the last completed synchronization run. */
  lastSynchronizationState?:
    | KnowledgeSourceCompletedSynchronizationState
    | null;

  /** Source-specific synchronization statistics. */
  statistics?: KnowledgeSourceStatistics | null;
}

/** Diagnostics for an ongoing synchronization run. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceSynchronizationState {
  /** The synchronization start time. */
  startTime: utcDateTime;

  /** The number of successfully processed updates. */
  itemsUpdatesProcessed: int32;

  /** The number of failed updates. */
  itemsUpdatesFailed: int32;

  /** The number of skipped items. */
  itemsSkipped: int32;

  /** Document-level errors returned for this run. */
  errors?: KnowledgeSourceSynchronizationError[];
}

/** Diagnostics for a completed synchronization run. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceCompletedSynchronizationState {
  /** The synchronization start time. */
  startTime: utcDateTime;

  /** The synchronization end time. */
  endTime: utcDateTime;

  /** The number of successfully processed updates. */
  itemsUpdatesProcessed: int32;

  /** The number of failed updates. */
  itemsUpdatesFailed: int32;

  /** The number of skipped items. */
  itemsSkipped: int32;
}

/** A document-level synchronization error. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceSynchronizationError {
  /** The failed document identifier. */
  docId?: string;

  /** The failure category expressed as an HTTP-like status code. */
  statusCode?: int32;

  /** The component reporting the error. */
  name?: string;

  /** Customer-visible failure information. */
  errorMessage: string;

  /** Additional failure details. */
  details?: string;

  /** Troubleshooting documentation supplied by the service. */
  documentationLink?: string;
}

/** Historical source synchronization statistics. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceStatistics {
  /** The number of synchronizations. */
  totalSynchronization: int32;

  /** Average synchronization duration, in HH:MM:SS format. */
  averageSynchronizationDuration: string;

  /** Average processed items per synchronization. */
  averageItemsProcessedPerSynchronization: int32;
}

/** One server-driven page of managed Knowledge resources. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeListResult<T> {
  /** The resources in the current page. */
  @pageItems
  value: T[];

  /** An opaque, project-scoped URL for the next page. */
  @nextLink
  @encodedName("application/json", "@odata.nextLink")
  nextLink?: url;
}

alias KnowledgeListParameters = {
  /** The requested page size. The service can return fewer items. */
  @query
  @pageSize
  @minValue(1)
  @maxValue(3000)
  pageSize?: int32;

  /** Filter resources by name. */
  @query
  search?: string;

  /** Name matching mode supported by the selected service version. */
  @query
  searchType?: string;
};
