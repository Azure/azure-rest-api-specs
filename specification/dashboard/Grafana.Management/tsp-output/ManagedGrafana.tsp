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
/**
 * The grafana resource type.
 */
model ManagedGrafana is TrackedResource<ManagedGrafanaProperties> {
  /**
   * The workspace name of Azure Managed Grafana.
   */
  @path
  @key("workspaceName")
  @segment("grafana")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ManagedGrafanas {
  /**
   * Get the properties of a specific workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_Get")
  get is ArmResourceRead<ManagedGrafana>;

  /**
   * Create or update a workspace for Grafana resource. This API is idempotent, so user can either create a new grafana or update an existing grafana.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ManagedGrafana,
    BaseParameters<ManagedGrafana>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Grafana_Update")
  update is ArmCustomPatchSync<ManagedGrafana, ManagedGrafanaUpdateParameters>;

  /**
   * Delete a workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_Delete")
  delete is ArmResourceDeleteAsync<
    ManagedGrafana,
    BaseParameters<ManagedGrafana>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all resources of workspaces for Grafana under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ManagedGrafana>;

  /**
   * List all resources of workspaces for Grafana under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Grafana_List")
  list is ArmListBySubscription<ManagedGrafana>;

  /**
   * Retrieve enterprise add-on details information
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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

  /**
   * Refresh and sync managed private endpoints of a grafana resource to latest state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
