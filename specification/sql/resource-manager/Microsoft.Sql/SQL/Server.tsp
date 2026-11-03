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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.Servers)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ResourceIdentity;

  /**
   * Kind of sql server. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations(#{ omitTags: true })
interface Servers {
  /**
   * Gets a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Server,
    Response =
      | ArmResourceUpdatedResponse<Server>
      | ArmResourceCreatedResponse<
          Server,
          ArmLroLocationHeader<FinalResult = Server> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Updates a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
  update is ArmCustomPatchAsync<Server, PatchModel = ServerUpdate>;

  /**
   * Deletes a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
  delete is ArmResourceDeleteWithoutOkAsync<
    Server,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of servers in a resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
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
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Databases")
  @list
  @get
  @action("inaccessibleDatabases")
  @Azure.ResourceManager.Legacy.feature(Features.Databases)
  listInaccessibleByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<Database>>
  >;

  /**
   * Replaces all firewall rules on the server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("FirewallRules")
  @put
  @action("firewallRules")
  @Azure.ResourceManager.Legacy.feature(Features.FirewallRules)
  replace is ArmResourceActionSync<
    Server,
    FirewallRuleList,
    ArmResponse<FirewallRule> | AcceptedResponse
  >;

  /**
   * Gets a list of replication links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ReplicationLinks")
  @list
  @get
  @action("replicationLinks")
  @Azure.ResourceManager.Legacy.feature(Features.ReplicationLinks)
  listByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ReplicationLink>>
  >;

  /**
   * Gets a list of operations performed on the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServerOperations")
  @list
  @get
  @action("operations")
  @Azure.ResourceManager.Legacy.feature(Features.ServerOperations)
  serverOperationsListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ServerOperation>>
  >;

  /**
   * Imports a bacpac into a new database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @action("import")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
  importDatabase is ArmResourceActionAsync<
    Server,
    ImportNewDatabaseDefinition,
    Response = ImportExportOperationResult
  >;

  /**
   * Refresh external governance enablement status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Servers")
  @action("refreshExternalGovernanceStatus")
  @Azure.ResourceManager.Legacy.feature(Features.Servers)
  refreshStatus is ArmResourceActionAsync<
    Server,
    void,
    Response = RefreshExternalGovernanceStatusOperationResult
  >;

  /**
   * Gets server usages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ServerUsages")
  @list
  @get
  @action("usages")
  @Azure.ResourceManager.Legacy.feature(Features.ServerUsages)
  serverUsagesListByServer is ArmResourceActionSync<
    Server,
    void,
    ArmResponse<ResourceListResult<ServerUsage>>
  >;

  /**
   * Creates a TDE certificate for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("TdeCertificates")
  @action("tdeCertificates")
  @Azure.ResourceManager.Legacy.feature(Features.TdeCertificates)
  create is ArmResourceActionAsyncBase<
    Server,
    TdeCertificate,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Server>,
    Response = OkResponse | ArmAcceptedLroResponse
  >;
}

@@doc(Server.name, "The name of the server.");
@@doc(Server.properties, "Resource properties.");
@@doc(
  Servers.createOrUpdate::parameters.resource,
  "The requested server resource state."
);
@@doc(
  Servers.update::parameters.properties,
  "The requested server resource state."
);
@@doc(Servers.replace::parameters.body, "");
@@doc(
  Servers.importDatabase::parameters.body,
  "The database import request parameters."
);
@@doc(
  Servers.create::parameters.body,
  "The requested TDE certificate to be created or updated."
);
