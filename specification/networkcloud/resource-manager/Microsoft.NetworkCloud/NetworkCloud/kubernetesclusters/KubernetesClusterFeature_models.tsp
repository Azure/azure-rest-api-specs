import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The lifecycle indicator of the feature.
 */
union KubernetesClusterFeatureAvailabilityLifecycle {
  string,

  /**
   * Preview availability
   */
  Preview: "Preview",

  /**
   * Generally available
   */
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The detailed status of the feature.
 */
union KubernetesClusterFeatureDetailedStatus {
  string,

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Installed status.
   */
  Installed: "Installed",
}

/**
 * The provisioning state of the Kubernetes cluster feature.
 */
union KubernetesClusterFeatureProvisioningState {
  string,

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Deleting status.
   */
  Deleting: "Deleting",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Updating status.
   */
  Updating: "Updating",
}

/**
 * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
 */
union KubernetesClusterFeatureRequired {
  string,

  /**
   * A required feature.
   */
  True: "True",

  /**
   * An optional feature.
   */
  False: "False",
}

/**
 * StringKeyValuePair represents a single entry in a mapping of keys to values.
 */
model StringKeyValuePair {
  /**
   * The key to the mapped value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  key: string;

  /**
   * The value of the mapping key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  value: string;
}

/**
 * KubernetesClusterFeatureList represents the list of Kubernetes cluster feature resources.
 */
model KubernetesClusterFeatureList is Azure.Core.Page<KubernetesClusterFeature>;

/**
 * KubernetesClusterFeatureProperties represents the properties of a Kubernetes cluster feature.
 */
model KubernetesClusterFeatureProperties {
  ...KubernetesClusterFeatureWritableProperties;
  ...KubernetesClusterFeatureReadOnlyProperties;

  /**
   * The provisioning state of the Kubernetes cluster feature.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubernetesClusterFeatureProvisioningState;
}

/**
 * KubernetesClusterFeatureWritableProperties represents the writable properties of a Kubernetes cluster feature. These properties can be set when creating or updating the resource.
 */
model KubernetesClusterFeatureWritableProperties {
  /**
   * The configured options for the feature.
   */
  @identifiers(#["key"])
  options?: StringKeyValuePair[];
}

/**
 * KubernetesClusterFeatureReadOnlyProperties represents the read-only properties of a Kubernetes cluster feature.
 */
model KubernetesClusterFeatureReadOnlyProperties {
  /**
   * The lifecycle indicator of the feature.
   */
  @visibility(Lifecycle.Read)
  availabilityLifecycle?: KubernetesClusterFeatureAvailabilityLifecycle;

  /**
   * The detailed status of the feature.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterFeatureDetailedStatus;

  /**
   * The descriptive message for the detailed status of the feature.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
   */
  @visibility(Lifecycle.Read)
  required?: KubernetesClusterFeatureRequired;

  /**
   * The version of the feature.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * KubernetesClusterFeaturePatchParameters represents the body of the request to patch the Kubernetes cluster feature.
 */
model KubernetesClusterFeaturePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: KubernetesClusterFeaturePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * KubernetesClusterFeaturePatchableProperties represents the properties of the Kubernetes cluster feature that can be patched.
 * This is a subset of the writable properties.
 */
model KubernetesClusterFeaturePatchableProperties {
  /**
   * The configured options for the feature.
   */
  @identifiers(#["key"])
  options?: StringKeyValuePair[];
}

/**
 * KubernetesClusterFeaturePatchProperties represents the Kubernetes cluster feature properties for patching.
 */
model KubernetesClusterFeaturePatchProperties {
  ...KubernetesClusterFeaturePatchableProperties;
}
