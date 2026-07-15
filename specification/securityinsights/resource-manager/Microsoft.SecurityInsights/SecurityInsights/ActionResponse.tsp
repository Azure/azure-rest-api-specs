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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

alias ActionResponsesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /**
     * The name of the monitor workspace.
     */
    @segment("workspaces")
    @key
    @path
    @minLength(1)
    @maxLength(90)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /**
     * Alert rule ID
     */
    @path
    @key
    @segment("alertRules")
    ruleId: string;
  },
  {
    /**
     * Action ID
     */
    @path
    @key
    @segment("actions")
    actionId: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations(#{ omitTags: true })
interface ActionResponses {
  /**
   * Gets the action of alert rule.
   */
  @tag("Actions")
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
  @tag("Actions")
  createOrUpdate is ActionResponsesOps.CreateOrUpdateSync<
    Resource = ActionResponse,
    Request = ActionRequest,
    Response =
      | ArmResourceUpdatedResponse<ActionResponse>
      | ArmResourceCreatedSyncResponse<ActionResponse>
  >;

  /**
   * Delete the action of alert rule.
   */
  @tag("Actions")
  delete is Extension.DeleteSync<
    OperationalInsights,
    ActionResponse,
    Error = CloudError
  >;

  /**
   * Gets all actions of alert rule.
   */
  @tag("Actions")
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
