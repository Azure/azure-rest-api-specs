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
 * Deployment information.
 */
@extensionResource
model DeploymentExtended
  is Azure.ResourceManager.ExtensionResource<DeploymentPropertiesExtended> {
  ...ResourceNameParameter<
    Resource = DeploymentExtended,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;

  /**
   * the location of the deployment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;

  /**
   * Deployment tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

interface DeploymentExtendedScopeOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,

        @key
        @doc("The fully qualified Azure Resource manager identifier of the resource.")
        scope: string,
      },
      {
        ...KeysOf<DeploymentExtended>,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface DeploymentExtendeds {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtScope")
  getAtScope is Extension.Read<Extension.ScopeParameter, DeploymentExtended>;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtScope")
  checkExistenceAtScope is Extension.CheckExistence<
    Extension.ScopeParameter,
    DeploymentExtended
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtScope")
  createOrUpdateAtScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    DeploymentExtended,
    Request = Deployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtScope")
  deleteAtScope is Extension.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    DeploymentExtended
  >;

  /**
   * Get all the deployments at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtScope")
  listAtScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    DeploymentExtended,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=provisioningState eq '{state}'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to get. If null is passed, returns all deployments.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtScope")
  @action("cancel")
  cancelAtScope is Extension.ActionSync<
    Extension.ScopeParameter,
    DeploymentExtended,
    void,
    NoContentResponse
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtScope")
  @action("validate")
  validateAtScope is Extension.ActionAsync<
    Extension.ScopeParameter,
    DeploymentExtended,
    Deployment,
    ArmResponse<DeploymentValidateResult>
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtScope")
  @action("exportTemplate")
  exportTemplateAtScope is Extension.ActionSync<
    Extension.ScopeParameter,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentExportResult>
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtScope")
  @get
  @route("/{+scope}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}")
  deploymentOperationsGetAtScope is DeploymentExtendedScopeOps.ActionSync<
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      /**
       * The ID of the operation to get.
       */
      @path
      @segment("operations")
      operationId: string;
    }
  >;

  /**
   * Gets all deployments operations for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_ListAtScope")
  @list
  @get
  @action("operations")
  deploymentOperationsListAtScope is Extension.ActionSync<
    Extension.ScopeParameter,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

interface DeploymentExtendedTenantOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...Extension.Tenant,
      },
      {
        ...KeysOf<DeploymentExtended>,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface Deployments {
  /**
   * Gets a deployment.
   */
  getAtTenantScope is Extension.Read<Extension.Tenant, DeploymentExtended>;

  /**
   * Checks whether the deployment exists.
   */
  checkExistenceAtTenantScope is Extension.CheckExistence<
    Extension.Tenant,
    DeploymentExtended
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  createOrUpdateAtTenantScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.Tenant,
    DeploymentExtended,
    Request = ScopedDeployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  deleteAtTenantScope is Extension.DeleteWithoutOkAsync<
    Extension.Tenant,
    DeploymentExtended
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  @action("cancel")
  cancelAtTenantScope is Extension.ActionSync<
    Extension.Tenant,
    DeploymentExtended,
    void,
    NoContentResponse
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  @action("validate")
  validateAtTenantScope is Extension.ActionAsync<
    Extension.Tenant,
    DeploymentExtended,
    ScopedDeployment,
    ArmResponse<DeploymentValidateResult>
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the tenant group.
   */
  @action("whatIf")
  whatIfAtTenantScope is Extension.ActionAsync<
    Extension.Tenant,
    DeploymentExtended,
    ScopedDeploymentWhatIf,
    ArmResponse<WhatIfOperationResult>
  >;

  /**
   * Exports the template used for specified deployment.
   */
  @action("exportTemplate")
  exportTemplateAtTenantScope is Extension.ActionSync<
    Extension.Tenant,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentExportResult>
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtTenantScope")
  @get
  @route("/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}")
  deploymentOperationsGetAtTenantScope is DeploymentExtendedTenantOps.ActionSync<
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      /**
       * The ID of the operation to get.
       */
      @path
      @segment("operations")
      operationId: string;
    }
  >;

  /**
   * Get all the deployments at the tenant scope.
   */
  @operationId("Deployments_ListAtTenantScope")
  list is Extension.ListByTarget<
    Extension.Tenant,
    DeploymentExtended,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=provisioningState eq '{state}'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to get. If null is passed, returns all deployments.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets all deployments operations for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_ListAtTenantScope")
  @list
  @get
  @action("operations")
  listAtTenantScope is Extension.ActionSync<
    Extension.Tenant,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

interface DeploymentExtendedManagementGroupOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,

        @path
        @minLength(1)
        @segment("managementGroups")
        @doc("The management group ID.")
        groupId: string,
      },
      {
        ...KeysOf<DeploymentExtended>,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface DeploymentExtendedManagementGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtManagementGroupScope")
  getAtManagementGroupScope is Extension.Read<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended
  >;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtManagementGroupScope")
  checkExistenceAtManagementGroupScope is Extension.CheckExistence<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtManagementGroupScope")
  createOrUpdateAtManagementGroupScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Request = ScopedDeployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtManagementGroupScope")
  deleteAtManagementGroupScope is Extension.DeleteWithoutOkAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended
  >;

  /**
   * Get all the deployments for a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtManagementGroupScope")
  listAtManagementGroupScope is Extension.ListByTarget<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=provisioningState eq '{state}'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to get. If null is passed, returns all deployments.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtManagementGroupScope")
  @action("cancel")
  cancelAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    NoContentResponse
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtManagementGroupScope")
  @action("validate")
  validateAtManagementGroupScope is Extension.ActionAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    ScopedDeployment,
    ArmResponse<DeploymentValidateResult>
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIfAtManagementGroupScope")
  @action("whatIf")
  whatIfAtManagementGroupScope is Extension.ActionAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    ScopedDeploymentWhatIf,
    ArmResponse<WhatIfOperationResult>
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtManagementGroupScope")
  @action("exportTemplate")
  exportTemplateAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentExportResult>
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtManagementGroupScope")
  @get
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}")
  deploymentOperationsGetAtManagementGroupScope is DeploymentExtendedManagementGroupOps.ActionSync<
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      /**
       * The ID of the operation to get.
       */
      @path
      @segment("operations")
      operationId: string;
    }
  >;

  /**
   * Gets all deployments operations for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_ListAtManagementGroupScope")
  @list
  @get
  @action("operations")
  deploymentOperationsListAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

interface DeploymentExtendedSubscriptionOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
      },
      {
        ...KeysOf<DeploymentExtended>,
      },
      ErrorResponse,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface DeploymentExtendedSubscriptionGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtSubscriptionScope")
  getAtSubscriptionScope is Extension.Read<
    Extension.Subscription,
    DeploymentExtended
  >;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtSubscriptionScope")
  checkExistenceAtSubscriptionScope is Extension.CheckExistence<
    Extension.Subscription,
    DeploymentExtended
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtSubscriptionScope")
  createOrUpdateAtSubscriptionScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.Subscription,
    DeploymentExtended,
    Request = Deployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtSubscriptionScope")
  deleteAtSubscriptionScope is Extension.DeleteWithoutOkAsync<
    Extension.Subscription,
    DeploymentExtended
  >;

  /**
   * Get all the deployments for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtSubscriptionScope")
  listAtSubscriptionScope is Extension.ListByTarget<
    Extension.Subscription,
    DeploymentExtended,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=provisioningState eq '{state}'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to get. If null is passed, returns all deployments.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtSubscriptionScope")
  @action("cancel")
  cancelAtSubscriptionScope is Extension.ActionSync<
    Extension.Subscription,
    DeploymentExtended,
    void,
    NoContentResponse
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtSubscriptionScope")
  @action("validate")
  validateAtSubscriptionScope is Extension.ActionAsync<
    Extension.Subscription,
    DeploymentExtended,
    Deployment,
    ArmResponse<DeploymentValidateResult>
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIfAtSubscriptionScope")
  @action("whatIf")
  whatIfAtSubscriptionScope is Extension.ActionAsync<
    Extension.Subscription,
    DeploymentExtended,
    DeploymentWhatIf,
    ArmResponse<WhatIfOperationResult>
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtSubscriptionScope")
  @action("exportTemplate")
  exportTemplateAtSubscriptionScope is Extension.ActionSync<
    Extension.Subscription,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentExportResult>
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtSubscriptionScope")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}")
  deploymentOperationsGetAtSubscriptionScope is DeploymentExtendedSubscriptionOps.ActionSync<
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperation>,
    Parameters = {
      /**
       * The ID of the operation to get.
       */
      @path
      @segment("operations")
      operationId: string;
    }
  >;

  /**
   * Gets all deployments operations for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_ListAtSubscriptionScope")
  @list
  @get
  @action("operations")
  deploymentOperationsListAtSubscriptionScope is Extension.ActionSync<
    Extension.Subscription,
    DeploymentExtended,
    void,
    ArmResponse<DeploymentOperationsListResult>,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

alias DeploymentExtendedResourceGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    @path
    @doc("The name of the resource group.")
    @segment("resourcegroups")
    resourceGroupName: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Resources";
  },
  {
    ...KeysOf<DeploymentExtended>;
  }
>;

@armResourceOperations
interface DeploymentExtendedOperationGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Get")
  get is DeploymentExtendedResourceGroupOps.Read<DeploymentExtended>;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistence")
  checkExistence is DeploymentExtendedResourceGroupOps.CheckExistence<DeploymentExtended>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is DeploymentExtendedResourceGroupOps.CreateOrUpdateAsync<
    DeploymentExtended,
    Request = Deployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. Deleting a template deployment does not affect the state of the resource group. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Delete")
  delete is DeploymentExtendedResourceGroupOps.DeleteWithoutOkAsync<DeploymentExtended>;

  /**
   * Get all the deployments for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListByResourceGroup")
  listByResourceGroup is DeploymentExtendedResourceGroupOps.List<
    DeploymentExtended,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=provisioningState eq '{state}'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to get. If null is passed, returns all deployments.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resource group partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Cancel")
  cancel is DeploymentExtendedResourceGroupOps.ActionSync<
    DeploymentExtended,
    void,
    NoContentResponse
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Validate")
  validate is DeploymentExtendedResourceGroupOps.ActionAsync<
    DeploymentExtended,
    Deployment,
    ArmResponse<DeploymentValidateResult>
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIf")
  whatIf is DeploymentExtendedResourceGroupOps.ActionAsync<
    DeploymentExtended,
    DeploymentWhatIf,
    ArmResponse<WhatIfOperationResult>
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplate")
  exportTemplate is DeploymentExtendedResourceGroupOps.ActionSync<
    DeploymentExtended,
    void,
    ArmResponse<DeploymentExportResult>
  >;
}

@@maxLength(DeploymentExtended.name, 64);
@@minLength(DeploymentExtended.name, 1);
@@doc(DeploymentExtended.name, "The name of the deployment.");
@@doc(DeploymentExtended.properties, "Deployment properties.");
@@doc(DeploymentExtendeds.createOrUpdateAtScope::parameters.resource,
  "Additional parameters supplied to the operation."
);
@@doc(DeploymentExtendeds.validateAtScope::parameters.body,
  "Parameters to validate."
);
@@doc(Deployments.createOrUpdateAtTenantScope::parameters.resource,
  "Additional parameters supplied to the operation."
);
@@doc(Deployments.validateAtTenantScope::parameters.body,
  "Parameters to validate."
);
@@doc(Deployments.whatIfAtTenantScope::parameters.body,
  "Parameters to validate."
);
@@doc(DeploymentExtendedManagementGroup.createOrUpdateAtManagementGroupScope::parameters.resource,
  "Additional parameters supplied to the operation."
);
@@doc(DeploymentExtendedManagementGroup.validateAtManagementGroupScope::parameters.body,
  "Parameters to validate."
);
@@doc(DeploymentExtendedManagementGroup.whatIfAtManagementGroupScope::parameters.body,
  "Parameters to validate."
);
@@doc(DeploymentExtendedSubscriptionGroup.createOrUpdateAtSubscriptionScope::parameters.resource,
  "Additional parameters supplied to the operation."
);
@@doc(DeploymentExtendedSubscriptionGroup.validateAtSubscriptionScope::parameters.body,
  "Parameters to validate."
);
@@doc(DeploymentExtendedSubscriptionGroup.whatIfAtSubscriptionScope::parameters.body,
  "Parameters to What If."
);
@@doc(DeploymentExtendedOperationGroup.createOrUpdate::parameters.resource,
  "Additional parameters supplied to the operation."
);
@@doc(DeploymentExtendedOperationGroup.validate::parameters.body,
  "Parameters to validate."
);
@@doc(DeploymentExtendedOperationGroup.whatIf::parameters.body,
  "Parameters to validate."
);
