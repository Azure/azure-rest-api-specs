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
  is Azure.ResourceManager.ProxyResource<ArcDeploymentProperties, false> {
  ...ResourceNameParameter<
    Resource = ArcDeployment,
    KeyName = "deploymentName",
    SegmentName = "arcDeployments",
    NamePattern = "^[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?$"
  >;

  /**
   * The Arc deployment SKU. Only the SKU name is required for Arc deployments.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc defines its own SKU envelope for deployment resources."
  sku: ArcDeploymentSku;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name, matching existing deployment resources."
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias ArcDeploymentCreateLroHeaders = ArmCombinedLroHeaders<
  ArmOperationStatus,
  ArcDeployment
>;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Arc deployment PUT is create-only; updates are supported through PATCH."
  create is ArmResourceCreateOrReplaceAsync<
    ArcDeployment,
    LroHeaders = ArcDeploymentCreateLroHeaders,
    Response = ArmResourceCreatedResponse<
      ArcDeployment,
      ArcDeploymentCreateLroHeaders
    >
  >;

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
      ArmAsyncOperationHeader,
    PatchModel = ArcDeploymentUpdate
  >;

  /**
   * Deletes the specified Arc deployment associated with the Cognitive Services account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ArcDeployment,
    LroHeaders = ArmCombinedLroHeaders<ArmOperationStatus, void>,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
          ArmOperationStatus,
          void
        >>
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
   * Full Azure resource ID of the Foundry inference extension on the target Arc-enabled Kubernetes cluster. Required on creation and immutable after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extensionId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KubernetesConfiguration/extensions";
    }
  ]>;

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
  @maxValue(100)
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
   * The deployment state.
   */
  deploymentState?: DeploymentState;

  /**
   * The name of RAI policy.
   */
  raiPolicyName?: string;

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
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Arc deployment SKU is immutable after create; PATCH only supports replicas, resources, and nodeSelector."
@added(Versions.v2026_07_15_preview)
model ArcDeploymentUpdate {
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
  @maxValue(100)
  replicas?: int32;

  /**
   * Per-replica Kubernetes resource requests and limits.
   */
  resources?: ArcDeploymentPatchKubernetesResources;

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
  format: string;

  /**
   * Deployment model name.
   */
  name: string;
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
  onnx: "onnx-genai",
}

/**
 * Per-replica Kubernetes resource requests and limits for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentKubernetesResources {
  /**
   * Kubernetes CPU and memory resource requests for each deployment replica.
   */
  requests?: ArcDeploymentCpuMemoryResourceRequirements;

  /**
   * Kubernetes resource limits for each deployment replica.
   */
  limits?: ArcDeploymentResourceRequirements;
}

/**
 * Per-replica Kubernetes resource requests and limits for an Arc deployment update.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentPatchKubernetesResources {
  /**
   * Kubernetes CPU and memory resource requests for each deployment replica.
   */
  requests?: ArcDeploymentPatchCpuMemoryResourceRequirements;

  /**
   * Kubernetes resource limits for each deployment replica.
   */
  limits?: ArcDeploymentResourceRequirements;
}

/**
 * CPU and memory resource requirements for an Arc deployment replica.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentCpuMemoryResourceRequirements {
  /**
   * Kubernetes CPU quantity string, for example 500m, 2, 4, or 8.
   */
  cpu: string;

  /**
   * Kubernetes memory quantity string, for example 512Mi, 2Gi, or 16Gi.
   */
  memory: string;
}

/**
 * CPU and memory resource requirements for an Arc deployment replica update.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentPatchCpuMemoryResourceRequirements {
  /**
   * Kubernetes CPU quantity string, for example 500m, 2, 4, or 8.
   */
  cpu?: string;

  /**
   * Kubernetes memory quantity string, for example 512Mi, 2Gi, or 16Gi.
   */
  memory?: string;
}

/**
 * Kubernetes resource requirements for an Arc deployment replica.
 * Specify either cpu and memory together, or gpu. GPU is supported only in limits, not requests.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentResourceRequirements {
  /**
   * Kubernetes CPU quantity string, for example 500m, 2, 4, or 8.
   * Required with memory when specifying CPU and memory limits. Do not specify with gpu.
   */
  cpu?: string;

  /**
   * Kubernetes memory quantity string, for example 512Mi, 2Gi, or 16Gi.
   * Required with cpu when specifying CPU and memory limits. Do not specify with gpu.
   */
  memory?: string;

  /**
   * Kubernetes GPU quantity, for example 1, 2, or 5.
   * Required when specifying GPU limits. Do not specify with cpu or memory.
   */
  @minValue(1)
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
  value: ArcDeployment[];
}

/**
 * SKU for an Arc deployment.
 */
@added(Versions.v2026_07_15_preview)
model ArcDeploymentSku {
  /**
   * The name of the Arc deployment SKU. Must be Arc.
   */
  name: "Arc";
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
  "The name of the Arc deployment associated with the Cognitive Services Account. The name must be unique within the account across deployments, managedComputeDeployments, and arcDeployments."
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
