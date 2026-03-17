import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database resource.
 */
@parentResource(ManagedInstance)
model ManagedDatabase
  is Azure.ResourceManager.TrackedResource<ManagedDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDatabase,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ManagedDatabases {
  /**
   * Gets a managed database.
   */
  @tag("ManagedDatabases")
  get is ArmResourceRead<ManagedDatabase>;

  /**
   * Creates a new database or updates an existing database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @tag("ManagedDatabases")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedDatabase,
    Response = ArmResourceUpdatedResponse<ManagedDatabase> | ArmResourceCreatedResponse<
      ManagedDatabase,
      ArmLroLocationHeader<FinalResult = ManagedDatabase> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing database.
   */
  @patch(#{ implicitOptionality: false })
  @tag("ManagedDatabases")
  update is ArmCustomPatchAsync<
    ManagedDatabase,
    PatchModel = ManagedDatabaseUpdate
  >;

  /**
   * Deletes a managed database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("ManagedDatabases")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedDatabase,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of managed databases.
   */
  @tag("ManagedDatabases")
  listByInstance is ArmResourceListByParent<ManagedDatabase>;

  /**
   * List managed database columns
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseColumns")
  @operationId("ManagedDatabaseColumns_ListByDatabase")
  @list
  @get
  @action("columns")
  listByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<DatabaseColumn>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "schema", explode: true })
      schema?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "table", explode: true })
      table?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "column", explode: true })
      column?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "orderBy", explode: true })
      orderBy?: string[];

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Cancels a managed database move operation.
   */
  @tag("ManagedDatabases")
  cancelMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    OkResponse
  >;

  /**
   * Completes a managed database move operation.
   */
  @tag("ManagedDatabases")
  completeMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    OkResponse
  >;

  /**
   * Completes the restore operation on a managed database.
   */
  @tag("ManagedDatabases")
  completeRestore is ArmResourceActionAsync<
    ManagedDatabase,
    CompleteDatabaseRestoreDefinition,
    OkResponse
  >;

  /**
   * Reevaluates the inaccessibility state of a managed database.
   */
  @tag("ManagedDatabases")
  reevaluateInaccessibleDatabaseState is ArmResourceActionAsync<
    ManagedDatabase,
    void,
    Response = ManagedDatabase
  >;

  /**
   * Starts a managed database move operation.
   */
  @tag("ManagedDatabases")
  startMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseStartMoveDefinition,
    OkResponse
  >;

  /**
   * Gets a list of security events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSecurityEvents")
  @operationId("ManagedDatabaseSecurityEvents_ListByDatabase")
  @list
  @get
  @action("securityEvents")
  managedDatabaseSecurityEventsListByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<SecurityEventCollection>,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSensitivityLabels")
  @operationId("ManagedDatabaseSensitivityLabels_ListCurrentByDatabase")
  @list
  @get
  @action("currentSensitivityLabels")
  listCurrentByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("$skipToken")
      $skipToken?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("$count")
      $count?: boolean;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Update sensitivity labels of a given database using an operations batch.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSensitivityLabels")
  @operationId("ManagedDatabaseSensitivityLabels_Update")
  @patch
  @action("currentSensitivityLabels")
  managedDatabaseSensitivityLabelsUpdate is ArmResourceActionSync<
    ManagedDatabase,
    SensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSensitivityLabels")
  @operationId("ManagedDatabaseSensitivityLabels_ListRecommendedByDatabase")
  @list
  @get
  @action("recommendedSensitivityLabels")
  listRecommendedByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Specifies whether to include disabled recommendations or not.
       */
      @query("includeDisabledRecommendations")
      includeDisabledRecommendations?: boolean;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Update recommended sensitivity labels states of a given database using an operations batch.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSensitivityLabels")
  @operationId("ManagedDatabaseRecommendedSensitivityLabels_Update")
  @patch
  @action("recommendedSensitivityLabels")
  managedDatabaseRecommendedSensitivityLabelsUpdate is ArmResourceActionSync<
    ManagedDatabase,
    RecommendedSensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ManagedDatabaseSensitivityLabels")
  @operationId("ManagedDatabaseSensitivityLabels_ListByDatabase")
  @list
  @get
  @action("sensitivityLabels")
  managedDatabaseSensitivityLabelsListByDatabase is ArmResourceActionSync<
    ManagedDatabase,
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
}

@@doc(ManagedDatabase.name, "The name of the database.");
@@doc(ManagedDatabase.properties, "Resource properties.");
@@doc(ManagedDatabases.createOrUpdate::parameters.resource,
  "The requested database resource state."
);
@@doc(ManagedDatabases.update::parameters.properties,
  "The requested database resource state."
);
@@doc(ManagedDatabases.cancelMove::parameters.body,
  "Parameters of the cancel managed database move operation."
);
@@doc(ManagedDatabases.completeMove::parameters.body,
  "Parameters of the complete managed database move operation."
);
@@doc(ManagedDatabases.completeRestore::parameters.body,
  "The definition for completing the restore of this managed database."
);
@@doc(ManagedDatabases.startMove::parameters.body,
  "Parameters of the start managed database move operation."
);
@@doc(ManagedDatabases.managedDatabaseSensitivityLabelsUpdate::parameters.body,
  ""
);
@@doc(ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate::parameters.body,
  ""
);
