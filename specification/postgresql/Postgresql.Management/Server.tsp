import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a server.
 */
model Server is Azure.ResourceManager.TrackedResource<ServerProperties> {
  ...ResourceNameParameter<
    Resource = Server,
    KeyName = "serverName",
    SegmentName = "flexibleServers",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;

  /**
   * The SKU (pricing tier) of the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * Describes the identity of the application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: UserAssignedIdentity;
}

@armResourceOperations
interface Servers {
  /**
   * Gets information about a server.
   */
  get is ArmResourceRead<Server>;

  /**
   * Creates a new server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmResourceUpdatedResponse<Server> | ArmResourceCreatedResponse<Server> | ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing server. The request body can contain one to many of the properties present in the normal server definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Server,
    PatchModel = ServerForUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the servers in a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Server>;

  /**
   * List all the servers in a given subscription.
   */
  list is ArmListBySubscription<Server>;

  /**
   * Get capabilities for a flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("capabilities")
  @operationId("ServerCapabilities_List")
  serverCapabilitiesList is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<CapabilitiesListResult>
  >;

  /**
   * Restarts a server.
   */
  restart is ArmResourceActionAsync<
    Server,
    {
      /**
       * The parameters for restarting a server.
       */
      @bodyRoot
      parameters?: RestartParameter;
    },
    OkResponse
  >;

  /**
   * Starts a server.
   */
  start is ArmResourceActionAsync<Server, void, OkResponse>;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsync<Server, void, OkResponse>;

  /**
   * PreBackup operation performs all the checks that are needed for the subsequent long term retention backup operation to succeed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("ltrPreBackup")
  @operationId("FlexibleServer_TriggerLtrPreBackup")
  triggerLtrPreBackup is ArmResourceActionSync<
    Server,
    LtrPreBackupRequest,
    ArmResponse<LtrPreBackupResponse>
  >;

  /**
   * Start the Long Term Retention Backup operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FlexibleServer_StartLtrBackup")
  startLtrBackup is ArmResourceActionAsync<
    Server,
    LtrBackupRequest,
    ArmResponse<LtrBackupResponse>
  >;

  /**
   * This method checks whether a proposed migration name is valid and available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CheckMigrationNameAvailability")
  checkMigrationNameAvailability is ArmResourceActionSync<
    Server,
    MigrationNameAvailabilityResource,
    ArmResponse<MigrationNameAvailabilityResource>,
    Parameters = {
      /**
       * The name of the target database server.
       */
      @pattern("([-a-z0-9]){3,63}")
      @path
      targetDbServerName: string;
    }
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
    ArmResponse<ResourceListResult<Server>>
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
    ArmResponse<ResourceListResult<LogFile>>
  >;
}

@@maxLength(Server.name, 63);
@@minLength(Server.name, 3);
@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Properties of the server.");
@@doc(Servers.create::parameters.resource,
  "The required parameters for creating or updating a server."
);
@@doc(Servers.update::parameters.properties,
  "The required parameters for updating a server."
);
@@doc(Servers.triggerLtrPreBackup::parameters.body,
  "Request body for operation"
);
@@doc(Servers.startLtrBackup::parameters.body, "Request body for operation");
@@doc(Servers.checkMigrationNameAvailability::parameters.body,
  "The required parameters for checking if a migration name is available."
);
