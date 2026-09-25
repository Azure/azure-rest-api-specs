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
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "GoalAssignments")
interface GoalAssignmentsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("Get a GoalAssignment Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<GoalAssignment, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("Create a GoalAssignment Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("Update a GoalAssignment Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  update is ArmResourcePatchAsync<
    GoalAssignment,
    GoalAssignmentProperties,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @doc("Action to exclude a resource from goal assignment. Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("updateGoalResources")
  @post
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  updateGoalResources is ArmResourceActionAsync<
    GoalAssignment,
    UpdateGoalResourceRequest,
    UpdateGoalResourceResponse,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @doc("Refreshes the goal resources under a goal assignment. This operation scans for new resources under the scope of the assignment. Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("refreshGoalResources")
  @post
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  refreshGoalResources is ArmResourceActionAsync<
    GoalAssignment,
    void,
    RefreshGoalResourcesResponse,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("Delete a GoalAssignment Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @added(Versions.v2026_03_01_preview)
  @doc("Recommends capacity improvements for resources under the goal assignments scope. Returns AI-powered capacity assessments and recommendations. Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("recommendCapacity")
  @post
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  recommendCapacity is ArmResourceActionAsync<
    GoalAssignment,
    RecommendCapacityRequest,
    RecommendCapacityResult,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("List GoalAssignment resources by tenant Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<GoalAssignment, ServiceGroupTenantParameters>;
}

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface GoalAssignments {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<GoalAssignment, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @route(ServiceGroupRoute)
  @sharedRoute
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
  @sharedRoute
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
  @sharedRoute
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
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    GoalAssignment,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Recommends capacity improvements for resources under the goal assignments scope. Returns AI-powered capacity assessments and recommendations.")
  @route(ServiceGroupRoute)
  @TypeSpec.Rest.action("recommendCapacity")
  @post
  @sharedRoute
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
  @sharedRoute
  list is ArmResourceListByParent<GoalAssignment, ServiceGroupTenantParameters>;
}

@armResourceOperations
@removed(Versions.v2026_09_30_preview)
interface GoalTemplates {
  #deprecated "GoalTemplate is deprecated and removed in 2026-09-30-preview."
  @doc("Gets a goal template. Deprecated: the GoalTemplate resource type is deprecated and is removed in 2026-09-30-preview. Set resiliency intent directly on the GoalAssignment (requireZonalResiliency, requireRegionalResiliency) and read resource posture from GoalResource (zonalResiliency, regionalResiliency) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Set resiliency intent on GoalAssignment and read resource posture from GoalResource instead.")
  get is ArmResourceRead<GoalTemplate, ServiceGroupParameters>;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-30-preview."
  @doc("Creates or updates a goal template. Deprecated: the GoalTemplate resource type is deprecated and is removed in 2026-09-30-preview. Set resiliency intent directly on the GoalAssignment (requireZonalResiliency, requireRegionalResiliency) and read resource posture from GoalResource (zonalResiliency, regionalResiliency) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Set resiliency intent on GoalAssignment and read resource posture from GoalResource instead.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GoalTemplate,
    ServiceGroupParameters
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-30-preview."
  @doc("Updates a goal template. Deprecated: the GoalTemplate resource type is deprecated and is removed in 2026-09-30-preview. Set resiliency intent directly on the GoalAssignment (requireZonalResiliency, requireRegionalResiliency) and read resource posture from GoalResource (zonalResiliency, regionalResiliency) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Set resiliency intent on GoalAssignment and read resource posture from GoalResource instead.")
  update is ArmResourcePatchAsync<
    GoalTemplate,
    GoalTemplateProperties,
    ServiceGroupParameters,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-30-preview."
  @doc("Deletes a goal template. Deprecated: the GoalTemplate resource type is deprecated and is removed in 2026-09-30-preview. Set resiliency intent directly on the GoalAssignment (requireZonalResiliency, requireRegionalResiliency) and read resource posture from GoalResource (zonalResiliency, regionalResiliency) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Set resiliency intent on GoalAssignment and read resource posture from GoalResource instead.")
  delete is ArmResourceDeleteWithoutOkAsync<
    GoalTemplate,
    ServiceGroupParameters
  >;

  #deprecated "GoalTemplate is deprecated and removed in 2026-09-30-preview."
  @doc("Lists the goal templates of a service group. Deprecated: the GoalTemplate resource type is deprecated and is removed in 2026-09-30-preview. Set resiliency intent directly on the GoalAssignment (requireZonalResiliency, requireRegionalResiliency) and read resource posture from GoalResource (zonalResiliency, regionalResiliency) instead.")
  @route(ServiceGroupRoute)
  @summary("Deprecated. Set resiliency intent on GoalAssignment and read resource posture from GoalResource instead.")
  list is ArmResourceListByParent<GoalTemplate, ServiceGroupTenantParameters>;
}

@armResourceOperations
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "GoalResources")
interface GoalResourcesOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("Get a GoalResource Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<GoalResource, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @doc("List GoalResource resources by GoalAssignment Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<GoalResource, ServiceGroupTenantParameters>;
}

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface GoalResources {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<GoalResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<GoalResource, ServiceGroupTenantParameters>;
}
