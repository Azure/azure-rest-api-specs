import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Http;

namespace Data.Tables {

  /** Azure Storage basic XML operation template. Not supported by Cosmos endpoint. */
  op TablesXmlOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model,
  >(
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: "application/xml",

    ...ApiVersionHeader,
    ...TParams,
    ...ClientRequestIdHeader,
  ): (TResponse & {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: "application/xml";

    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TablesXmlError;

  /** Azure Tables operation template. Supported by both Storage and Cosmos. */
  op TablesJsonOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model,
  >(
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: "application/json",

    /** DataServiceVersion header */
    @header("DataServiceVersion")
    dataServiceVersion: "3.0",

    ...ApiVersionHeader,
    ...TParams,
    ...ClientRequestIdHeader,
  ): (TResponse & {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: "application/json;odata=minimalmetadata";

    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
    ...DateResponseHeader;
  }) | TableServiceError;

  /**
   * Sets properties for an account's Table service endpoint, including properties
   * for Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @put
  @route("?restype=service&comp=properties")
  op setProperties is TablesXmlOperation<
    {
      ...TimeoutParameter;

      /** The table service properties to set. */
      @body
      tableServiceProperties: TableServiceProperties;
    },
    {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Gets the properties of an account's Table service, including properties for
   * Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("?restype=service&comp=properties")
  op getProperties is TablesXmlOperation<
    TimeoutParameter,
    TableServiceProperties
  >;

  /**
   * Retrieves statistics related to replication for the Table service. It is only
   * available on the secondary location endpoint when read-access geo-redundant
   * replication is enabled for the account.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @route("?restype=service&comp=stats")
  op getStatistics is TablesXmlOperation<
    TimeoutParameter,
    {
      ...DateResponseHeader;

      /** Table service statistics */
      @body
      tableServiceStats: TableServiceStats;
    }
  >;

  /**
   * Queries tables under the given account.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  @get
  @list
  @route("/Tables")
  op listTables is TablesJsonOperation<
    {
      ...FormatParameter;
      ...TopParameter;
      ...SelectParameter;
      ...FilterParameter;
      ...TimeoutParameter;

      /**
       * A table query continuation token from a previous call.
       */
      @continuationToken
      @query("NextTableName")
      nextTableName?: string;

    },
    {
      @body body: TablesPagedResult;

      /**
       * A table query continuation token.
       */
      @continuationToken
      @header("x-ms-continuation-NextTableName")
      nextTableName?: string;
    }
  >;
  
  namespace Table {
    /**
     * Retrieves details about any stored access policies specified on the table that
     * may be used with Shared Access Signatures.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @get
    @route("{tableName}?comp=acl")
    op getAccessPolicy is TablesXmlOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;
      },
      {
        /** Signed identifiers */
        @body body: SignedIdentifiers;

        ...DateResponseHeader;
      }
    >;

    /**
     * Sets stored access policies for the table that may be used with Shared Access
     * Signatures.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @put
    @route("{tableName}?comp=acl")
    op setAccessPolicy is TablesXmlOperation<
      {
        ...TablePathParameter;

        /** The access control list for the table. */
        @body
        tableAcl: SignedIdentifiers;

        ...TimeoutParameter;
      },
      {
        @statusCode statusCode: 204;

        ...DateResponseHeader;
      }
    >;
  
      /**
     * Creates a new table under the given account.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @post
    @route("/Tables")
    op createTable(
      /** Content-Type header */
      @header("Content-Type")
      contentType: "application/json",

      /** DataServiceVersion header */
      @header("DataServiceVersion")
      dataServiceVersion: "3.0",

      ...ApiVersionHeader,
      ...FormatParameter,
      ...ClientRequestIdHeader,

      /**
       * Specifies whether the response should include the created table in the
       * payload. Possible values are return-no-content and return-content.
       */
      @header("Prefer")
      echoTable?: EchoFormat,

      /** The table properties to create. */
      @body
      tableProperties: TableProperties,
    ): CreateTableEchoResponse | CreateTableResponse | TableServiceError;

    /**
     * Deletes an existing table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @delete
    @route("/Tables('{tableName}')")
    op deleteTable is TablesJsonOperation<
      {
        ...TablePathParameter;
      },
      {
        @statusCode statusCode: 204;
      }
    >;

    /**
     * Insert entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @post
    @route("/{tableName}")
    op insertEntity(
      /** Content-Type header */
      @header("Content-Type")
      contentType: "application/json",

      /** DataServiceVersion header */
      @header("DataServiceVersion")
      dataServiceVersion: "3.0",

      ...ApiVersionHeader,
      ...TablePathParameter,
      ...TimeoutParameter,
      ...FormatParameter,
      ...ClientRequestIdHeader,

      /**
       * Specifies whether the response should include the inserted entity in the
       * payload. Possible values are return-no-content and return-content.
       */
      @header("Prefer")
      echoEntity?: EchoFormat,

      /** The entity properties to insert. */
      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
      @body
      entityProperties: Record<unknown>;
    ): InsertEntityEchoResponse | InsertEntityResponse | TableServiceError;

    /**
     * Update entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @put
    @sharedRoute
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op updateEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /**
         * Match condition for an entity to be deleted. If specified and a matching entity
         * is not found, an error will be raised. To force an unconditional delete, set to
         * the wildcard character (*).
         */
        @header("If-Match")
        ifMatch: string;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;

        /**
         * The properties for the table entity.
         */
        #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
        @body
        entityProperties: Record<unknown>;
      },
      {
        @statusCode statusCode: 204;

        ...EtagResponseHeader;
      }
    >;

    /**
     * Merge entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @patch(#{ implicitOptionality: false })
    @sharedRoute
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op mergeEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /**
         * Match condition for an entity to be deleted. If specified and a matching entity
         * is not found, an error will be raised. To force an unconditional delete, set to
         * the wildcard character (*).
         */
        @header("If-Match")
        ifMatch: string;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;

        /**
         * The properties for the table entity.
         */
        #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
        @body
        entityProperties: Record<unknown>;
      },
      {
        @statusCode statusCode: 204;

        ...EtagResponseHeader;
      }
    >;

    /**
     * Insert or replace entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @put
    @sharedRoute
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op insertOrReplaceEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;

        /**
         * The properties for the table entity.
         */
        #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
        @body
        entityProperties: Record<unknown>;
      },
      {
        @statusCode statusCode: 204;

        ...EtagResponseHeader;
      }
    >;
  
    /**
     * Insert or merge entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @patch(#{ implicitOptionality: false })
    @sharedRoute
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op insertOrMergeEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;

        /**
         * The properties for the table entity.
         */
        #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
        @body
        entityProperties: Record<unknown>;
      },
      {
        @statusCode statusCode: 204;

        ...EtagResponseHeader;
      }
    >;

    /**
     * Deletes the specified entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @delete
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op deleteEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /**
         * Match condition for an entity to be deleted. If specified and a matching entity
         * is not found, an error will be raised. To force an unconditional delete, set to
         * the wildcard character (*).
         */
        @header("If-Match")
        ifMatch: string;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;
      },
      {
        @statusCode statusCode: 204;
      }
    >;

    /**
     * Queries entities under the given table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @get
    @list
    @route("/{tableName}()")
    op listEntities is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...FormatParameter;
        ...TopParameter;
        ...SelectParameter;
        ...FilterParameter;
        ...TimeoutParameter;

        /**
         * An entity partition key query continuation token from a previous call.
         */
        @continuationToken
        @query("NextPartitionKey")
        nextPartitionKey?: string;

        /**
         * An entity row key query continuation token from a previous call.
         */
        // @continuationToken
        // @query("NextRowKey")
        // nextRowKey?: string;

      },
      {
        @body body: TableEntitiesPagedResult;

        /**
         * An entity partition key continuation token.
         */
        @continuationToken
        @header("x-ms-continuation-NextPartitionKey")
        nextPartitionKey?: string;

        /**
         * A entity row key continuation token.
         */
        // @continuationToken
        // @header("x-ms-continuation-NextRowKey")
        // nextRowKey?: string;
      }
    >;
  
    /**
     * Retrieve a single entity.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @get
    @route("/{tableName}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op getEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;
        ...FormatParameter;
        ...SelectParameter;
        ...FilterParameter;

        /**
         * The partition key of the entity.
         */
        @path
        partitionKey: string;

        /**
         * The row key of the entity.
         */
        @path
        rowKey: string;
      },
      {
        /** The entity properties. */
        #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
        @body entityProperties: Record<unknown>;
        
        ...EtagResponseHeader;
      }
    >;
  
    /**
     * The Batch operation allows multiple API calls to be embedded into a single HTTP request.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @post
    @route("/$batch")
    op submitTransaction(
      /** The batch request content */
      ...TransactionBodyParameter,

      /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
      @header("Content-Type")
      multipartContentType: "multipart/mixed",

      ...TimeoutParameter,
      ...ApiVersionHeader,
      ...ClientRequestIdHeader,
    ): ({
      @statusCode statusCode: 202;

      /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
      @header("Content-Type")
      multipartContentType: "multipart/mixed";

      ...RequestIdResponseHeader;
      ...ApiVersionHeader;
    } & TransactionBodyParameter) | TableServiceError;
  }

}
