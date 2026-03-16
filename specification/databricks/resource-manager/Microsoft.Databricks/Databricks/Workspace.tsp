import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Databricks;
/**
 * Information about workspace.
 */
model Workspace
  is Azure.ResourceManager.TrackedResource<WorkspaceProperties, false> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = ""
  >;

  /**
   * The SKU of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets the workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Creates a new workspace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    LroHeaders = ArmLroLocationHeader<FinalResult = Workspace> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a workspace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Workspace, PatchModel = WorkspaceUpdate>;

  /**
   * Deletes the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Parameters = {
      /**
       * Optional parameter to retain default unity catalog data. By default the data will retained if Uc is enabled on the workspace.
       */
      @query("forceDeletion")
      forceDeletion?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the workspaces within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Gets all the workspaces within a subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;

  /**
   * Gets the list of endpoints that VNET Injected Workspace calls Azure Databricks Control Plane. You must configure outbound access with these endpoints. For more information, see https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/udr
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OutboundNetworkDependenciesEndpoints_List")
  @get
  @action("outboundNetworkDependenciesEndpoints")
  list is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<OutboundEnvironmentEndpoint[]>
  >;
}

@@maxLength(Workspace.name, 64);
@@minLength(Workspace.name, 3);
@@doc(Workspace.name, "The name of the workspace.");
@@doc(Workspace.properties, "The workspace properties.");
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update a workspace."
);
@@doc(Workspaces.update::parameters.properties, "The update to the workspace.");
