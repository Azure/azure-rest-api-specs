import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The provisioning state of the Kubernetes version resource.
 */
@added(Versions.v2026_01_01_preview)
union KubernetesVersionProvisioningState {
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
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",
}

/**
 * KubernetesVersionList represents a list of Kubernetes version resources.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionList is Azure.Core.Page<KubernetesVersion>;

/**
 * KubernetesVersionProperties contains the read-only properties describing available versions.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionProperties {
  ...KubernetesVersionStatus;

  /**
   * The provisioning state of the Kubernetes version resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubernetesVersionProvisioningState;
}

/**
 * KubernetesVersionStatus denotes the status of the Kubernetes version resource.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionStatus {
  /**
   * The list of available Kubernetes versions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["version"])
  values?: KubernetesVersionValue[];
}

/**
 * KubernetesVersionValue describes a specific Kubernetes version that can be deployed.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionValue {
  /**
   * Additional description for the Kubernetes version.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The Kubernetes version identifier.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * KubernetesVersionPatchParameters represents the body of the request to patch Kubernetes version tags.
 */
@added(Versions.v2026_01_01_preview)
model KubernetesVersionPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}
