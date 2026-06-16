import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using Azure.Core;
using TypeSpec.Http;

namespace Data.Tables {
  /** Azure Storage basic XML operation template. Not supported by Cosmos endpoint. */
  op TablesXmlOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model
  >(...ApiVersionHeader, ...ClientRequestIdHeader, ...TParams): (TResponse & {
    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TablesServiceError;

  /** Azure Tables operation template. Supported by both Storage and Cosmos. */
  op TablesJsonOperation<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model
  >(
    /** DataServiceVersion header */
    @header("DataServiceVersion")
    dataServiceVersion: "3.0",

    ...ApiVersionHeader,
    ...ClientRequestIdHeader,
    ...TParams,
  ): (TResponse & {
    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
    ...DateResponseHeader;
  }) | TablesError;

  namespace Table {
    /**
     * Queries tables under the given account.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @list
    @route("/Tables")
    op query is TablesJsonOperation<
      {
        ...FormatParameter;
        ...TopParameter;
        ...SelectParameter;
        ...FilterParameter;

        /**
         * A table query continuation token from a previous call.
         */
        @continuationToken
        @query("NextTableName")
        nextTableName?: string;
      },
      {
        @body body: TableQueryResponse;

        /** Content-Type header */
        #suppress "@typespec/http/content-type-ignored" "Template for existing API"
        @header("Content-Type")
        contentType: "application/json;odata=minimalmetadata";

        /**
         * A table query continuation token.
         */
        @continuationToken
        @header("x-ms-continuation-NextTableName")
        nextTableName?: string;
      }
    >;

    /**
     * Creates a new table under the given account.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @post
    @route("/Tables")
    op create(
      /** Content-Type header */
      @header("Content-Type")
      contentType: "application/json",

      /** DataServiceVersion header */
      @header("DataServiceVersion")
      dataServiceVersion: "3.0",

      ...ApiVersionHeader,
      ...ClientRequestIdHeader,
      ...FormatParameter,

      /** The table properties to create. */
      @body
      tableProperties: TableProperties,

      /**
       * Specifies whether the response should include the created table in the
       * payload. Possible values are return-no-content and return-content.
       */
      @header("Prefer")
      prefer?: ResponseFormat,
    ): CreateTableEchoResponse | CreateTableResponse | TablesError;

    /**
     * Deletes an existing table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @delete
    @route("/Tables('{table}')")
    op delete(
      ...ApiVersionHeader,
      ...ClientRequestIdHeader,
      ...TablePathParameter,

      /** Even though the response is 204, if we don't add explicit json, we will
       * get XML formatted error responses from the server.
       */
      @header("Accept")
      accept: "application/json",
    ): {
      @statusCode statusCode: 204;
      ...ApiVersionHeader;
      ...RequestIdResponseHeader;
      ...ClientRequestIdHeader;
      ...DateResponseHeader;
    } | TablesError;

    /**
     * Queries entities under the given table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @route("/{table}()")
    op queryEntities is TablesJsonOperation<
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
        @query("NextPartitionKey")
        nextPartitionKey?: string;

        /**
         * An entity row key query continuation token from a previous call.
         */
        @query("NextRowKey")
        nextRowKey?: string;
      },
      {
        @body body: TableEntityQueryResponse;

        /** Content-Type header */
        #suppress "@typespec/http/content-type-ignored" "Template for existing API"
        @header("Content-Type")
        contentType: "application/json;odata=minimalmetadata";

        /**
         * An entity partition key continuation token.
         */
        @header("x-ms-continuation-NextPartitionKey")
        nextPartitionKey?: string;

        /**
         * A entity row key continuation token.
         */
        @header("x-ms-continuation-NextRowKey")
        nextRowKey?: string;
      }
    >;

    /**
     * Retrieve a single entity.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @route("/{table}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op queryEntityWithPartitionAndRowKey is TablesJsonOperation<
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
        @body tableEntityProperties: TableEntityProperties;

        ...EtagResponseHeader;

        /** Content-Type header */
        #suppress "@typespec/http/content-type-ignored" "Template for existing API"
        @header("Content-Type")
        contentType: "application/json;odata=minimalmetadata";

        /**
         * An entity partition key continuation token.
         */
        @header("x-ms-continuation-NextPartitionKey")
        nextPartitionKey?: string;

        /**
         * A entity row key continuation token.
         */
        @header("x-ms-continuation-NextRowKey")
        nextRowKey?: string;
      }
    >;

    /**
     * Update entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @put
    @route("/{table}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op updateEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/json";

        /** Even though the response is 204, if we don't add explicit json, we will
         * get XML formatted error responses from the server.
         */
        @header("Accept")
        accept: "application/json";

        /**
         * Match condition for an entity to be deleted. If specified and a matching entity
         * is not found, an error will be raised. To force an unconditional delete, set to
         * the wildcard character (*).
         */
        @header("If-Match")
        ifMatch?: string;

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
        tableEntityProperties?: TableEntityProperties;
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
    @route("/{table}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
    op mergeEntity is TablesJsonOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;

        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/json";

        /** Even though the response is 204, if we don't add explicit json, we will
         * get XML formatted error responses from the server.
         */
        @header("Accept")
        accept: "application/json";

        /**
         * Match condition for an entity to be deleted. If specified and a matching entity
         * is not found, an error will be raised. To force an unconditional delete, set to
         * the wildcard character (*).
         */
        @header("If-Match")
        ifMatch?: string;

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
        tableEntityProperties?: TableEntityProperties;
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
    @route("/{table}(PartitionKey='{partitionKey}',RowKey='{rowKey}')")
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

        /** Even though the response is 204, if we don't add explicit json, we will
         * get XML formatted error responses from the server.
         */
        @header("Accept")
        accept: "application/json";

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
     * Insert entity in a table.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @post
    @route("/{table}")
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
      prefer?: ResponseFormat,

      /** The entity properties to insert. */
      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Union types are not supported"
      @body
      tableEntityProperties?: TableEntityProperties,
    ): InsertEntityEchoResponse | InsertEntityResponse | TablesError;

    /**
     * Retrieves details about any stored access policies specified on the table that
     * may be used with Shared Access Signatures.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    @get
    @route("{table}?comp=acl")
    op getAccessPolicy is TablesXmlOperation<
      {
        ...TablePathParameter;
        ...TimeoutParameter;
      },
      {
        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/xml";

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
    @route("{table}?comp=acl")
    op setAccessPolicy is TablesXmlOperation<
      {
        ...TablePathParameter;

        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/xml";

        /** Even though the response is 204, we need explicit Accept. */
        @header("Accept")
        accept: "application/xml";

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
  }

  namespace Service {
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

        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/xml";

        /** Even though the response is 204, we need explicit Accept. */
        @header("Accept")
        accept: "application/xml";

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
      {
        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/xml";

        /** The table service properties. */
        @body
        tableServiceProperties: TableServiceProperties;
      }
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

        /** Content-Type header */
        @header("Content-Type")
        contentType: "application/xml";

        /** Table service statistics */
        @body
        tableServiceStats: TableServiceStats;
      }
    >;
  }
}
