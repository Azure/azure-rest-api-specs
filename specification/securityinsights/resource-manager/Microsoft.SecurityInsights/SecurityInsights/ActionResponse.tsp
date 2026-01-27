import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AlertRule.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

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
  get is Extension.Read<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates the action of alert rule.
   */
  // Customized resource creation, since request body isn't the resource itself
  @autoRoute
  @put
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    Azure.ResourceManager.Extension.ExtensionInstanceParameters<
      OperationalInsights,
      ActionResponse
    >,
    ActionRequest,
    ArmResourceUpdatedResponse<ActionResponse> | ArmResourceCreatedResponse<ActionResponse>,
    ErrorResponse = CloudError
  >;

  /**
   * Delete the action of alert rule.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Gets all actions of alert rule.
   */
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
