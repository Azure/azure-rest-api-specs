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
model DeploymentStack
  is Azure.ResourceManager.TrackedResource<DeploymentStackProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentStack,
    KeyName = "deploymentStackName",
    SegmentName = "deploymentStacks",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

// Generic interface for common DeploymentStack operations
interface DeploymentStackCommonOps<TBaseParams = {}> {
  /**
   * Gets a Deployment stack with a given name at the specified scope.
   */
  get is ArmResourceRead<DeploymentStack, BaseParameters = TBaseParams>;

  /**
   * Creates or updates a Deployment stack at the specified scope.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentStack, BaseParameters = TBaseParams>;
  
  /**
   * Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" ""
  delete is ArmResourceDeleteWithoutOkAsync<
    DeploymentStack,
    Parameters = ActionOnUnmanageDeleteParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Exports the template used to create the Deployment stack at the specified scope.
   */
  @action("exportTemplate")
  exportTemplate is ArmResourceActionSync<
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>
  >;

  /**
   * Runs preflight validation on the Deployment stack template at the specified scope to verify its acceptance to Azure Resource Manager.
   */
  @action("validate")
  validateStack is ArmResourceActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>
  >;
}

// Resource Group scoped operations
@armResourceOperations
interface DeploymentStacksAtResourceGroup
  extends DeploymentStackCommonOps<Azure.ResourceManager.Foundations.DefaultBaseParameters<DeploymentStack>> {
  
  /**
   * List all deployment stacks in a resource group.
   */
  list is ArmResourceListByParent<DeploymentStack>;
}

/*
  
// Subscription scoped operations (with custom routes and base parameters)
@armResourceOperations
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deploymentStacks/{deploymentStackName}")
interface DeploymentStacksAtSubscription
  extends DeploymentStackCommonOps<Azure.ResourceManager.Foundations.DefaultBaseParameters<DeploymentStack>> {

  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deploymentStacks")
  list is ArmResourceListByParent<DeploymentStack>;
}



// Management Group scoped operations (with custom routes and base parameters)
@armResourceOperations
@route("/providers/Microsoft.Management/managementGroups/{managementGroupName}/providers/Microsoft.Resources/deploymentStacks/{deploymentStackName}")
interface DeploymentStacksAtManagementGroup
  extends DeploymentStackCommonOps<ManagementGroupBaseParameters> {
}
*/

/**
 * The static parameters for a subscription based resource
 */
model ManagementGroupBaseParameters is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...CommonTypes.ManagementGroupNameParameter;
}

@@maxLength(DeploymentStack.name, 90);
@@minLength(DeploymentStack.name, 1);
@@doc(DeploymentStack.name, "Name of the deployment stack.");
@@doc(DeploymentStack.properties, "Deployment stack properties.");
@@doc(DeploymentStacksAtResourceGroup.createOrUpdate::parameters.resource,
  "Deployment stack supplied to the operation."
);
@@doc(DeploymentStacksAtResourceGroup.validateStack::parameters.body,
  "Deployment stack to validate."
);
