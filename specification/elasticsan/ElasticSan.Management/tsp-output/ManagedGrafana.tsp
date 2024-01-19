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

namespace Microsoft.Dashboard;
@doc("The grafana resource type.")
model ManagedGrafana is TrackedResource<ManagedGrafanaProperties> {
  @doc("The workspace name of Azure Managed Grafana.")
  @path
  @key("workspaceName")
  @segment("grafana")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ManagedGrafanas {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the properties of a specific workspace for Grafana resource.")
  @operationId("Grafana_Get")
  get is ArmResourceRead<ManagedGrafana>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a workspace for Grafana resource. This API is idempotent, so user can either create a new grafana or update an existing grafana.")
  @operationId("Grafana_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ManagedGrafana,
    BaseParameters<ManagedGrafana>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a workspace for Grafana resource.")
  @operationId("Grafana_Update")
  update is ArmCustomPatchSync<ManagedGrafana, ManagedGrafanaUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a workspace for Grafana resource.")
  @operationId("Grafana_Delete")
  delete is ArmResourceDeleteAsync<
    ManagedGrafana,
    BaseParameters<ManagedGrafana>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all resources of workspaces for Grafana under the specified resource group.")
  @operationId("Grafana_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ManagedGrafana>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all resources of workspaces for Grafana under the specified subscription.")
  @operationId("Grafana_List")
  list is ArmListBySubscription<ManagedGrafana>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve enterprise add-on details information")
  @operationId("Grafana_CheckEnterpriseDetails")
  checkEnterpriseDetails is ArmResourceActionSync<
    ManagedGrafana,
    void,
    EnterpriseDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_FetchAvailablePlugins")
  fetchAvailablePlugins is ArmResourceActionSync<
    ManagedGrafana,
    void,
    GrafanaAvailablePluginListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refresh and sync managed private endpoints of a grafana resource to latest state.")
  @operationId("ManagedPrivateEndpoints_Refresh")
  refresh is ArmResourceActionAsync<
    ManagedGrafana,
    void,
    void,
    BaseParameters<ManagedGrafana>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ManagedGrafanas.create::parameters.resource,
  "json",
  "requestBodyParameters"
);
@@extension(ManagedGrafanas.create::parameters.resource,
  "x-ms-client-name",
  "requestBodyParameters"
);
@@doc(ManagedGrafanas.create::parameters.resource, "");
@@projectedName(ManagedGrafanas.update::parameters.properties,
  "json",
  "requestBodyParameters"
);
@@extension(ManagedGrafanas.update::parameters.properties,
  "x-ms-client-name",
  "requestBodyParameters"
);
@@doc(ManagedGrafanas.update::parameters.properties, "");
