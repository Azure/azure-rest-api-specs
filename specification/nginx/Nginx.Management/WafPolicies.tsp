import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Azure.ResourceManager;

namespace NGINX.NGINXPLUS;

/**
 * Represents a WAF policy resource under a given Nginx deployment.
 */
@parentResource(NginxDeployment)
model WafPolicy is ProxyResource<NginxDeploymentWafPolicyProperties> {
  ...ResourceNameParameter<WafPolicy>;
}

/**
 * Properties of a WAF policy resource.
 */
model NginxDeploymentWafPolicyProperties {
  /** The raw policy content (base64-encoded). */
  content: bytes;

  /** The file path of the WAF policy. */
  filepath: string;

  /** The provisioning state of the WAF policy. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The compiling status of the WAF policy. */
  compilingState: DeploymentWafPolicyCompilingStatus;

  /** The applying status of the WAF policy. */
  applyingState: DeploymentWafPolicyApplyingStatus;
}

/**
 * Compilation status for a WAF policy.
 */
model DeploymentWafPolicyCompilingStatus {
  /** The compilation status code. Can be any free form text */
  code: string;

  /** The human-readable compilation status. */
  displayStatus: string;

  /** The timestamp when compilation status was recorded in UTC timezone and RFC 3339 format.
   * Example: `2025-07-08T10:11:08.856Z`.
   */
  time: string;
}

/**
 * Applying status for a WAF policy.
 */
model DeploymentWafPolicyApplyingStatus {
  /** The apply status code. Can be any free form text */
  code: string;

  /** The human-readable apply status. */
  displayStatus: string;

  /** The timestamp when apply status was recorded in UTC. */
  time: string;
}

/**
 * Metadata for a WAF policy under an Nginx deployment.
 */
@parentResource(NginxDeployment)
@resource("wafPolicies")
model NginxDeploymentWafPolicyMetadata
  is ProxyResource<NginxDeploymentWafPolicyMetadataProperties> {
  ...ResourceNameParameter<NginxDeploymentWafPolicyMetadata>;
}

/**
 * Properties of a WAF policy metadata resource.
 */
model NginxDeploymentWafPolicyMetadataProperties {
  /** The file path of the WAF policy metadata. */
  filepath: string;

  /** The provisioning state of the WAF policy metadata. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The compiling status of the WAF policy metadata. */
  compilingState: DeploymentWafPolicyCompilingStatus;

  /** The applying status of the WAF policy metadata. */
  applyingState: DeploymentWafPolicyApplyingStatus;
}

/**
 * Operations on WAF policies under a given Nginx deployment.
 */
@armResourceOperations
interface WafPolicies {
  /** Read a specific WAF policy. */
  get is ArmResourceRead<WafPolicy>;

  /** Create or update a WAF policy. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WafPolicy>;

  /** Delete a specific WAF policy. */
  delete is ArmResourceDeleteWithoutOkAsync<WafPolicy>;

  /** List all WAF policies in a deployment. */
  listByDeployment is ArmResourceListByParent<NginxDeploymentWafPolicyMetadata>;
}
