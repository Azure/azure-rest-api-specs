import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace FoundryLocal.AgenticRAG;

// ──── Knowledge Source enums ────

/** The kind of knowledge source. */
union KnowledgeSourceKind {
  string,

  /** A remote MCP server knowledge source. */
  remote_mcp: "remote_mcp",

  /** An indexed sources MCP knowledge source. */
  indexed_sources_mcp: "indexed_sources_mcp",
}

/** The authentication type for a knowledge source. */
union AuthType {
  string,

  /** Microsoft Entra ID authentication. */
  microsoft_entra_id: "microsoft_entra_id",

  /** No authentication required. */
  unauthenticated: "unauthenticated",
}

/** The validation status of a knowledge source. */
union ValidationStatus {
  string,

  /** Validation status is unknown. */
  `unknown`: "unknown",

  /** The knowledge source is validated and active. */
  active: "active",

  /** Validation of the knowledge source failed. */
  failed: "failed",
}

// ──── Knowledge Source models ────

/** Request body for creating a new knowledge source. */
model CreateKnowledgeSourceRequest {
  /** The name of the knowledge source. */
  @maxLength(256)
  @minLength(1)
  name: string;

  /** The kind of knowledge source. */
  kind: KnowledgeSourceKind;

  /** The authentication type for the knowledge source. */
  @encodedName("application/json", "auth_type")
  authType?: AuthType;

  /** A description of the knowledge source. */
  description?: string;

  /** The identifier of the user creating the knowledge source. */
  @encodedName("application/json", "created_by")
  createdBy?: string;

  /** Parameters for a remote MCP server connection. */
  @encodedName("application/json", "remote_mcp_parameters")
  remoteMcpParameters?: RemoteMcpParameters;

  /** Parameters for an indexed sources connection. */
  @encodedName("application/json", "indexed_sources_parameters")
  indexedSourcesParameters?: IndexedSourcesParameters;
}

/** Connection parameters for a remote MCP server. */
model RemoteMcpParameters {
  /** URL of the MCP server endpoint. */
  @encodedName("application/json", "server_url")
  serverUrl: string;

  /** A human-readable label for the MCP server. */
  @encodedName("application/json", "server_label")
  serverLabel?: string;
}

/** Connection parameters for an indexed sources MCP server. */
model IndexedSourcesParameters {
  /** The URL of the indexed sources MCP server. */
  @encodedName("application/json", "server_url")
  serverUrl: string;

  /** The name of the indexed source to connect to. */
  @encodedName("application/json", "indexed_source_ref")
  indexedSourceRef: string;

  /** A human-readable label for the server. */
  @encodedName("application/json", "server_label")
  serverLabel?: string = "indexed-sources-mcp-server";
}

/** Represents a knowledge source. */
model KnowledgeSource {
  /** The unique identifier of the knowledge source. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The name of the knowledge source. */
  name?: string;

  /** The kind of knowledge source. */
  kind?: KnowledgeSourceKind;

  /** A description of the knowledge source. */
  description?: string;

  /** The authentication type for the knowledge source. */
  @encodedName("application/json", "auth_type")
  authType?: AuthType;

  /** Parameters for a remote MCP server connection. */
  @encodedName("application/json", "remote_mcp_parameters")
  remoteMcpParameters?: RemoteMcpParameters;

  /** Parameters for an indexed sources connection. */
  @encodedName("application/json", "indexed_sources_parameters")
  indexedSourcesParameters?: IndexedSourcesParameters;

  /** The current validation status of the knowledge source. */
  @encodedName("application/json", "validation_status")
  validationStatus?: ValidationStatus;

  /** The validation error message, if validation failed. */
  @encodedName("application/json", "validation_error")
  validationError?: string;

  /** The timestamp when the knowledge source was last validated. */
  @encodedName("application/json", "validated_at")
  validatedAt?: utcDateTime;

  /** The identifier of the user who created the knowledge source. */
  @encodedName("application/json", "created_by")
  createdBy?: string;

  /** The timestamp when the knowledge source was created. */
  @encodedName("application/json", "created_at")
  createdAt?: utcDateTime;

  /** The timestamp when the knowledge source was last updated. */
  @encodedName("application/json", "updated_at")
  updatedAt?: utcDateTime;
}

/** A paginated list of knowledge sources. */
model KnowledgeSourceList {
  /** The list of knowledge sources. */
  @pageItems
  items?: KnowledgeSource[];

  /** The total number of knowledge sources. */
  total?: int32;

  /** The maximum number of items returned per page. */
  limit?: int32;

  /** The number of items skipped. */
  offset?: int32;
}

/** Request body for partially updating a knowledge source. */
model UpdateKnowledgeSourceRequest {
  /** The updated name of the knowledge source. */
  @maxLength(256)
  @minLength(1)
  name?: string;

  /** The updated description of the knowledge source. */
  description?: string;

  /** The updated authentication type. */
  @encodedName("application/json", "auth_type")
  authType?: AuthType;

  /** Updated parameters for a remote MCP server connection. */
  @encodedName("application/json", "remote_mcp_parameters")
  remoteMcpParameters?: RemoteMcpParameters;

  /** Updated parameters for an indexed sources connection. */
  @encodedName("application/json", "indexed_sources_parameters")
  indexedSourcesParameters?: IndexedSourcesParameters;
}

/** Request body for batch deleting knowledge sources. */
model BatchDeleteKnowledgeSourcesRequest {
  /** The list of knowledge source identifiers to delete. */
  @encodedName("application/json", "ks_ids")
  ksIds: string[];
}

/** Response returned after batch deleting knowledge sources. */
model BatchDeleteKnowledgeSourcesResponse {
  /** The number of knowledge sources that were deleted. */
  @encodedName("application/json", "deleted_count")
  deletedCount?: int32;
}
