import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;
/**
 * Deployment stack object.
 */
@subscriptionResource
model DeploymentStack
  is Azure.ResourceManager.TrackedResource<DeploymentStackProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentStack,
    KeyName = "deploymentStackName",
    SegmentName = "deploymentStacks",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface DeploymentStacks {
  /**
   * Gets a Deployment stack with a given name at Subscription scope.
   */
  getAtSubscription is ArmResourceRead<
    DeploymentStack,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Creates or updates a Deployment stack at Subscription scope.
   */
  createOrUpdateAtSubscription is ArmResourceCreateOrReplaceAsync<
    DeploymentStack,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Deletes a Deployment stack by name at Subscription scope. When operation completes, status code 200 returned without content.
   */
  deleteAtSubscription is ArmResourceDeleteWithoutOkAsync<
    DeploymentStack,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Flag to indicate delete rather than detach for unmanaged resources.
       */
      @query("unmanageAction.Resources")
      `unmanageAction.Resources`?: UnmanageActionResourceMode;

      /**
       * Flag to indicate delete rather than detach for unmanaged resource groups.
       */
      @query("unmanageAction.ResourceGroups")
      `unmanageAction.ResourceGroups`?: UnmanageActionResourceGroupMode;

      /**
       * Flag to indicate delete rather than detach for unmanaged management groups.
       */
      @query("unmanageAction.ManagementGroups")
      `unmanageAction.ManagementGroups`?: UnmanageActionManagementGroupMode;

      /**
       * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
       */
      @query("bypassStackOutOfSyncError")
      bypassStackOutOfSyncError?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the Deployment stacks within the specified Subscription.
   */
  listAtSubscription is ArmResourceListByParent<
    DeploymentStack,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Exports the template used to create the Deployment stack at Subscription scope.
   */
  @action("exportTemplate")
  exportTemplateAtSubscription is ArmResourceActionSync<
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Runs preflight validation on the Subscription scoped Deployment stack template to verify its acceptance to Azure Resource Manager.
   */
  @action("validate")
  validateStackAtSubscription is ArmResourceActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@maxLength(DeploymentStack.name, 90);
@@minLength(DeploymentStack.name, 1);
@@doc(DeploymentStack.name, "Name of the deployment stack.");
@@doc(DeploymentStack.properties, "Deployment stack properties.");
@@doc(DeploymentStacks.createOrUpdateAtSubscription::parameters.resource,
  "Deployment stack supplied to the operation."
);
@@doc(DeploymentStacks.validateStackAtSubscription::parameters.body,
  "Deployment stack to validate."
);
