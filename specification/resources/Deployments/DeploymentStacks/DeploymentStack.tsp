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

@armResourceOperations
interface DeploymentStackOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = DeploymentStack,
        KeyName = "deploymentStackName",
        SegmentName = "deploymentStacks",
        NamePattern = "^[-\\w\\._\\(\\)]+$"
      >>
    > {}

@armResourceOperations
interface DeploymentStacks {
  /**
   * Gets a Deployment stack with a given name at Resource Group scope.
   */
  getAtResourceGroup is DeploymentStackOps.Read<DeploymentStack>;

  /**
   * Creates or updates a Deployment stack at Resource Group scope.
   */
  createOrUpdateAtResourceGroup is DeploymentStackOps.CreateOrUpdateAsync<DeploymentStack>;

  /**
   * Deletes a Deployment stack by name at Resource Group scope. When operation completes, status code 200 returned without content.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  deleteAtResourceGroup is DeploymentStackOps.DeleteWithoutOkAsync<
    DeploymentStack,
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
   * Lists all the Deployment stacks within the specified Resource Group.
   */
  listAtResourceGroup is DeploymentStackOps.List<DeploymentStack>;

  /**
   * Exports the template used to create the Deployment stack at Resource Group scope.
   */
  @action("exportTemplate")
  exportTemplateAtResourceGroup is DeploymentStackOps.ActionSync<
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>
  >;

  /**
   * Runs preflight validation on the Resource Group scoped Deployment stack template to verify its acceptance to Azure Resource Manager.
   */
  @action("validate")
  validateStackAtResourceGroup is DeploymentStackOps.ActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>
  >;
}
@armResourceOperations
interface DeploymentStackOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = DeploymentStack,
        KeyName = "deploymentStackName",
        SegmentName = "deploymentStacks",
        NamePattern = "^[-\\w\\._\\(\\)]+$"
      >>
    > {}

@armResourceOperations
interface DeploymentStackOperationGroup {
  /**
   * Gets a Deployment stack with a given name at Subscription scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_GetAtSubscription")
  getAtSubscription is DeploymentStackOperationGroupOps.Read<DeploymentStack>;

  /**
   * Creates or updates a Deployment stack at Subscription scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_CreateOrUpdateAtSubscription")
  createOrUpdateAtSubscription is DeploymentStackOperationGroupOps.CreateOrUpdateAsync<DeploymentStack>;

  /**
   * Deletes a Deployment stack by name at Subscription scope. When operation completes, status code 200 returned without content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DeploymentStacks_DeleteAtSubscription")
  deleteAtSubscription is DeploymentStackOperationGroupOps.DeleteWithoutOkAsync<
    DeploymentStack,
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_ListAtSubscription")
  listAtSubscription is DeploymentStackOperationGroupOps.List<DeploymentStack>;

  /**
   * Exports the template used to create the Deployment stack at Subscription scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("exportTemplate")
  @operationId("DeploymentStacks_ExportTemplateAtSubscription")
  exportTemplateAtSubscription is DeploymentStackOperationGroupOps.ActionSync<
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>
  >;

  /**
   * Runs preflight validation on the Subscription scoped Deployment stack template to verify its acceptance to Azure Resource Manager.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("validate")
  @operationId("DeploymentStacks_ValidateStackAtSubscription")
  validateStackAtSubscription is DeploymentStackOperationGroupOps.ActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>
  >;
}
@armResourceOperations
interface DeploymentStackOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** managementGroups */
        @path @segment("managementGroups") managementGroupId: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = DeploymentStack,
        KeyName = "deploymentStackName",
        SegmentName = "deploymentStacks",
        NamePattern = "^[-\\w\\._\\(\\)]+$"
      >>
    > {}

@armResourceOperations
interface DeploymentStackOperationGroup {
  /**
   * Gets a Deployment stack with a given name at Management Group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_GetAtManagementGroup")
  getAtManagementGroup is DeploymentStackOperationGroupOps.Read<DeploymentStack>;

  /**
   * Creates or updates a Deployment stack at Management Group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_CreateOrUpdateAtManagementGroup")
  createOrUpdateAtManagementGroup is DeploymentStackOperationGroupOps.CreateOrUpdateAsync<DeploymentStack>;

  /**
   * Deletes a Deployment stack by name at Management Group scope. When operation completes, status code 200 returned without content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DeploymentStacks_DeleteAtManagementGroup")
  deleteAtManagementGroup is DeploymentStackOperationGroupOps.DeleteWithoutOkAsync<
    DeploymentStack,
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
   * Lists all the Deployment stacks within the specified Management Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentStacks_ListAtManagementGroup")
  listAtManagementGroup is DeploymentStackOperationGroupOps.List<DeploymentStack>;

  /**
   * Exports the template used to create the Deployment stack at Management Group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("exportTemplate")
  @operationId("DeploymentStacks_ExportTemplateAtManagementGroup")
  exportTemplateAtManagementGroup is DeploymentStackOperationGroupOps.ActionSync<
    DeploymentStack,
    void,
    ArmResponse<DeploymentStackTemplateDefinition>
  >;

  /**
   * Runs preflight validation on the Management Group scoped Deployment stack template to verify its acceptance to Azure Resource Manager.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("validate")
  @operationId("DeploymentStacks_ValidateStackAtManagementGroup")
  validateStackAtManagementGroup is DeploymentStackOperationGroupOps.ActionAsync<
    DeploymentStack,
    DeploymentStack,
    ArmResponse<DeploymentStackValidateResult>
  >;
}

@@maxLength(DeploymentStack.name, 90);
@@minLength(DeploymentStack.name, 1);
@@doc(DeploymentStack.name, "Name of the deployment stack.");
@@doc(DeploymentStack.properties, "Deployment stack properties.");
@@doc(DeploymentStacks.createOrUpdateAtResourceGroup::parameters.resource,
  "Deployment stack supplied to the operation."
);
@@doc(DeploymentStacks.validateStackAtResourceGroup::parameters.body,
  "Deployment stack to validate."
);
@@doc(DeploymentStackOperationGroup.createOrUpdateAtSubscription::parameters.resource,
  "Deployment stack supplied to the operation."
);
@@doc(DeploymentStackOperationGroup.validateStackAtSubscription::parameters.body,
  "Deployment stack to validate."
);
@@doc(DeploymentStackOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "Deployment stack supplied to the operation."
);
@@doc(DeploymentStackOperationGroup.validateStackAtManagementGroup::parameters.body,
  "Deployment stack to validate."
);
