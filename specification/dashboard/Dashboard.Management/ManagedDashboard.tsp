import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The managed dashboard resource type.
 */
model ManagedDashboard
  is Azure.ResourceManager.TrackedResource<ManagedDashboardProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDashboard,
    KeyName = "dashboardName",
    SegmentName = "dashboards",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface ManagedDashboards {
  /**
   * Get the properties of a specific dashboard for grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Dashboards_Get")
  get is ArmResourceRead<ManagedDashboard>;

  /**
   * Create or update a dashboard for grafana resource. This API is idempotent, so user can either create a new dashboard or update an existing dashboard.
   */
  create is ArmResourceCreateOrReplaceAsync<ManagedDashboard>;

  /**
   * Update a dashboard for Grafana resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ManagedDashboard,
    PatchModel = ManagedDashboardUpdateParameters
  >;

  /**
   * Delete a dashboard for Grafana resource.
   */
  delete is ArmResourceDeleteSync<ManagedDashboard>;

  /**
   * List all resources of dashboards under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Dashboards_List")
  list is ArmResourceListByParent<
    ManagedDashboard,
    Response = ArmResponse<ManagedDashboardListResponse>
  >;

  /**
   * List all resources of dashboards under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Dashboards_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    ManagedDashboard,
    Response = ArmResponse<ManagedDashboardListResponse>
  >;
}

@@doc(ManagedDashboard.name, "The name of the Azure Managed Dashboard.");
@@doc(ManagedDashboard.properties,
  "Properties specific to the managed dashboard resource."
);
@@doc(ManagedDashboards.create::parameters.resource, "");
@@doc(ManagedDashboards.update::parameters.properties, "");
