// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;

interface DeploymentStacksOperationGroup {
  /**
   * Lists all the Deployment stacks within the specified Management Group.
   */
  @operationId("DeploymentStacks_ListAtManagementGroup")
  @autoRoute
  @get
  @action("deploymentStacks")
  listAtManagementGroup is ArmProviderActionSync<
    Response = ResourceListResult<DeploymentStack>,
    Parameters = {
      /**
       * Management Group id.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      @segment("managementGroups")
      managementGroupId: string;
    }
  >;
  /**
   * Creates or updates a Deployment stack at Management Group scope.
   */
  @operationId("DeploymentStacks_CreateOrUpdateAtManagementGroup")
  @route("/providers/Microsoft.Management/managementGroups/{managementGroupId}/providers/Microsoft.Resources/deploymentStacks/{deploymentStackName}")
  @put
  createOrUpdateAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * Management Group id.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    managementGroupId: string,

    /**
     * Name of the deployment stack.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    deploymentStackName: string,

    /**
     * Deployment stack supplied to the operation.
     */
    @bodyRoot
    deploymentStack: DeploymentStack,
  ): ArmResponse<DeploymentStack> | ErrorResponse;

  /**
   * Gets a Deployment stack with a given name at Management Group scope.
   */
  @operationId("DeploymentStacks_GetAtManagementGroup")
  @route("/providers/Microsoft.Management/managementGroups/{managementGroupId}/providers/Microsoft.Resources/deploymentStacks/{deploymentStackName}")
  @get
  getAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * Management Group id.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    managementGroupId: string,

    /**
     * Name of the deployment stack.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    deploymentStackName: string,
  ): ArmResponse<DeploymentStack> | ErrorResponse;

  /**
   * Deletes a Deployment stack by name at Management Group scope. When operation completes, status code 200 returned without content.
   */
  @operationId("DeploymentStacks_DeleteAtManagementGroup")
  @route("/providers/Microsoft.Management/managementGroups/{managementGroupId}/providers/Microsoft.Resources/deploymentStacks/{deploymentStackName}")
  @delete
  deleteAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * Management Group id.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    managementGroupId: string,

    /**
     * Name of the deployment stack.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    deploymentStackName: string,

    /**
     * Flag to indicate delete rather than detach for unmanaged resources.
     */
    @query("unmanageAction.Resources")
    `unmanageAction.Resources`?: UnmanageActionResourceMode,

    /**
     * Flag to indicate delete rather than detach for unmanaged resource groups.
     */
    @query("unmanageAction.ResourceGroups")
    `unmanageAction.ResourceGroups`?: UnmanageActionResourceGroupMode,

    /**
     * Flag to indicate delete rather than detach for unmanaged management groups.
     */
    @query("unmanageAction.ManagementGroups")
    `unmanageAction.ManagementGroups`?: UnmanageActionManagementGroupMode,

    /**
     * Flag to bypass service errors that indicate the stack resource list is not correctly synchronized.
     */
    @query("bypassStackOutOfSyncError")
    bypassStackOutOfSyncError?: boolean,
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;

  /**
   * Exports the template used to create the Deployment stack at Management Group scope.
   */
  @operationId("DeploymentStacks_ExportTemplateAtManagementGroup")
  @autoRoute
  @action("exportTemplate")
  exportTemplateAtManagementGroup is ArmProviderActionSync<
    Response = DeploymentStackTemplateDefinition,
    Parameters = {
      /**
       * Management Group id.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      @segment("managementGroups")
      managementGroupId: string;

      /**
       * Name of the deployment stack.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      @segment("deploymentStacks")
      deploymentStackName: string;
    }
  >;
  /**
   * Runs preflight validation on the Management Group scoped Deployment stack template to verify its acceptance to Azure Resource Manager.
   */
  @operationId("DeploymentStacks_ValidateStackAtManagementGroup")
  @autoRoute
  @action("validate")
  validateStackAtManagementGroup is ArmProviderActionAsync<
    Request = DeploymentStack,
    Response = DeploymentStackValidateResult,
    Parameters = {
      /**
       * Management Group id.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      @segment("managementGroups")
      managementGroupId: string;

      /**
       * Name of the deployment stack.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      @segment("deploymentStacks")
      deploymentStackName: string;
    }
  >;
}
