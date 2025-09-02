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

@armResourceOperations
interface ActionResponses {
  /**
   * Gets the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_Get")
  get is Extension.Read<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_CreateOrUpdate")
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Delete the action of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_Delete")
  delete is Extension.DeleteSync<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Gets all actions of alert rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Actions_ListByAlertRule")
  listByAlertRule is Extension.ListByTarget<
    OperationalInsights,
    ActionResponse,
    Response = ArmResponse<ActionsList>,
    Error = CloudError
  >;
}

@@doc(ActionResponse.name, "Action ID");
@@doc(ActionResponse.properties, "Action properties for get request");
@@doc(ActionResponses.createOrUpdate::parameters.resource, "The action");
