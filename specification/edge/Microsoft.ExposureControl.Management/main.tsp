import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./CommonResources.tsp";
import "./Groups.tsp";
import "./ExposureWorkflow.tsp";
import "./Features.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "ExposureControlService"
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

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface ExposureGroups extends Azure.ResourceManager.ProxyResourceOperations<ExposureGroup, ExposureGroupProperties> {
  get is ArmResourceRead<ExposureGroup>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureGroup>;
  delete is ArmResourceDeleteAsync<ExposureGroup>;
}

@armResourceOperations
interface ExposureFeatures extends Azure.ResourceManager.ProxyResourceOperations<ExposureFeature, ExposureFeatureProperties> {
  get is ArmResourceRead<ExposureFeature>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureFeature>;
  delete is ArmResourceDeleteAsync<ExposureFeature>;
}

@armResourceOperations
interface ExposureWorkflowManifests extends Azure.ResourceManager.ProxyResourceOperations<ExposureWorkflowManifest, ExposureWorkflowManifestProperties> {
  get is ArmResourceRead<ExposureWorkflowManifest>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureWorkflowManifest>;
  delete is ArmResourceDeleteAsync<ExposureWorkflowManifest>;
}

@armResourceOperations
interface ExposureWorkflows  extends Azure.ResourceManager.ProxyResourceOperations<ExposureWorkflow, ExposureWorkflowProperties>{
  get is ArmResourceRead<ExposureWorkflow>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExposureWorkflow>;
  delete is ArmResourceDeleteAsync<ExposureWorkflow>;
}

  @patch
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Edge/exposureWorkflows/{exposureWorkflowName}/updateStatus")
  @doc("update ring status in Exposure workflow")
  op updateWorkflowCurrentRingStatusAsync(subscriptionId : string, resourceGroupName: string, exposureWorkflowName: string, @body status: ExposureWorkflowStatus):ExposureWorkflow;