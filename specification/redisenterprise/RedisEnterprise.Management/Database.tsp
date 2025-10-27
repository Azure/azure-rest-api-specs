import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * Describes a database on the Redis Enterprise cluster
 */
@parentResource(Cluster)
model Database
  is Azure.ResourceManager.ProxyResource<DatabaseCreateProperties> {
  ...ResourceNameParameter<
    Resource = Database,
    KeyName = "databaseName",
    SegmentName = "databases",
    NamePattern = "^(?=.{1,60}$)[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface Databases {
  /**
   * Gets information about a database in a Redis Enterprise cluster.
   */
  get is ArmResourceRead<Database>;

  /**
   * Creates a database
   */
  create is ArmResourceCreateOrReplaceAsync<Database>;

  /**
   * Updates a database
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Database,
    PatchModel = DatabaseUpdate,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Database> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a single database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Database,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all databases in the specified Redis Enterprise cluster.
   */
  listByCluster is ArmResourceListByParent<
    Database,
    Response = ArmResponse<DatabaseList>
  >;

  /**
   * Retrieves the access keys for the Redis Enterprise database.
   */
  listKeys is ArmResourceActionSync<Database, void, ArmResponse<AccessKeys>>;

  /**
   * Regenerates the Redis Enterprise database's access keys.
   */
  regenerateKey is ArmResourceActionAsync<
    Database,
    RegenerateKeyParameters,
    ArmResponse<AccessKeys>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AccessKeys> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Imports database files to target database.
   */
  `import` is ArmResourceActionAsync<
    Database,
    ImportClusterParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Exports a database file from target database.
   */
  export is ArmResourceActionAsync<
    Database,
    ExportClusterParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Forcibly removes the link to the specified database resource.
   */
  forceUnlink is ArmResourceActionAsync<
    Database,
    ForceUnlinkParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Forcibly recreates an existing database on the specified cluster, and rejoins it to an existing replication group. **IMPORTANT NOTE:** All data in this database will be discarded, and the database will temporarily be unavailable while rejoining the replication group.
   */
  forceLinkToReplicationGroup is ArmResourceActionAsyncBase<
    Database,
    ForceLinkParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>
  >;

  /**
   * Flushes all the keys in this database and also from its linked databases.
   */
  flush is ArmResourceActionAsync<
    Database,
    FlushParameters,
    OkResponse,
    OptionalRequestBody = true
  >;

  /**
   * Upgrades the database Redis version to the latest available.
   */
  upgradeDBRedisVersion is ArmResourceActionAsyncBase<
    Database,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Database>
  >;
}

@@doc(Database.name, "The name of the Redis Enterprise database.");
@@doc(Database.properties, "Other properties of the database.");
@@doc(Databases.create::parameters.resource,
  "Parameters supplied to the create or update database operation."
);
@@doc(Databases.update::parameters.properties,
  "Parameters supplied to the create or update database operation."
);
@@doc(Databases.regenerateKey::parameters.body,
  "Specifies which key to regenerate."
);
@@doc(Databases.`import`::parameters.body,
  "Storage information for importing into the cluster"
);
@@doc(Databases.export::parameters.body,
  "Storage information for exporting into the cluster"
);
@@doc(Databases.forceUnlink::parameters.body,
  "Information identifying the database to be unlinked."
);
@@doc(Databases.forceLinkToReplicationGroup::parameters.body,
  "Information identifying the database to be unlinked."
);
@@doc(Databases.flush::parameters.body,
  "Information identifying the databases to be flushed"
);
