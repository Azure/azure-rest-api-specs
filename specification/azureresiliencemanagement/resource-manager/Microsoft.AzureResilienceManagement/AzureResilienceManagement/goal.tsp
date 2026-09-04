import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/goals/goalTemplate.tsp";
import "./models/goals/goalAssignment.tsp";
import "./models/goals/goalResource.tsp";
import "./models/goals/recommendCapacity.tsp";
import "./models/common/common.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

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

  @doc("Action to exclude a resource from goal assignment.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("updateGoalResources")
  @post
  updateGoalResources is ArmResourceActionAsync<
    GoalAssignment,
    UpdateGoalResourceRequest,
    UpdateGoalResourceResponse,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Refreshes the goal resources under a goal assignment. This operation scans for new resources under the scope of the assignment.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("refreshGoalResources")
  @post
  refreshGoalResources is ArmResourceActionAsync<
    GoalAssignment,
    void,
    RefreshGoalResourcesResponse,
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

  @added(Versions.v2026_03_01_preview)
  @doc("Recommends capacity improvements for resources under the goal assignments scope. Returns AI-powered capacity assessments and recommendations.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("recommendCapacity")
  @post
  recommendCapacity is ArmResourceActionAsync<
    GoalAssignment,
    RecommendCapacityRequest,
    RecommendCapacityResult,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalAssignment, ServiceGroupTenantParameters>;
}

@armResourceOperations
@removed(Versions.v2026_09_01_preview)
interface GoalTemplates {
  #deprecated "GoalTemplate is deprecated and removed in 2026-09-01-preview."
  @route(ServiceGroupRoute)
  get is ArmResourceRead<GoalTemplate, ServiceGroupParameters>;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-01-preview."
  @route(ServiceGroupRoute)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalTemplate,
    ServiceGroupParameters
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-01-preview."
  @route(ServiceGroupRoute)
  update is ArmResourcePatchAsync<
    GoalTemplate,
    GoalTemplateProperties,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-01-preview."
  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteWithoutOkAsync<
    GoalTemplate,
    ServiceGroupParameters
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-01-preview."
  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalTemplate, ServiceGroupTenantParameters>;
}

@armResourceOperations
interface GoalResources {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<GoalResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<GoalResource, ServiceGroupTenantParameters>;
}
