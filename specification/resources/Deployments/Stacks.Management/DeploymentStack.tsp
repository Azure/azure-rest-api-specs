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

namespace Microsoft.Resources.DeploymentStacks;

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

// Interface for all stack operations with the scoping parameterized.
// For some reason, the ArmResourceActionAsync type requires the base params extends this reflection model type.
interface DeploymentStackCommonOps<TBaseParams extends TypeSpec.Reflection.Model> {
  /**
   * Gets a Deployment stack with a given name at the specified scope.
   */
  get is ArmResourceRead<DeploymentStack, BaseParameters = TBaseParams>;

  /**
   * Lists Deployment stacks at the specified scope.
   */
  list is ArmResourceListByParent<
    DeploymentStack,
    BaseParameters = TBaseParams
  >;

  /**
   * Creates or updates a Deployment stack at the specified scope.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DeploymentStack,
    BaseParameters = TBaseParams
  >;

  /**
   * Deletes a Deployment stack by name at the specified scope. When operation completes, status code 200 returned without content.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" ""
  delete is ArmResourceDeleteWithoutOkAsync<
    DeploymentStack,
    BaseParameters = TBaseParams,
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
    ArmResponse<DeploymentStackTemplateDefinition>,
    BaseParameters = TBaseParams
  >;

  /**
   * Runs preflight validation on the Deployment stack template at the specified scope to verify its acceptance to Azure Resource Manager.
   */
  @action("validate")
  validateStack is ArmResourceActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>,
    BaseParameters = TBaseParams
  >;
}

// Resource Group scoped operations
@armResourceOperations
interface DeploymentStacksAtResourceGroup extends DeploymentStackCommonOps<ResourceGroupBaseParameters> {}

// Subscription scoped operations
@armResourceOperations
interface DeploymentStacksAtSubscription extends DeploymentStackCommonOps<SubscriptionBaseParameters> {}

/**
 * The common base parameters for Management group stacks.
 */
model ManagementGroupBaseParameters
  is Azure.ResourceManager.Foundations.TenantBaseParameters {
  ...CommonTypes.ManagementGroupNameParameter;
}
@@segment(ManagementGroupBaseParameters.managementGroupName, "providers/Microsoft.Management/managementGroups"); // Not part of the common type.

@armResourceOperations
interface DeploymentStacksAtManagementGroup extends DeploymentStackCommonOps<ManagementGroupBaseParameters> {}

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
