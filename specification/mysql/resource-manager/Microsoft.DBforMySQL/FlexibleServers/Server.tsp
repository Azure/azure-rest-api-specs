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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: MySQLServerIdentity;

  /**
   * The SKU (pricing tier) of the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmResourceUpdatedResponse<Server> | ArmResourceCreatedResponse<
      Server,
      ArmLroLocationHeader<FinalResult = Server> &
        Azure.Core.Foundations.RetryAfterHeader
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * Manual failover a server.
   */
  failover is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
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
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Starts a server.
   */
  start is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsyncBase<
    Server,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
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
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Detach VNet on a server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  detachVNet is ArmResourceActionAsync<
    Server,
    ServerDetachVNetParameter,
    ArmResponse<Server>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Server> &
      ArmLroLocationHeader
  >;
}

@armResourceOperations
interface BackupAndExport {
  /**
   * Exports the backup of the given server by creating a backup if not existing.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("backupAndExport")
  create is ArmResourceActionAsync<
    Server,
    BackupAndExportRequest,
    BackupAndExportResponse
  >;

  /**
   * Validates if backup can be performed for given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validateBackup is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ValidateBackupResponse>
  >;
}

@armResourceOperations
interface LogFiles {
  /**
   * List all the server log files in a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @list
  @get
  @action("logFiles")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    Response = ArmResponse<LogFileListResult>
  >;
}

@armResourceOperations
interface ServersMigration {
  /**
   * Cutover migration for MySQL import, it will switch source elastic server DNS to flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cutoverMigration is ArmResourceActionAsync<
    Server,
    void,
    ArmResponse<Server>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = Server> &
      ArmLroLocationHeader
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
@@doc(BackupAndExport.create::parameters.body,
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
