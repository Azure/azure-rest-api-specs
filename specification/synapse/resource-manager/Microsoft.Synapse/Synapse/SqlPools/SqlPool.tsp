import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * A SQL Analytics pool
 */
model SqlPool
  is Azure.ResourceManager.TrackedResource<SqlPoolResourceProperties> {
  ...ResourceNameParameter<
    Resource = SqlPool,
    KeyName = "sqlPoolName",
    SegmentName = "sqlPools",
    NamePattern = ""
  >;

  /**
   * SQL pool SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

alias SqlPoolOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;
  },
  {
    /** SQL pool name */
    @path
    @segment("sqlPools")
    @key
    sqlPoolName: string;
  }
>;

@armResourceOperations
interface SqlPools {
  /**
   * Get SQL pool properties
   */
  get is SqlPoolOps.Read<SqlPool>;

  /**
   * Create a SQL pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is SqlPoolOps.CreateOrUpdateAsync<
    SqlPool,
    Response =
      | ArmResourceUpdatedResponse<SqlPool>
      | ArmAcceptedLroResponse
      | SqlPoolNotFoundResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlPool> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Apply a partial update to a SQL pool
   */
  @patch(#{ implicitOptionality: false })
  update is SqlPoolOps.CustomPatchAsync<SqlPool, PatchModel = SqlPoolPatchInfo>;

  /**
   * Delete a SQL pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  delete is SqlPoolOps.DeleteWithoutOkAsync<
    SqlPool,
    Response =
      | ArmResponse<SqlPool>
      | (ArmDeleteAcceptedLroResponse & {
          @bodyRoot
          _: SqlPool;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * Pause a SQL pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 202 response returns the SQL pool."
  pause is SqlPoolOps.ActionAsync<
    SqlPool,
    void,
    ArmResponse<SqlPool>,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlPool> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResponse<SqlPool> | SqlPoolAcceptedResponse
  >;

  /**
   * Resume a SQL pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 202 response returns the SQL pool."
  resume is SqlPoolOps.ActionAsync<
    SqlPool,
    void,
    ArmResponse<SqlPool>,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlPool> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResponse<SqlPool> | SqlPoolAcceptedResponse
  >;

  /**
   * Creates a restore point for a data warehouse.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "Published operation: the restore-point action on a SQL pool returns the created RestorePoint."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolRestorePoints_Create")
  @action("restorePoints")
  sqlPoolRestorePointsCreate is SqlPoolOps.ActionAsync<
    SqlPool,
    CreateSqlPoolRestorePointDefinition,
    ArmResponse<RestorePoint> | ArmResourceCreatedResponse<RestorePoint>,
    LroHeaders = ArmLroLocationHeader<FinalResult = RestorePoint> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of operations performed on the SQL pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolOperations_List")
  @list
  @get
  @action("operations")
  list is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<SqlPoolBlobAuditingPolicySqlPoolOperationListResult>
  >;

  /**
   * Gets SQL pool usages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolUsages_List")
  @list
  @get
  @action("usages")
  sqlPoolUsagesList is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<SqlPoolUsageListResult>
  >;

  /**
   * Gets SQL pool sensitivity labels.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_ListCurrent")
  @list
  @get
  @action("currentSensitivityLabels")
  listCurrent is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<SensitivityLabelListResult>,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Update sensitivity labels of a given SQL Pool using an operations batch.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 200 response has no body."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_Update")
  @patch
  @action("currentSensitivityLabels")
  sqlPoolSensitivityLabelsUpdate is SqlPoolOps.ActionSync<
    SqlPool,
    SensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets sensitivity labels of a given SQL pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_ListRecommended")
  @list
  @get
  @action("recommendedSensitivityLabels")
  listRecommended is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<SensitivityLabelListResult>,
    Parameters = {
      /**
       * Specifies whether to include disabled recommendations or not.
       */
      @query("includeDisabledRecommendations")
      includeDisabledRecommendations?: boolean;

      /**
       * An OData query option to indicate how many elements to skip in the collection.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Update recommended sensitivity labels states of a given SQL Pool using an operations batch.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 200 response has no body."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolRecommendedSensitivityLabels_Update")
  @patch
  @action("recommendedSensitivityLabels")
  sqlPoolRecommendedSensitivityLabelsUpdate is SqlPoolOps.ActionSync<
    SqlPool,
    RecommendedSensitivityLabelUpdateList,
    OkResponse
  >;
}
alias SqlPoolOperationResultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;

    /** SQL pool name */
    @path
    @segment("sqlPools")
    @key
    sqlPoolName: string;
  },
  {
    /** Operation ID */
    @path
    @segment("operationResults")
    @key
    operationId: string;
  }
>;

@armResourceOperations
interface SqlPoolOperationResults {
  /**
   * Get the status of a SQL pool operation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The published 202 response of this status endpoint has no Location header."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The published 202 response returns the SQL pool."
  #suppress "@azure-tools/typespec-azure-core/no-openapi-client-extensions" "For backward compatibility: the original OpenAPI marks this GET as long-running (released SDKs expose begin_get_location_header_result)"
  @extension("x-ms-long-running-operation", true)
  getLocationHeaderResult is SqlPoolOperationResultOps.Read<
    SqlPool,
    Response =
      | ArmResponse<SqlPool>
      | ArmResourceCreatedSyncResponse<SqlPool>
      | (AcceptedResponse & {
          @bodyRoot
          _: SqlPool;
        })
  >;

  /**
   * List all SQL pools
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPools_ListByWorkspace")
  listByWorkspace is SqlPoolOps.List<
    SqlPool,
    Response = ArmResponse<SqlPoolInfoListResult>
  >;
}

@@doc(SqlPool.name, "SQL pool name");
@@doc(SqlPool.properties, "SQL pool properties");
@@doc(SqlPools.create::parameters.resource, "The SQL pool to create");
@@doc(
  SqlPools.update::parameters.properties,
  "The updated SQL pool properties"
);
@@doc(
  SqlPools.sqlPoolRestorePointsCreate::parameters.body,
  "The definition for creating the restore point of this Sql pool."
);
@@doc(SqlPools.sqlPoolSensitivityLabelsUpdate::parameters.body, "");
@@doc(SqlPools.sqlPoolRecommendedSensitivityLabelsUpdate::parameters.body, "");

/**
 * The SQL pool was not found (returned by SqlPools_Create for backward compatibility).
 */
@error
model SqlPoolNotFoundResponse {
  /** The 404 status code. */
  @statusCode
  _: 404;
}

// The published 202 for pause/resume returns the SQL pool body.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Response description comes from the template."
model SqlPoolAcceptedResponse is ArmAcceptedLroResponse<
  "Resource operation accepted.",
  ArmLroLocationHeader<FinalResult = SqlPool> &
    Azure.Core.Foundations.RetryAfterHeader
> {
  /** The SQL pool. */
  @bodyRoot
  body: SqlPool;
}
