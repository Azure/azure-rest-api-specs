import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database server.
 */
model Server is Azure.ResourceManager.TrackedResource<ServerProperties> {
  ...ResourceNameParameter<
    Resource = Server,
    KeyName = "serverName",
    SegmentName = "servers",
    NamePattern = ""
  >;

  /**
   * The Azure Active Directory identity of the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ResourceIdentity;

  /**
   * Kind of sql server. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface Servers {
  /**
   * Gets a server.
   */
  get is ArmResourceRead<
    Server,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Server,
    Response = ArmResourceUpdatedResponse<Server> | ArmResourceCreatedResponse<
      Server,
      ArmLroLocationHeader<FinalResult = Server> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a server.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Server, PatchModel = ServerUpdate>;

  /**
   * Deletes a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of servers in a resource groups.
   */
  listByResourceGroup is ArmResourceListByParent<
    Server,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets a list of all servers in the subscription.
   */
  list is ArmListBySubscription<
    Server,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets a list of inaccessible databases in a logical server
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Databases_ListInaccessibleByServer")
  @list
  @get
  @action("inaccessibleDatabases")
  listInaccessibleByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<Database>>
  >;

  /**
   * Replaces all firewall rules on the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FirewallRules_Replace")
  @put
  @action("firewallRules")
  replace is ArmResourceActionSync<
    Server,
    FirewallRuleList,
    ArmResponse<FirewallRule> | AcceptedResponse
  >;

  /**
   * Gets a list of replication links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationLinks_ListByServer")
  @list
  @get
  @action("replicationLinks")
  listByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ReplicationLink>>
  >;

  /**
   * Gets a list of operations performed on the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerOperations_ListByServer")
  @list
  @get
  @action("operations")
  serverOperationsListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ServerOperation>>
  >;

  /**
   * Imports a bacpac into a new database.
   */
  @action("import")
  importDatabase is ArmResourceActionAsync<
    Server,
    ImportNewDatabaseDefinition,
    ArmResponse<ImportExportOperationResult>
  >;

  /**
   * Refresh external governance enablement status.
   */
  @action("refreshExternalGovernanceStatus")
  refreshStatus is ArmResourceActionAsync<
    Server,
    void,
    ArmResponse<RefreshExternalGovernanceStatusOperationResult>
  >;

  /**
   * Gets server usages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerUsages_ListByServer")
  @list
  @get
  @action("usages")
  serverUsagesListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ServerUsage>>
  >;

  /**
   * Creates a TDE certificate for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TdeCertificates_Create")
  @action("tdeCertificates")
  create is ArmResourceActionAsync<Server, TdeCertificate, OkResponse>;
}

@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Resource properties.");
@@doc(Servers.createOrUpdate::parameters.resource,
  "The requested server resource state."
);
@@doc(Servers.update::parameters.properties,
  "The requested server resource state."
);
@@doc(Servers.replace::parameters.body, "");
@@doc(Servers.importDatabase::parameters.body,
  "The database import request parameters."
);
@@doc(Servers.create::parameters.body,
  "The requested TDE certificate to be created or updated."
);
