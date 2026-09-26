import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace FoundryLocal.AgenticRAG;

// ──── Knowledge Base enums ────

/** The object type for knowledge base resources. */
union KnowledgeBaseObjectType {
  string,

  /** Indicates a knowledge base object. */
  knowledge_base: "knowledge_base",
}

// ──── Knowledge Base models ────

/** A paginated list of knowledge bases. */
model KnowledgeBaseList {
  /** The object type of this response. */
  object?: ListObjectType;

  /** The list of knowledge bases. */
  @pageItems
  data?: KnowledgeBase[];

  /** The identifier of the first knowledge base in the list. */
  @encodedName("application/json", "first_id")
  firstId?: string;

  /** The identifier of the last knowledge base in the list. */
  @encodedName("application/json", "last_id")
  lastId?: string;

  /** Whether there are more knowledge bases available. */
  @encodedName("application/json", "has_more")
  hasMore?: boolean;
}

/** Represents a knowledge base that aggregates knowledge sources. */
model KnowledgeBase {
  /** The unique identifier of the knowledge base. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The object type of this resource. */
  object?: KnowledgeBaseObjectType;

  /** The timestamp when the knowledge base was created. */
  @encodedName("application/json", "created_at")
  createdAt?: utcDateTime;

  /** The timestamp when the knowledge base was last updated. */
  @encodedName("application/json", "updated_at")
  updatedAt?: utcDateTime;

  /** The name of the knowledge base. */
  name?: string;

  /** A description of the knowledge base. */
  description?: string;

  /** The list of associated knowledge source identifiers. */
  @encodedName("application/json", "knowledge_source_ids")
  knowledgeSourceIds?: string[];

  /** Dictionary of <string> */
  metadata?: Record<string>;
}

/** Wrapper containing a single knowledge base. */
model KnowledgeBaseWrapper {
  /** The knowledge base data. */
  data?: KnowledgeBase;
}

/** Request body for partially updating a knowledge base. */
model UpdateKnowledgeBaseRequest {
  /** The updated name of the knowledge base. */
  name?: string;

  /** The updated description of the knowledge base. */
  description?: string;

  /** Replaces entire list when provided. */
  @encodedName("application/json", "knowledge_source_ids")
  knowledgeSourceIds?: string[];
}

/** Request body for fully replacing a knowledge base. */
model ReplaceKnowledgeBaseRequest {
  /** The name of the knowledge base. */
  @maxLength(256)
  @minLength(1)
  name: string;

  /** A description of the knowledge base. */
  @maxLength(512)
  description?: string;

  /** The list of associated knowledge source identifiers. */
  @encodedName("application/json", "knowledge_source_ids")
  knowledgeSourceIds?: string[];

  /** Dictionary of <string> */
  metadata?: Record<string>;
}
