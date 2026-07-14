import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Cognitive Services account Arc deployment, backed by customer-managed Arc-enabled Kubernetes resources.
 */
@added(Versions.v2026_07_15_preview)
@parentResource(Account)
model ArcDeployment
  is Azure.ResourceManager.ProxyResource<ArcDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = ArcDeployment,
    KeyName = "deploymentName",
    SegmentName = "arcDeployments",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;

  /**
   * The Arc deployment SKU. Only the SKU name is required for Arc deployments.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc defines its own SKU envelope for deployment resources."
  sku?: ArcDeploymentSku;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name, matching existing deployment resources."
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing deployment resources define tags on the resource envelope for backward compatibility."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type is used to support extensible resource tags."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@added(Versions.v2026_07_15_preview)
@armResourceOperations
interface ArcDeployments {
  /**
   * Gets the specified Arc deployment associated with the Cognitive Services account.
   */
  get is ArmResourceRead<ArcDeployment>;

  /**
   * Creates an Arc deployment associated with the Cognitive Services account.
   */
  create is ArmResourceCreateOrReplaceAsync<ArcDeployment>;

  /**
   * Updates the specified Arc deployment associated with the Cognitive Services account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ArcDeployment,
    LroHeaders = ArmLroLocationHeader<
      Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
      ArcDeployment,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader,
    PatchModel = ArcDeploymentUpdate
  >;

  /**
   * Deletes the specified Arc deployment associated with the Cognitive Services account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArcDeployment,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
          ArmOperationStatus,
          void
        > &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets the Arc deployments associated with the Cognitive Services account.
   */
  list is ArmResourceListByParent<
    ArcDeployment,
    Response = ArcDeploymentListResult
  >;
}

/**
 * Properties of a Cognitive Services Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentProperties {
  /**
   * Model reference. Required on creation and immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `model`: ArcDeploymentModel;

  /**
   * Full Azure resource ID of the Arc-enabled Kubernetes cluster extension. Required on creation and immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extensionId: string;

  /**
   * Inference runtime. Required on creation and immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  runtime: ArcDeploymentRuntime;

  /**
   * Compute type for the deployment. Required on creation and immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  compute: ArcDeploymentComputeType;

  /**
   * Optional deployment template identifier for advanced vLLM tuning. Allowed only when runtime is vllm.
   * Example: azureml://registries/{registry}/deploymenttemplates/{template}/versions/{version}
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deploymentTemplate?: string;

  /**
   * Read-only. Effective vLLM runtime parameters resolved for the deployed model. Returned only when runtime is vllm.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<vllmParameters> type is used because effective vLLM parameter keys can evolve over time."
  @visibility(Lifecycle.Read)
  vllmParameters?: ArcDeploymentVllmParameters;

  /**
   * Physical replica count on the Arc cluster.
   */
  @minValue(1)
  replicas: int32;

  /**
   * Per-replica Kubernetes resource requests and limits.
   */
  resources: ArcDeploymentKubernetesResources;

  /**
   * Kubernetes node selector key-value map used to schedule pods onto nodes with matching labels.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<nodeSelector> type is used because Kubernetes node label keys are user-defined."
  nodeSelector?: Record<string>;

  /**
   * Read-only. Current provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Read-only. Status message and timestamp from the last provisioning operation.
   */
  @visibility(Lifecycle.Read)
  provisioningDetails?: ArcDeploymentProvisioningDetails;

  /**
   * Read-only. Base URL for inference calls to this deployment on the Arc cluster. Populated when provisioningState is Succeeded.
   */
  @visibility(Lifecycle.Read)
  inferenceEndpoint?: string;

  /**
   * Read-only. Deployment capabilities represented as key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<capabilities> type is used because model/runtime capability keys are dynamic."
  @visibility(Lifecycle.Read)
  capabilities?: Record<string>;
}

/**
 * The object used to update an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Arc deployment SKU is immutable after create; PATCH only supports tags plus replicas, resources, and nodeSelector."
model ArcDeploymentUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<tags> type is used to support extensible resource tags."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * Properties that can be updated on an Arc deployment.
   */
  properties?: ArcDeploymentUpdateProperties;
}

/**
 * Mutable properties for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentUpdateProperties {
  /**
   * Physical replica count on the Arc cluster.
   */
  @minValue(1)
  replicas?: int32;

  /**
   * Per-replica Kubernetes resource requests and limits.
   */
  resources?: ArcDeploymentKubernetesResources;

  /**
   * Kubernetes node selector key-value map used to schedule pods onto nodes with matching labels.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<nodeSelector> type is used because Kubernetes node label keys are user-defined."
  nodeSelector?: Record<string>;
}

/**
 * Model reference for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentModel {
  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * Deployment model name.
   */
  name?: string;
}

/**
 * Compute type for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
union ArcDeploymentComputeType {
  string,

  /**
   * GPU compute.
   */
  gpu: "gpu",

  /**
   * CPU compute.
   */
  cpu: "cpu",

  /**
   * NPU compute.
   */
  npu: "npu",
}

/**
 * Inference runtime for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
union ArcDeploymentRuntime {
  string,

  /**
   * vLLM runtime.
   */
  vllm: "vllm",

  /**
   * ONNX runtime.
   */
  onnxGenAi: "onnx-genai",
}

/**
 * Per-replica Kubernetes resource requests and limits for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentKubernetesResources {
  /**
   * Kubernetes resource requests for each deployment replica.
   */
  requests?: ArcDeploymentResourceRequirements;

  /**
   * Kubernetes resource limits for each deployment replica.
   */
  limits?: ArcDeploymentResourceRequirements;
}

/**
 * Kubernetes resource requirements for an Arc deployment replica.
 * Specify either cpu and memory together, or gpu. Do not combine CPU/memory and GPU in the same resource requirement.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentResourceRequirements {
  /**
   * Kubernetes CPU quantity string, for example 500m, 2, 4, or 8.
   * Required when specifying CPU and memory resources. Do not specify with gpu.
   */
  cpu?: string;

  /**
   * Kubernetes memory quantity string, for example 512Mi, 2Gi, or 16Gi.
   * Required when specifying CPU and memory resources. Do not specify with gpu.
   */
  memory?: string;

  /**
   * Kubernetes GPU quantity, for example 1, 2, or 5.
   * Required when specifying GPU resources. Do not specify with cpu or memory.
   */
  gpu?: int32;
}

/**
 * Provisioning status details for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentProvisioningDetails {
  /**
   * A human-readable status message from the last provisioning operation.
   */
  message?: string;

  /**
   * Timestamp of the last provisioning operation.
   */
  lastOperationTimestamp?: utcDateTime;
}

/**
 * The list of Arc deployments.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentListResult {
  /**
   * The link used to get the next page of Arc deployments.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the list of Arc deployments and their properties.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ArcDeployment[];
}

/**
 * SKU for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentSku {
  /**
   * The name of the Arc deployment SKU. Must be Arc.
   */
  name: string;
}

/**
 * Effective vLLM runtime parameters for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentVllmParameters {
  ...Record<unknown>;
}

@@doc(
  ArcDeployment.name,
  "The name of the Arc deployment associated with the Cognitive Services Account."
);
@@encodedName(ArcDeployment.etag, "application/json", "etag");
@@doc(
  ArcDeployment.properties,
  "Properties of the Cognitive Services Arc deployment."
);
@@doc(
  ArcDeployments.create::parameters.resource,
  "The Arc deployment properties."
);
@@doc(
  ArcDeployments.update::parameters.properties,
  "The Arc deployment update properties."
);
