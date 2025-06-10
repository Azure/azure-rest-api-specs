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
 * The grafana resource type.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(ManagedGrafanaProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model ManagedGrafana extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = ManagedGrafana,
    KeyName = "workspaceName",
    SegmentName = "grafana",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;

  /**
   * The Sku of the grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: ManagedGrafanaProperties;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ManagedGrafanas {
  /**
   * Get the properties of a specific workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_Get")
  get is ArmResourceRead<ManagedGrafana>;

  /**
   * Create or update a workspace for Grafana resource. This API is idempotent, so user can either create a new grafana or update an existing grafana.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_Create")
  create is ArmResourceCreateOrReplaceAsync<ManagedGrafana>;

  /**
   * Update a workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("Grafana_Update")
  update is ArmCustomPatchSync<
    ManagedGrafana,
    PatchModel = ManagedGrafanaUpdateParameters,
    Response = ArmResponse<ManagedGrafana> | (AcceptedResponse & {
      @bodyRoot
      _: ManagedGrafana;
    })
  >;

  /**
   * Delete a workspace for Grafana resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Grafana_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedGrafana,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * List all resources of workspaces for Grafana under the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedGrafana,
    Response = ArmResponse<ManagedGrafanaListResponse>
  >;

  /**
   * List all resources of workspaces for Grafana under the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_List")
  list is ArmListBySubscription<
    ManagedGrafana,
    Response = ArmResponse<ManagedGrafanaListResponse>
  >;

  /**
   * Retrieve enterprise add-on details information
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_CheckEnterpriseDetails")
  checkEnterpriseDetails is ArmResourceActionSync<
    ManagedGrafana,
    void,
    ArmResponse<EnterpriseDetails>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Grafana_FetchAvailablePlugins")
  fetchAvailablePlugins is ArmResourceActionSync<
    ManagedGrafana,
    void,
    ArmResponse<GrafanaAvailablePluginListResponse>
  >;

  /**
   * Refresh and sync managed private endpoints of a grafana resource to latest state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("refreshManagedPrivateEndpoints")
  @operationId("ManagedPrivateEndpoints_Refresh")
  refresh is ArmResourceActionAsync<
    ManagedGrafana,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(ManagedGrafana.name, "The workspace name of Azure Managed Grafana.");
@@doc(ManagedGrafana.properties,
  "Properties specific to the grafana resource."
);
@@doc(ManagedGrafanas.create::parameters.resource, "");
@@doc(ManagedGrafanas.update::parameters.properties, "");
