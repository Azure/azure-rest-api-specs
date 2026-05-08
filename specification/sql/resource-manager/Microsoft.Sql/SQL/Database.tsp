import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * A database resource.
 */
@parentResource(Server)
model Database is Azure.ResourceManager.TrackedResource<DatabaseProperties> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = ""
  >;

  /**
   * The database SKU.
   *
   * The list of SKUs may vary by region and support offer. To determine the SKUs (including the SKU name, tier/edition, family, and capacity) that are available to your subscription in an Azure region, use the `Capabilities_ListByLocation` REST API or one of the following commands:
   *
   * ```azurecli
   * az sql db list-editions -l <location> -o table
   * ```
   *
   * ```powershell
   * Get-AzSqlServerServiceObjective -Location <location>
   * ```
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * Kind of database. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource that manages the database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  managedBy?: string;

  /**
   * The Azure Active Directory identity of the database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: DatabaseIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface Databases {
  /**
   * Gets a database.
   */
  @tag("Databases")
  get is ArmResourceRead<
    Database,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Creates a new database or updates an existing database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @tag("Databases")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Database,
    Response = ArmResourceUpdatedResponse<Database> | ArmResourceCreatedResponse<
      Database,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = Database>
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing database.
   */
  @patch(#{ implicitOptionality: false })
  @tag("Databases")
  update is ArmCustomPatchAsync<Database, PatchModel = DatabaseUpdate>;

  /**
   * Deletes the database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Databases")
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of databases.
   */
  @tag("Databases")
  listByServer is ArmResourceListByParent<
    Database,
    Parameters = {
      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      @added(Versions.v2025_02_01_preview)
      $top?: int64;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      @added(Versions.v2025_02_01_preview)
      $skip?: int64;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      @added(Versions.v2025_02_01_preview)
      $filter?: string;

      /**
       * How the results should be ordered.
       */
      @query("$orderby")
      @added(Versions.v2025_02_01_preview)
      $orderby?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @removed(Versions.v2025_02_01_preview)
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * List database columns
   */
  @tag("DatabaseColumns")
  @list
  @get
  @action("columns")
  listByDatabase is ArmResourceActionSync<
    Database,
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
   * Revalidates an existing encryption protector for a particular database.
   */
  @tag("DatabaseEncryptionProtectorRevalidate")
  revalidate is ArmResourceActionAsyncBase<
    Database,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>,
    Response = OkResponse | ArmAcceptedLroResponse,
    Parameters = {
      /**
       * The name of the encryption protector to be updated.
       */
      @path
      @segment("encryptionProtector")
      encryptionProtectorName: EncryptionProtectorName;
    }
  >;

  /**
   * Reverts an existing encryption protector for a particular database.
   */
  @tag("DatabaseEncryptionProtectorRevert")
  revert is ArmResourceActionAsyncBase<
    Database,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>,
    Response = OkResponse | ArmAcceptedLroResponse,
    Parameters = {
      /**
       * The name of the encryption protector to be updated.
       */
      @path
      @segment("encryptionProtector")
      encryptionProtectorName: EncryptionProtectorName;
    }
  >;

  /**
   * Gets a list of operations performed on the database.
   */
  @tag("DatabaseOperations")
  @list
  @get
  @action("operations")
  databaseOperationsListByDatabase is ArmResourceActionSync<
    Database,
    void,
    ArmResponse<ResourceListResult<DatabaseOperation>>
  >;

  /**
   * Cancels the asynchronous operation on the database.
   */
  @tag("DatabaseOperations")
  cancel is ArmResourceActionSync<
    Database,
    void,
    OkResponse,
    Parameters = {
      /**
       * The operation identifier.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("operations")
      operationId: Azure.Core.uuid;
    }
  >;

  /**
   * Exports a database.
   */
  @tag("Databases")
  export is ArmResourceActionAsync<
    Database,
    ExportDatabaseDefinition,
    Response = ImportExportOperationResult
  >;

  /**
   * Failovers a database.
   */
  @tag("Databases")
  failover is ArmResourceActionAsyncBase<
    Database,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>,
    Response = OkResponse | ArmAcceptedLroResponse,
    Parameters = {
      /**
       * The type of replica to be failed over.
       */
      @query("replicaType")
      replicaType?: ReplicaType;
    }
  >;

  /**
   * Imports a bacpac into a new database.
   */
  @action("import")
  @tag("Databases")
  importDatabase is ArmResourceActionAsync<
    Database,
    ImportExistingDatabaseDefinition,
    Response = ImportExportOperationResult
  >;

  /**
   * Renames a database.
   */
  @action("move")
  @tag("Databases")
  rename is ArmResourceActionSync<Database, ResourceMoveDefinition, OkResponse>;

  /**
   * Pauses a database.
   */
  @tag("Databases")
  pause is ArmResourceActionAsync<Database, void, Response = Database>;

  /**
   * Resumes a database.
   */
  @tag("Databases")
  resume is ArmResourceActionAsync<Database, void, Response = Database>;

  /**
   * Upgrades a data warehouse.
   */
  @tag("Databases")
  upgradeDataWarehouse is ArmResourceActionAsyncBase<
    Database,
    void,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Gets database usages.
   */
  @tag("DatabaseUsages")
  @list
  @get
  @action("usages")
  databaseUsagesListByDatabase is ArmResourceActionSync<
    Database,
    void,
    ArmResponse<ResourceListResult<DatabaseUsage>>
  >;

  /**
   * Creates a restore point for a data warehouse.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("RestorePoints")
  @action("restorePoints")
  create is ArmResourceActionAsyncBase<
    Database,
    Request = CreateDatabaseRestorePointDefinition,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>,
    Response = ArmResponse<RestorePoint> | ArmResourceCreatedResponse<
      RestorePoint,
      LroHeaders = ArmLroLocationHeader<FinalResult = RestorePoint>
    > | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RestorePoint>>
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  @tag("SensitivityLabels")
  @list
  @get
  @action("currentSensitivityLabels")
  listCurrentByDatabase is ArmResourceActionSync<
    Database,
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
  @tag("SensitivityLabels")
  @patch
  @action("currentSensitivityLabels")
  sensitivityLabelsUpdate is ArmResourceActionSync<
    Database,
    SensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  @tag("SensitivityLabels")
  @list
  @get
  @action("recommendedSensitivityLabels")
  listRecommendedByDatabase is ArmResourceActionSync<
    Database,
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
  @tag("SensitivityLabels")
  @patch
  @action("recommendedSensitivityLabels")
  recommendedSensitivityLabelsUpdate is ArmResourceActionSync<
    Database,
    RecommendedSensitivityLabelUpdateList,
    OkResponse
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  @tag("SensitivityLabels")
  @list
  @get
  @action("sensitivityLabels")
  sensitivityLabelsListByDatabase is ArmResourceActionSync<
    Database,
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
   * Gets all synapselink workspaces for a database.
   */
  @tag("SynapseLinkWorkspaces")
  @list
  @get
  @action("linkWorkspaces")
  synapseLinkWorkspacesListByDatabase is ArmResourceActionSync<
    Database,
    void,
    ArmResponse<ResourceListResult<SynapseLinkWorkspace>>
  >;
}

@@doc(Database.name, "The name of the database.");
@@doc(Database.properties, "Resource properties.");
@@doc(Databases.createOrUpdate::parameters.resource,
  "The requested database resource state."
);
@@doc(Databases.update::parameters.properties,
  "The requested database resource state."
);
@@doc(Databases.export::parameters.body,
  "The database export request parameters."
);
@@doc(Databases.importDatabase::parameters.body,
  "The database import request parameters."
);
@@doc(Databases.rename::parameters.body,
  "The resource move definition for renaming this database."
);
@@doc(Databases.create::parameters.body,
  "The definition for creating the restore point of this database."
);
@@doc(Databases.sensitivityLabelsUpdate::parameters.body, "");
@@doc(Databases.recommendedSensitivityLabelsUpdate::parameters.body, "");
