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
  deployment_name: string;

  /** The actual model name, which can differ from the deployment name. */
  model_name: string;
}

/** A reusable knowledge source referenced by a knowledge base. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceReference {
  /** The source name in the current project. */
  name: string;

  /** Whether extracted images can be served during retrieval. */
  enable_image_serving?: boolean;

  /** Whether freshness-aware retrieval is enabled for this source. */
  enable_freshness?: boolean;
}

/** The output produced when the knowledge base is used for retrieval. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
union KnowledgeRetrievalOutputMode {
  string,

  /** Return source content without answer synthesis. */
  extractive_data: "extractive_data",

  /** Synthesize an answer from the source content. */
  answer_synthesis: "answer_synthesis",
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
  allowed_origins: string[];

  /** The duration, in seconds, for which a preflight response can be cached. */
  max_age_in_seconds?: int64;
}

/** A project-scoped knowledge-base definition. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeBase {
  /** The name of the knowledge base in the current project. */
  name: string;

  /** A description of the knowledge base. */
  description?: string | null;

  /** Sources to use when the knowledge base is queried. */
  knowledge_sources: KnowledgeSourceReference[];

  /** Model/deployment pairs used for retrieval planning and synthesis. */
  models?: KnowledgeBaseModelReference[];

  /** The retrieval output mode. If omitted, the service returns extracted source content without answer synthesis. */
  output_mode?: KnowledgeRetrievalOutputMode;

  /** Instructions used for retrieval. */
  retrieval_instructions?: string | null;

  /** Instructions used for answer synthesis. */
  answer_instructions?: string | null;

  /** Retrieval reasoning settings. If omitted, the backing retrieval service selects its default for the enabled feature set. Set this explicitly for predictable planning behavior. */
  retrieval_reasoning_effort?: KnowledgeRetrievalReasoningEffort;

  /** Cross-origin access settings. */
  cors_options?: KnowledgeBaseCorsConfig;

  /** The saved definition's concurrency token. Pass it through If-Match, not the request body. */
  @visibility(Lifecycle.Read)
  etag?: string;
}

/** Source kinds exposed by the baseline managed Knowledge experience. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
union KnowledgeSourceKind {
  string,

  /** Files uploaded to a managed source. */
  file: "file",

  /** Content ingested from an Azure Blob connection. */
  azure_blob: "azure_blob",

  /** Content retrieved from the web. */
  web: "web",
}

/** A reusable, project-scoped knowledge source with explicitly modeled configuration. */
@discriminator("kind")
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSource {
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
  embedding_model_name: string;

  /** The content extraction mode used during file ingestion. */
  content_extraction_mode?: string | null;

  /** Metadata for the currently embedded page of files. */
  @visibility(Lifecycle.Read)
  files?: KnowledgeSourceFile[];

  /** Continuation for an embedded file page. Use the source's file-list operation for full iteration. */
  @visibility(Lifecycle.Read)
  files_next_link?: url;
}

/** An Azure Blob source using an explicitly provisioned project connection. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSource extends KnowledgeSource {
  /** The source kind. */
  kind: KnowledgeSourceKind.azure_blob;

  /** Storage location and ingestion settings. */
  azure_blob_parameters: AzureBlobKnowledgeSourceParameters;
}

/** Source definitions accepted when creating a File, Blob, or Web source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceCreate is KnowledgeSource;

/** A File source being created with its embedding deployment. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model FileKnowledgeSourceCreate extends KnowledgeSourceCreate {
  /** The source kind. */
  kind: KnowledgeSourceKind.file;

  /** The project embedding deployment name, not the backing model name. */
  embedding_model_name: string;

  /** The content extraction mode used during file ingestion. */
  content_extraction_mode?: string | null;
}

/** An Azure Blob source being created with its required project connection. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceCreate extends KnowledgeSourceCreate {
  /** The source kind. */
  kind: KnowledgeSourceKind.azure_blob;

  /** Storage location and the project connection used for ingestion. */
  azure_blob_parameters: AzureBlobKnowledgeSourceCreateParameters;
}

/** A Web source being created with optional domain settings. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceCreate extends KnowledgeSourceCreate {
  /** The source kind. */
  kind: KnowledgeSourceKind.web;

  /** Web domain configuration. Omit or supply an empty object to apply no domain allow/block restrictions. */
  web_parameters?: WebKnowledgeSourceParameters;
}

/** Managed Blob location settings. Credentials, identities and backing Search endpoints are not exposed. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceParameters {
  /** The Blob container to ingest. */
  container_name: string;

  /** An optional path prefix within the container. */
  folder_path?: string | null;

  /** Whether the source uses ADLS Gen2 semantics. */
  is_adls_gen2?: boolean;

  /** Source-specific ingestion settings. */
  ingestion_parameters?: AzureBlobKnowledgeSourceIngestionParameters | null;
}

/** Blob location settings required when creating a source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceCreateParameters
  is AzureBlobKnowledgeSourceParameters {
  /** The project connection name used to access the Blob container, not an ARM resource ID. */
  project_connection_id: string;
}

/** Blob location settings accepted on a named source update. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceUpdateParameters
  is AzureBlobKnowledgeSourceParameters {
  /** The project connection name; omit to retain the saved connection. Never use an ARM resource ID. */
  project_connection_id?: string;
}

/** Deployment/model pairs and content extraction settings for managed Blob ingestion. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model AzureBlobKnowledgeSourceIngestionParameters {
  /** The content extraction mode. */
  content_extraction_mode?: string | null;

  /** The project embedding deployment name. */
  embedding_model?: string | null;

  /** The actual backing model name for the embedding deployment. */
  embedding_model_name?: string | null;

  /** The project chat completion deployment name. */
  chat_completion_model?: string | null;

  /** The actual backing model name for the chat completion deployment. */
  chat_completion_model_name?: string | null;
}

/** A managed web knowledge source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSource extends KnowledgeSource {
  /** The source kind. */
  kind: KnowledgeSourceKind.web;

  /** Web domain configuration. Omit or supply an empty object to apply no domain allow/block restrictions. */
  web_parameters?: WebKnowledgeSourceParameters;
}

/** Parameters that control the domains used for web retrieval. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceParameters {
  /** Domain allow and block configuration. Omit or supply an empty object to apply no domain restrictions. */
  domains?: WebKnowledgeSourceDomains;
}

/** Domain allow and block configuration. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceDomains {
  /** Domains allowed in web results. */
  allowed_domains?: WebKnowledgeSourceDomain[];

  /** Domains blocked from web results. */
  blocked_domains?: WebKnowledgeSourceDomain[];
}

/** A domain used by a web knowledge source. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model WebKnowledgeSourceDomain {
  /** The domain address. */
  address: string;

  /** Whether subpages of the domain can be returned. */
  include_subpages?: boolean;
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
  embedding_model_name?: string;

  /** The content extraction mode used during file ingestion. */
  content_extraction_mode?: string | null;

  /** Blob location and ingestion settings. */
  azure_blob_parameters?: AzureBlobKnowledgeSourceUpdateParameters;

  /** Web domain settings. */
  web_parameters?: WebKnowledgeSourceParameters;
}

/** Public metadata for an uploaded file. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceFile {
  /** The returned file identifier used for deletion. */
  file_id?: string;

  /** The original file name. */
  file_name: string;

  /** The file size, in bytes. */
  file_size_bytes?: int64;

  /** When the file was created. */
  created_at?: utcDateTime;

  /** When the file was last updated. */
  last_updated_at?: utcDateTime;

  /** Processing failure information. A successful upload can still include this field. */
  error_message?: string | null;

  /** The directory-like prefix derived from the file name. */
  prefix?: string;

  /** Custom file metadata. */
  metadata?: Record<string>;

  /** The parsing mode applied to the file. */
  parsing_mode?: string;

  /** The extraction mode applied to the file. */
  extraction_mode?: string;
}

/** Existing Search synchronization diagnostics, not a per-upload readiness guarantee. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceStatus {
  ...Record<unknown>;

  /** The source kind, when supplied by the selected Search version. */
  kind?: KnowledgeSourceKind;

  /** Source provisioning/synchronization status. Active does not mean a specific upload is searchable. */
  synchronization_status?: string;

  /** The synchronization interval, when configured. */
  synchronization_interval?: string | null;

  /** Diagnostics for the current synchronization run. */
  current_synchronization_state?: KnowledgeSourceSynchronizationState | null;

  /** Diagnostics for the last completed synchronization run. */
  last_synchronization_state?:
    | KnowledgeSourceCompletedSynchronizationState
    | null;

  /** Source-specific synchronization statistics. */
  statistics?: KnowledgeSourceStatistics | null;
}

/** Diagnostics for an ongoing synchronization run. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceSynchronizationState {
  /** The synchronization start time. */
  start_time: utcDateTime;

  /** The number of successfully processed updates. */
  items_updates_processed: int32;

  /** The number of failed updates. */
  items_updates_failed: int32;

  /** The number of skipped items. */
  items_skipped: int32;

  /** Document-level errors returned for this run. */
  errors?: KnowledgeSourceSynchronizationError[];
}

/** Diagnostics for a completed synchronization run. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceCompletedSynchronizationState {
  /** The synchronization start time. */
  start_time: utcDateTime;

  /** The synchronization end time. */
  end_time: utcDateTime;

  /** The number of successfully processed updates. */
  items_updates_processed: int32;

  /** The number of failed updates. */
  items_updates_failed: int32;

  /** The number of skipped items. */
  items_skipped: int32;
}

/** A document-level synchronization error. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceSynchronizationError {
  /** The failed document identifier. */
  doc_id?: string;

  /** The failure category expressed as an HTTP-like status code. */
  status_code?: int32;

  /** The component reporting the error. */
  name?: string;

  /** Customer-visible failure information. */
  error_message: string;

  /** Additional failure details. */
  details?: string;

  /** Troubleshooting documentation supplied by the service. */
  documentation_link?: url;
}

/** Historical source synchronization statistics. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeSourceStatistics {
  /** The number of synchronizations. */
  total_synchronization: int32;

  /** Average synchronization duration, in HH:MM:SS format. */
  average_synchronization_duration: string;

  /** Average processed items per synchronization. */
  average_items_processed_per_synchronization: int32;
}

/** One server-driven page of managed Knowledge resources. */
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
model KnowledgeListResult<T> {
  /** The resources in the current page. */
  @pageItems
  value: T[];

  /** An opaque, project-scoped URL for the next page. */
  @nextLink
  next_link?: url;
}

alias KnowledgeListParameters = {
  /** The requested page size. The service can return fewer items. */
  @query
  @pageSize
  @minValue(1)
  @maxValue(3000)
  page_size?: int32;

  /** Filter resources by name. */
  @query
  search?: string;

  /** Name matching mode. The supported and default mode is "prefix". */
  @query
  search_type?: string;
};
