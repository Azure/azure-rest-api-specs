import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A SQL Analytics pool
 */
@parentResource(Workspace)
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

@armResourceOperations
interface SqlPoolOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SqlPool,
        KeyName = "sqlPoolName",
        SegmentName = "sqlPools",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SqlPools {
  /**
   * List all SQL pools
   */
  listByWorkspace is SqlPoolOps.List<SqlPool>;

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
    Response = ArmResourceUpdatedResponse<SqlPool> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
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
  pause is SqlPoolOps.ActionAsync<SqlPool, void, ArmResponse<SqlPool>>;

  /**
   * Resume a SQL pool
   */
  resume is SqlPoolOps.ActionAsync<SqlPool, void, ArmResponse<SqlPool>>;

  /**
   * Creates a restore point for a data warehouse.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("restorePoints")
  @operationId("SqlPoolRestorePoints_Create")
  sqlPoolRestorePointsCreate is SqlPoolOps.ActionAsync<
    SqlPool,
    CreateSqlPoolRestorePointDefinition,
    ArmResponse<RestorePoint> | ArmResourceCreatedResponse<RestorePoint>
  >;

  /**
   * Gets a list of operations performed on the SQL pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("operations")
  @operationId("SqlPoolOperations_List")
  list is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<ResourceListResult<SqlPoolOperation>>
  >;

  /**
   * Gets SQL pool usages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("usages")
  @operationId("SqlPoolUsages_List")
  sqlPoolUsagesList is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<SqlPoolUsageListResult>
  >;

  /**
   * Gets SQL pool sensitivity labels.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("currentSensitivityLabels")
  @operationId("SqlPoolSensitivityLabels_ListCurrent")
  listCurrent is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch
  @action("currentSensitivityLabels")
  @operationId("SqlPoolSensitivityLabels_Update")
  sqlPoolSensitivityLabelsUpdate is SqlPoolOps.ActionSync<
    SqlPool,
    SensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets sensitivity labels of a given SQL pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("recommendedSensitivityLabels")
  @operationId("SqlPoolSensitivityLabels_ListRecommended")
  listRecommended is SqlPoolOps.ActionSync<
    SqlPool,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch
  @action("recommendedSensitivityLabels")
  @operationId("SqlPoolRecommendedSensitivityLabels_Update")
  sqlPoolRecommendedSensitivityLabelsUpdate is SqlPoolOps.ActionSync<
    SqlPool,
    RecommendedSensitivityLabelUpdateList,
    OkResponse
  >;
}
@armResourceOperations
interface SqlPoolOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Workspace,
          KeyName = "workspaceName",
          SegmentName = "workspaces",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = SqlPool,
          KeyName = "sqlPoolName",
          SegmentName = "sqlPools",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = SqlPool,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SqlPoolOperationResults {
  /**
   * Get the status of a SQL pool operation
   */
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
