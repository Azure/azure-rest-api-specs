import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DBforPostgreSQL;
/**
 * Properties of a server.
 */
model Server is Azure.ResourceManager.TrackedResource<ServerProperties> {
  ...ResourceNameParameter<
    Resource = Server,
    KeyName = "serverName",
    SegmentName = "flexibleServers",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;

  /**
   * Compute tier and size of a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;

  /**
   * User assigned managed identities assigned to the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: UserAssignedIdentity;
}

alias RequestIdResponseHeader = {
  @header("x-ms-request-id")
  @doc("A unique ID for the current operation, service generated. All the resource providers must return this value in the response headers to facilitate debugging.")
  requestId?: string;
};

@armResourceOperations
interface Servers {
  /**
   * Gets information about an existing server.
   */
  get is ArmResourceRead<Server>;

  /**
   * Creates a new server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Server> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates an existing server. The request body can contain one or multiple of the properties present in the normal server definition.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Server,
    PatchModel = ServerForPatch,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Server> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes or drops an existing server.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all servers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Server,
    Response = ArmResponse<ServerList>
  >;

  /**
   * Lists all servers in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Server,
    Response = ArmResponse<ServerList>
  >;

  /**
   * Lists the capabilities available for a given server.
   */
  @list
  @get
  @action("capabilities")
  list is ArmResourceActionSync<Server, void, ArmResponse<CapabilityList>>;

  /**
   * Lists all captured logs for download in a server.
   */
  @get
  @list
  @action("logFiles")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<CapturedLogList>
  >;

  /**
   * Performs all checks required for a long term retention backup operation to succeed.
   */
  @action("ltrPreBackup")
  checkPrerequisites is ArmResourceActionAsyncBase<
    Server,
    LtrPreBackupRequest,
    Response = LtrPreBackupResponse & RequestIdResponseHeader,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    Error = CustomErrorResponse
  >;

  /**
   * Initiates a long term retention backup.
   */
  @action("startLtrBackup")
  start is ArmResourceActionAsyncBase<
    Server,
    BackupsLongTermRetentionRequest,
    (BackupsLongTermRetentionResponse &
      RequestIdResponseHeader) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = BackupsLongTermRetentionResponse> &
      Azure.Core.Foundations.RetryAfterHeader> &
      RequestIdResponseHeader),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    Error = CustomErrorResponse
  >;

  /**
   * Checks if a proposed migration name is valid and available.
   */
  @action("checkMigrationNameAvailability")
  @summary("Check the validity and availability of the given name, to assign it to a new migration.")
  checkNameAvailability is ArmResourceActionSync<
    Server,
    MigrationNameAvailability,
    ArmResponse<MigrationNameAvailability>
  >;

  /**
   * Lists all read replicas of a server.
   */
  @get
  @list
  @action("replicas")
  replicasListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ServerList>
  >;

  /**
   * Restarts PostgreSQL database engine in a server.
   */
  restart is ArmResourceActionAsyncBase<
    Server,
    RestartParameter,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    OptionalRequestBody = true
  >;

  /**
   * Starts a stopped server.
   */
  @action("start")
  serversStart is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  /**
   * Migrates the network configuration of a PostgreSQL flexible server from customer owned VNET to Microsoft owned VNET with support for private endpoints, or from Microsoft owned VNET with no support for private endpoints to Microsoft owned VNET with support for private endpoints.
   */
  @added(Versions.v2026_01_01)
  @action("migrateNetwork")
  migrateNetworkMode is ArmResourceActionAsyncBase<
    Server,
    void,
    (MigrateNetworkStatus &
      RequestIdResponseHeader) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrateNetworkStatus> &
      Azure.Core.Foundations.RetryAfterHeader> &
      RequestIdResponseHeader),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;
}

@@maxLength(Server.name, 63);
@@minLength(Server.name, 3);
@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Properties of a server.");
@@doc(Servers.createOrUpdate::parameters.resource,
  "Parameters required to create a new server or to update an existing server."
);
@@doc(Servers.update::parameters.properties,
  "Parameters required to update a server."
);
@@doc(Servers.checkPrerequisites::parameters.body,
  "Request body for operation"
);
@@doc(Servers.start::parameters.body, "Request body for operation");
@@doc(Servers.checkNameAvailability::parameters.body,
  "Parameters required to check if a migration name is valid and available."
);
@@doc(Servers.restart::parameters.body, "Parameters to restart a server.");
@@doc(Servers.migrateNetworkMode::parameters.body,
  "Parameters to migrate the network configuration of a server."
);
