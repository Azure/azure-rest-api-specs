import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("An Azure SQL Database server.")
model Server is TrackedResource<ServerProperties> {
  @doc("The name of the server.")
  @path
  @key("serverName")
  @segment("servers")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Servers {
  @doc("Gets a server.")
  get is ArmResourceRead<
    Server,
    {
      ...BaseParameters<Server>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Creates or updates a server.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Server>;

  @doc("Updates a server.")
  update is ArmCustomPatchAsync<Server, ServerUpdate>;

  @doc("Deletes a server.")
  delete is ArmResourceDeleteAsync<Server>;

  @doc("Gets a list of servers in a resource groups.")
  listByResourceGroup is ArmResourceListByParent<
    Server,
    {
      ...BaseParameters<Server>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Gets a list of all servers in the subscription.")
  list is ArmListBySubscription<Server>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a TDE certificate for a given server.")
  @operationId("TdeCertificates_Create")
  create is ArmResourceActionAsync<Server, TdeCertificate, void>;

  @doc("Imports a bacpac into a new database.")
  importDatabase is ArmResourceActionAsync<
    Server,
    ImportNewDatabaseDefinition,
    ImportExportOperationResult
  >;

  @doc("Refresh external governance enablement status.")
  refreshStatus is ArmResourceActionAsync<
    Server,
    void,
    RefreshExternalGovernanceStatusOperationResult,
    BaseParameters<Server>,
    ArmLroLocationHeader
  >;

  @doc("Determines whether a resource can be created with the specified name.")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityRequest,
    SqlNameAvailabilityResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerUsages_ListByServer")
  @doc("Returns server usages.")
  // FIXME: ServerUsages_ListByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/usages")
  @get
  listByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;
    },
    ServerUsageListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerOperations_ListByServer")
  @doc("Gets a list of operations performed on the server.")
  // FIXME: ServerOperations_ListByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/operations")
  @get
  listByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ServerOperationListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReplicationLinks_ListByServer")
  @doc("Gets a list of replication links.")
  // FIXME: ReplicationLinks_ListByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/replicationLinks")
  @get
  listByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ReplicationLink>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Databases_ListInaccessibleByServer")
  @doc("Gets a list of inaccessible databases in a logical server")
  // FIXME: Databases_ListInaccessibleByServer could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/inaccessibleDatabases")
  @get
  listInaccessibleByServer is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<Database>
  >;
}

@@projectedName(Servers.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Servers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Servers.createOrUpdate::parameters.resource,
  "The requested server resource state."
);
@@projectedName(Servers.update::parameters.properties, "json", "parameters");
@@extension(Servers.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Servers.update::parameters.properties,
  "The requested server resource state."
);
@@projectedName(Servers.create::parameters.body, "json", "parameters");
@@extension(Servers.create::parameters.body, "x-ms-client-name", "parameters");
@@doc(Servers.create::parameters.body,
  "The requested TDE certificate to be created or updated."
);
@@projectedName(Servers.importDatabase::parameters.body, "json", "parameters");
@@extension(Servers.importDatabase::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Servers.importDatabase::parameters.body,
  "The database import request parameters."
);
