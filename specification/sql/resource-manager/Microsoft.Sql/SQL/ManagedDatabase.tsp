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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  get is ArmResourceRead<ManagedDatabase>;

  /**
   * Creates a new database or updates an existing database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedDatabase,
    Response =
      | ArmResourceUpdatedResponse<ManagedDatabase>
      | ArmResourceCreatedResponse<
          ManagedDatabase,
          ArmLroLocationHeader<FinalResult = ManagedDatabase> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  update is ArmCustomPatchAsync<
    ManagedDatabase,
    PatchModel = ManagedDatabaseUpdate
  >;

  /**
   * Deletes a managed database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedDatabase,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of managed databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  listByInstance is ArmResourceListByParent<ManagedDatabase>;

  /**
   * List managed database columns
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseColumns")
  @list
  @get
  @action("columns")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabaseColumns)
  listByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<DatabaseColumn>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "schema", explode: true })
      schema?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "table", explode: true })
      table?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query(#{ name: "column", explode: true })
      column?: string[];

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  cancelMove is ArmResourceActionAsyncBase<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ManagedDatabase>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Completes a managed database move operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  completeMove is ArmResourceActionAsyncBase<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ManagedDatabase>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Completes the restore operation on a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  completeRestore is ArmResourceActionAsyncBase<
    ManagedDatabase,
    CompleteDatabaseRestoreDefinition,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ManagedDatabase>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Reevaluates the inaccessibility state of a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  reevaluateInaccessibleDatabaseState is ArmResourceActionAsync<
    ManagedDatabase,
    void,
    Response = ManagedDatabase
  >;

  /**
   * Starts a managed database move operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabases)
  startMove is ArmResourceActionAsyncBase<
    ManagedDatabase,
    ManagedDatabaseStartMoveDefinition,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ManagedDatabase>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Gets a list of security events.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSecurityEvents")
  @list
  @get
  @action("securityEvents")
  @Azure.ResourceManager.Legacy.feature(Features.ManagedDatabaseSecurityEvents)
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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  @list
  @get
  @action("currentSensitivityLabels")
  @Azure.ResourceManager.Legacy.feature(
    Features.ManagedDatabaseSensitivityLabels
  )
  listCurrentByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("$skipToken")
      $skipToken?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@typespec/http/patch-implicit-optional" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  @patch
  @action("currentSensitivityLabels")
  @Azure.ResourceManager.Legacy.feature(
    Features.ManagedDatabaseSensitivityLabels
  )
  managedDatabaseSensitivityLabelsUpdate is ArmResourceActionSync<
    ManagedDatabase,
    SensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  @list
  @get
  @action("recommendedSensitivityLabels")
  @Azure.ResourceManager.Legacy.feature(
    Features.ManagedDatabaseSensitivityLabels
  )
  listRecommendedByDatabase is ArmResourceActionSync<
    ManagedDatabase,
    void,
    ArmResponse<ResourceListResult<SensitivityLabel>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@typespec/http/patch-implicit-optional" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  @patch
  @action("recommendedSensitivityLabels")
  @Azure.ResourceManager.Legacy.feature(
    Features.ManagedDatabaseSensitivityLabels
  )
  managedDatabaseRecommendedSensitivityLabelsUpdate is ArmResourceActionSync<
    ManagedDatabase,
    RecommendedSensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  @list
  @get
  @action("sensitivityLabels")
  @Azure.ResourceManager.Legacy.feature(
    Features.ManagedDatabaseSensitivityLabels
  )
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
@@doc(
  ManagedDatabases.createOrUpdate::parameters.resource,
  "The requested database resource state."
);
@@doc(
  ManagedDatabases.update::parameters.properties,
  "The requested database resource state."
);
@@doc(
  ManagedDatabases.cancelMove::parameters.body,
  "Parameters of the cancel managed database move operation."
);
@@doc(
  ManagedDatabases.completeMove::parameters.body,
  "Parameters of the complete managed database move operation."
);
@@doc(
  ManagedDatabases.completeRestore::parameters.body,
  "The definition for completing the restore of this managed database."
);
@@doc(
  ManagedDatabases.startMove::parameters.body,
  "Parameters of the start managed database move operation."
);
@@doc(
  ManagedDatabases.managedDatabaseSensitivityLabelsUpdate::parameters.body,
  ""
);
@@doc(
  ManagedDatabases.managedDatabaseRecommendedSensitivityLabelsUpdate::parameters.body,
  ""
);
