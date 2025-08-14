import "./Common/ArmModels/AssessmentProjectV2.tsp";
import "./AssessmentProjectSummary.tsp";
import "./PrivateLinkResource.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@armResourceOperations
interface AssessmentProjectsOperations {
  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessmentProject>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  create is ArmResourceCreateOrUpdateAsync<AssessmentProject>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  update is ArmResourcePatchAsync<AssessmentProject, ProjectProperties>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<AssessmentProject>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AssessmentProject>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  listBySubscription is ArmListBySubscription<AssessmentProject>;
}

@armResourceOperations
interface AssessmentProjectSummaryOperations {
  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<AssessmentProjectSummary>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<AssessmentProjectSummary>;
}

@armResourceOperations
interface PrivateEndpointConnectionOperations {
  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<PrivateEndpointConnection>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<PrivateEndpointConnection>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  update is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;
}

@armResourceOperations
interface PrivateLinkResourceOperations {
  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  get is ArmResourceRead<PrivateLinkResource>;

  @added(AssessmentProjectApiVersions.v2024_03_03_preview)
  listByParent is ArmResourceListByParent<PrivateLinkResource>;
}
