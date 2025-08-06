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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * User assigned managed identities assigned to the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: UserAssignedIdentity;
}

@armResourceOperations
interface Servers {
  /**
   * Gets information about an existing server.
   */
  get is ArmResourceRead<Server>;

  /**
   * Creates a new server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Updates an existing server. The request body can contain one or multiple of the properties present in the normal server definition.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Server,
    PatchModel = ServerForPatch,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Deletes or drops an existing server.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Server>;

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CapabilitiesByServer_List")
  @get
  @action("capabilities")
  list is ArmResourceActionSync<Server, void, ArmResponse<CapabilityList>>;

  /**
   * Lists all captured logs for download in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CapturedLogs_ListByServer")
  @get
  @action("logFiles")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<CapturedLogList>
  >;

  /**
   * Performs all checks required for a long term retention backup operation to succeed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsLongTermRetention_CheckPrerequisites")
  @action("ltrPreBackup")
  checkPrerequisites is ArmResourceActionSync<
    Server,
    LtrPreBackupRequest,
    ArmResponse<LtrPreBackupResponse>
  >;

  /**
   * Initiates a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsLongTermRetention_Start")
  @action("startLtrBackup")
  start is ArmResourceActionAsync<
    Server,
    BackupsLongTermRetentionRequest,
    ArmResponse<BackupsLongTermRetentionResponse>
  >;

  /**
   * Checks if a proposed migration name is valid and available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migrations_CheckNameAvailability")
  @action("checkMigrationNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    Server,
    MigrationNameAvailability,
    ArmResponse<MigrationNameAvailability>
  >;

  /**
   * Lists all read replicas of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Replicas_ListByServer")
  @get
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
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    OptionalRequestBody = true
  >;

  /**
   * Starts a stopped server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Servers_Start")
  @action("start")
  serversStart is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>
  >;

  /**
   * Stops a server.
   */
  stop is ArmResourceActionAsyncBase<
    Server,
    void,
    ArmAcceptedLroResponse,
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
