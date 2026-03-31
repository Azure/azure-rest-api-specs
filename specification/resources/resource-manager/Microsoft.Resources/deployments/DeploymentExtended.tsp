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
      CloudError,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DeploymentExtendeds {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtScope")
  @tag("Deployments")
  getAtScope is Extension.Read<
    Extension.ScopeParameter,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtScope")
  @tag("Deployments")
  checkExistenceAtScope is Extension.CheckExistence<
    Extension.ScopeParameter,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtScope")
  @tag("Deployments")
  createOrUpdateAtScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    DeploymentExtended,
    Request = Deployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtScope")
  @tag("Deployments")
  deleteAtScope is Extension.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Get all the deployments at the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtScope")
  @tag("Deployments")
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
    },
    Response = DeploymentListResult,
    Error = CloudError
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtScope")
  @tag("Deployments")
  @action("cancel")
  cancelAtScope is Extension.ActionSync<
    Extension.ScopeParameter,
    DeploymentExtended,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtScope")
  @tag("Deployments")
  @action("validate")
  validateAtScope is Extension.ActionAsync<
    Extension.ScopeParameter,
    DeploymentExtended,
    Deployment,
    DeploymentValidateResult,
    Error = CloudError | {
      ...Response<400>;

      /**
       * The template deployment validation detected failures.
       */
      @bodyRoot
      body: DeploymentValidateResult;
    }
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtScope")
  @tag("Deployments")
  @action("exportTemplate")
  exportTemplateAtScope is Extension.ActionSync<
    Extension.ScopeParameter,
    DeploymentExtended,
    void,
    DeploymentExportResult,
    Error = CloudError
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtScope")
  @tag("DeploymentOperations")
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
  @tag("DeploymentOperations")
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
    },
    Error = CloudError
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
      CloudError,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface Deployments {
  /**
   * Gets a deployment.
   */
  @tag("Deployments")
  getAtTenantScope is Extension.Read<
    Extension.Tenant,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Checks whether the deployment exists.
   */
  @tag("Deployments")
  checkExistenceAtTenantScope is Extension.CheckExistence<
    Extension.Tenant,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  @tag("Deployments")
  createOrUpdateAtTenantScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.Tenant,
    DeploymentExtended,
    Request = ScopedDeployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  @tag("Deployments")
  deleteAtTenantScope is Extension.DeleteWithoutOkAsync<
    Extension.Tenant,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  @tag("Deployments")
  @action("cancel")
  cancelAtTenantScope is Extension.ActionSync<
    Extension.Tenant,
    DeploymentExtended,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  @tag("Deployments")
  @action("validate")
  validateAtTenantScope is Extension.ActionAsync<
    Extension.Tenant,
    DeploymentExtended,
    ScopedDeployment,
    DeploymentValidateResult,
    Error = CloudError | {
      ...Response<400>;

      /**
       * The template deployment validation detected failures.
       */
      @bodyRoot
      body: DeploymentValidateResult;
    }
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the tenant group.
   */
  @tag("Deployments")
  @action("whatIf")
  whatIfAtTenantScope is Extension.ActionAsync<
    Extension.Tenant,
    DeploymentExtended,
    ScopedDeploymentWhatIf,
    WhatIfOperationResult,
    Error = CloudError
  >;

  /**
   * Exports the template used for specified deployment.
   */
  @tag("Deployments")
  @action("exportTemplate")
  exportTemplateAtTenantScope is Extension.ActionSync<
    Extension.Tenant,
    DeploymentExtended,
    void,
    DeploymentExportResult,
    Error = CloudError
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtTenantScope")
  @tag("DeploymentOperations")
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
  @tag("Deployments")
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
    },
    Response = DeploymentListResult,
    Error = CloudError
  >;

  /**
   * Gets all deployments operations for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_ListAtTenantScope")
  @tag("DeploymentOperations")
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
    },
    Error = CloudError
  >;
}

interface DeploymentExtendedManagementGroupOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,

        @path
        @minLength(1)
        @maxLength(90)
        @segment("managementGroups")
        @doc("The management group ID.")
        groupId: string,
      },
      {
        ...KeysOf<DeploymentExtended>,
      },
      CloudError,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DeploymentExtendedManagementGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtManagementGroupScope")
  @tag("Deployments")
  getAtManagementGroupScope is Extension.Read<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtManagementGroupScope")
  @tag("Deployments")
  checkExistenceAtManagementGroupScope is Extension.CheckExistence<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtManagementGroupScope")
  @tag("Deployments")
  createOrUpdateAtManagementGroupScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Request = ScopedDeployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtManagementGroupScope")
  @tag("Deployments")
  deleteAtManagementGroupScope is Extension.DeleteWithoutOkAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Get all the deployments for a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtManagementGroupScope")
  @tag("Deployments")
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
    },
    Response = DeploymentListResult,
    Error = CloudError
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtManagementGroupScope")
  @tag("Deployments")
  @action("cancel")
  cancelAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtManagementGroupScope")
  @tag("Deployments")
  @action("validate")
  validateAtManagementGroupScope is Extension.ActionAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    ScopedDeployment,
    DeploymentValidateResult,
    Error = CloudError | {
      ...Response<400>;

      /**
       * The template deployment validation detected failures.
       */
      @bodyRoot
      body: DeploymentValidateResult;
    }
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIfAtManagementGroupScope")
  @tag("Deployments")
  @action("whatIf")
  whatIfAtManagementGroupScope is Extension.ActionAsync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    ScopedDeploymentWhatIf,
    WhatIfOperationResult,
    Error = CloudError
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtManagementGroupScope")
  @tag("Deployments")
  @action("exportTemplate")
  exportTemplateAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    DeploymentExportResult,
    Error = CloudError
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtManagementGroupScope")
  @tag("DeploymentOperations")
  @get
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/providers/Microsoft.Resources/deployments/{deploymentName}/operations/{operationId}")
  deploymentOperationsGetAtManagementGroupScope is DeploymentExtendedManagementGroupOps.ActionSync<
    DeploymentExtended,
    void,
    DeploymentOperation,
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
  @tag("DeploymentOperations")
  @list
  @get
  @action("operations")
  deploymentOperationsListAtManagementGroupScope is Extension.ActionSync<
    Extension.ManagementGroup<"groupId">,
    DeploymentExtended,
    void,
    DeploymentOperationsListResult,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
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
      CloudError,
      #{ useStaticRoute: true }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface DeploymentExtendedSubscriptionGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetAtSubscriptionScope")
  @tag("Deployments")
  getAtSubscriptionScope is Extension.Read<
    Extension.Subscription,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistenceAtSubscriptionScope")
  @tag("Deployments")
  checkExistenceAtSubscriptionScope is Extension.CheckExistence<
    Extension.Subscription,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdateAtSubscriptionScope")
  @tag("Deployments")
  createOrUpdateAtSubscriptionScope is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.Subscription,
    DeploymentExtended,
    Request = Deployment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DeploymentExtended> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * A template deployment that is currently running cannot be deleted. Deleting a template deployment removes the associated deployment operations. This is an asynchronous operation that returns a status of 202 until the template deployment is successfully deleted. The Location response header contains the URI that is used to obtain the status of the process. While the process is running, a call to the URI in the Location header returns a status of 202. When the process finishes, the URI in the Location header returns a status of 204 on success. If the asynchronous request failed, the URI in the Location header returns an error-level status code.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DeleteAtSubscriptionScope")
  @tag("Deployments")
  deleteAtSubscriptionScope is Extension.DeleteWithoutOkAsync<
    Extension.Subscription,
    DeploymentExtended,
    Error = CloudError
  >;

  /**
   * Get all the deployments for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListAtSubscriptionScope")
  @tag("Deployments")
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
    },
    Response = DeploymentListResult,
    Error = CloudError
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resources partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CancelAtSubscriptionScope")
  @tag("Deployments")
  @action("cancel")
  cancelAtSubscriptionScope is Extension.ActionSync<
    Extension.Subscription,
    DeploymentExtended,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * Validates whether the specified template is syntactically correct and will be accepted by Azure Resource Manager..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ValidateAtSubscriptionScope")
  @tag("Deployments")
  @action("validate")
  validateAtSubscriptionScope is Extension.ActionAsync<
    Extension.Subscription,
    DeploymentExtended,
    Deployment,
    DeploymentValidateResult,
    Error = CloudError | {
      ...Response<400>;

      /**
       * The template deployment validation detected failures.
       */
      @bodyRoot
      body: DeploymentValidateResult;
    }
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIfAtSubscriptionScope")
  @tag("Deployments")
  @action("whatIf")
  whatIfAtSubscriptionScope is Extension.ActionAsync<
    Extension.Subscription,
    DeploymentExtended,
    DeploymentWhatIf,
    WhatIfOperationResult,
    Error = CloudError
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplateAtSubscriptionScope")
  @tag("Deployments")
  @action("exportTemplate")
  exportTemplateAtSubscriptionScope is Extension.ActionSync<
    Extension.Subscription,
    DeploymentExtended,
    void,
    DeploymentExportResult,
    Error = CloudError
  >;

  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeploymentOperations_GetAtSubscriptionScope")
  @tag("DeploymentOperations")
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
  @tag("DeploymentOperations")
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
    },
    Error = CloudError
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
  },
  CloudError
>;

@armResourceOperations(#{ omitTags: true })
interface DeploymentExtendedOperationGroup {
  /**
   * Gets a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Get")
  @tag("Deployments")
  get is DeploymentExtendedResourceGroupOps.Read<DeploymentExtended>;

  /**
   * Checks whether the deployment exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CheckExistence")
  @tag("Deployments")
  checkExistence is DeploymentExtendedResourceGroupOps.CheckExistence<DeploymentExtended>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_CreateOrUpdate")
  @tag("Deployments")
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
  @tag("Deployments")
  delete is DeploymentExtendedResourceGroupOps.DeleteWithoutOkAsync<DeploymentExtended>;

  /**
   * Get all the deployments for a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ListByResourceGroup")
  @tag("Deployments")
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
    },
    Response = DeploymentListResult
  >;

  /**
   * You can cancel a deployment only if the provisioningState is Accepted or Running. After the deployment is canceled, the provisioningState is set to Canceled. Canceling a template deployment stops the currently running template deployment and leaves the resource group partially deployed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Cancel")
  @tag("Deployments")
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
  @tag("Deployments")
  validate is DeploymentExtendedResourceGroupOps.ActionAsync<
    DeploymentExtended,
    Deployment,
    DeploymentValidateResult,
    OverrideErrorType = CloudError | {
      ...Response<400>;

      /**
       * The template deployment validation detected failures.
       */
      @bodyRoot
      body: DeploymentValidateResult;
    }
  >;

  /**
   * Returns changes that will be made by the deployment if executed at the scope of the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_WhatIf")
  @tag("Deployments")
  whatIf is DeploymentExtendedResourceGroupOps.ActionAsync<
    DeploymentExtended,
    DeploymentWhatIf,
    WhatIfOperationResult
  >;

  /**
   * Exports the template used for specified deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_ExportTemplate")
  @tag("Deployments")
  exportTemplate is DeploymentExtendedResourceGroupOps.ActionSync<
    DeploymentExtended,
    void,
    DeploymentExportResult
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
@@maxLength(Extension.ManagementGroup.name, 90);
