import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AlertRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Action for alert rule.
 */
@parentResource(AlertRule)
model ActionResponse
  is Azure.ResourceManager.ProxyResource<ActionResponseProperties> {
  ...ResourceNameParameter<
    Resource = ActionResponse,
    KeyName = "actionId",
    SegmentName = "actions",
    NamePattern = ""
  >;

  /**
   * Etag of the action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias actionWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface ActionResponses {
  /**
   * Gets the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_Get")
  get is ArmResourceRead<ActionResponse>;

  /**
   * Creates or updates the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_CreateOrUpdate")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    ActionResponse,
    Request = ActionRequest
  >;

  /**
   * Delete the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_Delete")
  delete is ArmResourceDeleteSync<ActionResponse>;

  /**
   * Gets all actions of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_ListByAlertRule")
  listByAlertRule is ArmResourceListByParent<
    ActionResponse,
    Response = ArmResponse<ActionsList>
  >;
}

@@doc(ActionResponse.name, "Action ID");
@@doc(ActionResponse.properties, "Action properties for get request");
@@doc(ActionResponses.createOrUpdate::parameters.resource, "The action");
