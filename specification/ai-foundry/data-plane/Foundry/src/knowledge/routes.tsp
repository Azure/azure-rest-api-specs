import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Existing synchronization diagnostics, including a null body when no status is available. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The existing nullable status response is not a polymorphic model hierarchy. Preserve null without enabling experimental union-extends project-wide."
@extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
union KnowledgeSourceStatusResult {
  /** Existing source synchronization diagnostics. */
  status: KnowledgeSourceStatus,

  /** No synchronization diagnostics are available. */
  unavailable: null,
}

/** Author reusable knowledge-base definitions in the current Foundry project. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Preserve the existing managed Knowledge routes and Search-compatible paging contract."
@tag("Knowledge Bases")
interface KnowledgeBases {
  /** Create a knowledge base. A duplicate name does not overwrite the saved definition. */
  @summary("Create a knowledge base")
  @post
  @route("/knowledge_bases")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  create is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The definition to create. */
      @body knowledge_base: KnowledgeBase;
    },
    {
      @statusCode statusCode: 201;

      /** The saved definition's ETag. */
      @header("ETag") etag?: string;

      @body knowledge_base: KnowledgeBase;
    }
  >;

  /** Create or fully replace a definition, honoring caller-supplied preconditions. */
  @summary("Create or replace a knowledge base")
  @put
  @route("/knowledge_bases/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  createOrUpdate is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The knowledge-base name. */
      @path name: string;

      /** The ETag required for replacement, or '*' to require an existing definition. */
      @header("If-Match") ifMatch?: string;

      /** Set to '*' to require that no definition already exists. */
      @header("If-None-Match") ifNoneMatch?: string;

      /** The complete replacement definition. Its name must match the route. */
      @body knowledge_base: KnowledgeBase;
    },
    {
      @statusCode statusCode: 200;

      /** The saved definition's ETag. */
      @header("ETag") etag?: string;

      @body knowledge_base: KnowledgeBase;
    }
  >;

  /** Read the saved configuration, not the knowledge-base content. */
  @summary("Get a knowledge base")
  @get
  @route("/knowledge_bases/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  get is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The knowledge-base name. */
      @path name: string;
    },
    {
      /** The saved definition's ETag. */
      @header("ETag") etag?: string;

      @body knowledge_base: KnowledgeBase;
    }
  >;

  /** List saved definitions with lazy, server-driven continuation. */
  @summary("List knowledge bases")
  @get
  @list
  @route("/knowledge_bases")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  list is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      ...KnowledgeListParameters;
    },
    KnowledgeListResult<KnowledgeBase>
  >;

  /** Delete a knowledge-base definition without deleting shared sources or customer content. */
  @summary("Delete a knowledge base")
  @delete
  @route("/knowledge_bases/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  delete is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The knowledge-base name. */
      @path name: string;

      /** The ETag required for deletion. */
      @header("If-Match") ifMatch?: string;

      /** An ETag that must not match the saved definition. */
      @header("If-None-Match") ifNoneMatch?: string;
    },
    NoContentResponse
  >;
}

/** Author reusable sources and inspect existing ingestion diagnostics. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Preserve the existing managed Knowledge routes, named POST updates and Search-compatible paging contract."
@tag("Knowledge Sources")
interface KnowledgeSources {
  /** Create a source. Provision source connections and permissions explicitly before this call. */
  @summary("Create a knowledge source")
  @post
  @route("/knowledge_sources")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      CreateFile: #{
        $ref: "../../examples/v1/KnowledgeSources_CreateFile.json",
      },
      CreateBlob: #{
        $ref: "../../examples/v1/KnowledgeSources_CreateBlob.json",
      },
      CreateWeb: #{ $ref: "../../examples/v1/KnowledgeSources_CreateWeb.json" },
    }
  )
  create is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The kind-specific source definition. */
      @body knowledge_source: KnowledgeSourceCreate;
    },
    KnowledgeSource
  >;

  /** Update mutable fields with the existing named POST contract. Caller If-Match is not supported. */
  @summary("Update a knowledge source")
  @post
  @route("/knowledge_sources/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  update is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The saved source name. */
      @path name: string;

      /** Source fields to update. Kind and File embedding deployment cannot be changed. */
      @body knowledge_source: KnowledgeSourceUpdate;
    },
    KnowledgeSource
  >;

  /** Read a source without exposing its backing Search endpoint, credentials or identity configuration. */
  @summary("Get a knowledge source")
  @get
  @route("/knowledge_sources/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  get is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The source name. */
      @path name: string;
    },
    KnowledgeSource
  >;

  /** List source summaries without eagerly fetching source details or files. */
  @summary("List knowledge sources")
  @get
  @list
  @route("/knowledge_sources")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  list is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      ...KnowledgeListParameters;
    },
    KnowledgeListResult<KnowledgeSourceListItem>
  >;

  /** Read existing Search synchronization diagnostics. A null result does not establish retrieval readiness. */
  @summary("Get knowledge source synchronization status")
  @get
  @route("/knowledge_sources/{name}/status")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  getStatus is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The source name. */
      @path name: string;
    },
    {
      @statusCode statusCode: 200;
      @body status: KnowledgeSourceStatusResult;
    }
  >;

  /** Delete an unused source. This does not cascade into shared knowledge bases or customer-owned content. */
  @summary("Delete a knowledge source")
  @delete
  @route("/knowledge_sources/{name}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  delete is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The source name. */
      @path name: string;
    },
    NoContentResponse
  >;

  /** Upload one file to a File source. Upload acceptance does not mean ingestion has completed. */
  #suppress "@azure-tools/typespec-azure-core/byos" "The existing managed File source accepts a direct binary upload; requiring customer-owned storage would change the approved managed Knowledge experience."
  @summary("Upload a knowledge source file")
  @post
  @route("/knowledge_sources/{name}/files")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  uploadFile is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The File source name. */
      @path name: string;

      /** File content type. */
      @header contentType: "application/octet-stream";

      /** Attachment disposition containing a filename. */
      @header("Content-Disposition") contentDisposition: string;

      /** The file content. A consumed stream must not be replayed automatically. */
      @body content: bytes;
    },
    KnowledgeSourceFile
  >;

  /** List files with server-driven continuation. File operations require a File source. */
  @summary("List knowledge source files")
  @get
  @list
  @route("/knowledge_sources/{name}/files")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  listFiles is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The File source name. */
      @path name: string;

      ...KnowledgeListParameters;

      /** A directory-like prefix of file paths to list. */
      @query prefix?: string;
    },
    KnowledgeListResult<KnowledgeSourceFile>
  >;

  /** Delete a file by the identifier returned in its metadata. */
  @summary("Delete a knowledge source file")
  @delete
  @route("/knowledge_sources/{name}/files/{file_id}")
  @extension("x-ms-foundry-meta", KnowledgeRequiredPreviews)
  deleteFile is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.knowledge_v1_preview,
    {
      /** The File source name. */
      @path name: string;

      /** The returned file identifier. */
      @path file_id: string;
    },
    NoContentResponse
  >;
}
