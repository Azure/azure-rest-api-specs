import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/goals/goalTemplate.tsp";
import "./models/goals/goalAssignment.tsp";
import "./models/goals/goalResource.tsp";
import "./models/common/common.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@armResourceOperations
interface GoalAssignments {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<GoalAssignment, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  update is ArmResourcePatchAsync<
    GoalAssignment,
    GoalAssignmentProperties,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteWithoutOkAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalAssignment, ServiceGroupTenantParameters>;
}

@armResourceOperations
interface GoalTemplates {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<GoalTemplate, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalTemplate,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  update is ArmResourcePatchAsync<
    GoalTemplate,
    GoalTemplateProperties,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteSync<GoalTemplate, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalTemplate, ServiceGroupTenantParameters>;
}

@armResourceOperations
interface GoalResources {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<GoalResource, ServiceGroupParameters>;

  @doc("Action to exclude a resource from goal assignment.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("update")
  @post
  update is ArmResourceActionAsync<
    GoalResource,
    UpdateGoalResourceRequest,
    UpdateGoalResourceResponse,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalResource, ServiceGroupTenantParameters>;
}
