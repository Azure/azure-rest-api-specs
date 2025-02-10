import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./CommonResources.tsp";
import "./ExposureGroups.tsp";
import "./ExposureWorkflow.tsp";
import "./ExposureFeatures.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of Edge RP in edge folder."
@armProviderNamespace
@service({
  title: "ExposureControlService",
})
@versioned(Versions)
@doc("Exposure Control Resource Provider Service API.")
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.Edge;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2024-01-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_00_01: "2024-01-01-preview",
}

@armResourceOperations
interface ExposureGroups
  extends Azure.ResourceManager.ProxyResourceOperations<
      ExposureGroup,
      ExposureGroupProperties
    > {
  get is ArmResourceRead<ExposureGroup>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureGroup>;
  delete is ArmResourceDeleteWithoutOkAsync<ExposureGroup>;
  listBySubscription is ArmListBySubscription<ExposureGroup>;
  listByResourceGroup is ArmResourceListByParent<
    ExposureGroup,
    Azure.ResourceManager.Foundations.BaseParameters<ExposureGroup> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter
  >;
}

@armResourceOperations
interface ExposureFeatures
  extends Azure.ResourceManager.ProxyResourceOperations<
      ExposureFeature,
      ExposureFeatureProperties
    > {
  get is ArmResourceRead<ExposureFeature>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureFeature>;
  delete is ArmResourceDeleteWithoutOkAsync<ExposureFeature>;
  listBySubscription is ArmListBySubscription<ExposureFeature>;
  listByResourceGroup is ArmResourceListByParent<
    ExposureFeature,
    Azure.ResourceManager.Foundations.BaseParameters<ExposureFeature> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter
  >;
}

@armResourceOperations
interface ExposureWorkflowManifests
  extends Azure.ResourceManager.ProxyResourceOperations<
      ExposureWorkflowManifest,
      ExposureWorkflowManifestProperties
    > {
  get is ArmResourceRead<ExposureWorkflowManifest>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureWorkflowManifest>;
  delete is ArmResourceDeleteWithoutOkAsync<ExposureWorkflowManifest>;
  listBySubscription is ArmListBySubscription<ExposureWorkflowManifest>;
  listByExposureFeature is ArmResourceListByParent<
    ExposureWorkflowManifest,
    Azure.ResourceManager.Foundations.BaseParameters<ExposureWorkflowManifest> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter
  >;
}

@armResourceOperations
interface ExposureWorkflows
  extends Azure.ResourceManager.ProxyResourceOperations<
      ExposureWorkflow,
      ExposureWorkflowProperties
    > {
  get is ArmResourceRead<ExposureWorkflow>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureWorkflow>;
  delete is ArmResourceDeleteWithoutOkAsync<ExposureWorkflow>;
  listBySubscription is ArmListBySubscription<ExposureWorkflow>;
  listByExposureFeature is ArmResourceListByParent<
    ExposureWorkflow,
    Azure.ResourceManager.Foundations.BaseParameters<ExposureWorkflow> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter
  >;
  update is ArmCustomPatchSync<ExposureWorkflow, ExposureWorkflowUpdate>;
}

@@visibility(Azure.Core.Page.nextLink);
