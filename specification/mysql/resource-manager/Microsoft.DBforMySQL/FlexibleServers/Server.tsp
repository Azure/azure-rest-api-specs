import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * Represents a server.
 */
model Server is Azure.ResourceManager.TrackedResource<ServerProperties> {
  /**
   * The name of the server.
   */
  @key("serverName")
  @path
  @segment("flexibleServers")
  @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
  @minLength(1)
  @maxLength(63)
  name: string;

  /**
   * The cmk identity for the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: MySQLServerIdentity;

  /**
   * The SKU (pricing tier) of the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: MySQLServerSku;
}

@armResourceOperations
interface Servers {
  /**
   * Gets information about a server.
   */
  get is ArmResourceRead<Server>;

  /**
   * Creates a new server or updates an existing server. The update action will overwrite the existing server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmResourceUpdatedResponse<Server> | ArmResourceCreatedResponse<
      Server,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing server. The request body can contain one to many of the properties present in the normal server definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Server, PatchModel = ServerForUpdate>;

  /**
   * Deletes a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all the servers in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Server,
    Response = ArmResponse<ServerListResult>
  >;

  /**
   * List all the servers in a given subscription.
   */
  list is ArmListBySubscription<
    Server,
    Response = ArmResponse<ServerListResult>
  >;

  /**
   * Exports the backup of the given server by creating a backup if not existing.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("backupAndExport")
  @operationId("BackupAndExport_Create")
  backupAndExportCreate is ArmResourceActionAsync<
    Server,
    BackupAndExportRequest,
    BackupAndExportResponse
  >;

  /**
   * Validates if backup can be performed for given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupAndExport_ValidateBackup")
  validateBackup is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ValidateBackupResponse>
  >;

  /**
   * Manual failover a server.
   */
  failover is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Validate a deployment of high availability.
   */
  validateEstimateHighAvailability is ArmResourceActionSync<
    Server,
    HighAvailabilityValidationEstimation,
    ArmResponse<HighAvailabilityValidationEstimation>
  >;

  /**
   * Restarts a server.
   */
  restart is ArmResourceActionAsyncBase<
    Server,
    ServerRestartParameter,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Starts a server.
   */
  start is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Resets GTID on a server.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  resetGtid is ArmResourceActionAsyncBase<
    Server,
    ServerGtidSetParameter,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Detach VNet on a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @Azure.Core.useFinalStateVia("azure-async-operation")
  detachVNet is ArmResourceActionAsync<
    Server,
    ServerDetachVNetParameter,
    ArmResponse<Server>,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * List all the replicas for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("replicas")
  @operationId("Replicas_ListByServer")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    Response = ArmResponse<ServerListResult>
  >;

  /**
   * Cutover migration for MySQL import, it will switch source elastic server DNS to flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServersMigration_CutoverMigration")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cutoverMigration is ArmResourceActionAsync<
    Server,
    void,
    ArmResponse<Server>,
    LroHeaders = ArmAsyncOperationHeader & ArmLroLocationHeader
  >;

  /**
   * List all the server log files in a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("logFiles")
  @operationId("LogFiles_ListByServer")
  logFilesListByServer is ArmResourceActionSync<
    Server,
    void,
    Response = ArmResponse<LogFileListResult>
  >;
}

@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Properties of the server.");
@@doc(Servers.create::parameters.resource,
  "The required parameters for creating or updating a server."
);
@@doc(Servers.update::parameters.properties,
  "The required parameters for updating a server."
);
@@doc(Servers.backupAndExportCreate::parameters.body,
  "The required parameters for creating and exporting backup of the given server."
);
@@doc(Servers.validateEstimateHighAvailability::parameters.body,
  "The required parameters for validation of high availability deployment."
);
@@doc(Servers.restart::parameters.body,
  "The required parameters for restarting a server."
);
@@doc(Servers.resetGtid::parameters.body,
  "The required parameters for resetting GTID on a server."
);
@@doc(Servers.detachVNet::parameters.body,
  "The required parameters for detach vnet on a server."
);
