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
  compilingState: NginxDeploymentWafPolicyCompilingStatus;

  /** The applying status of the WAF policy. */
  applyingState: NginxDeploymentWafPolicyApplyingStatus;
}

/**
 * Compilation status for a WAF policy.
 */
model NginxDeploymentWafPolicyCompilingStatus {
  /** The compilation status code. */
  code: string;

  /** The human-readable compilation status. */
  displayStatus: string;

  /** The timestamp when compilation status was recorded. */
  time: string;
}

/**
 * Applying status for a WAF policy.
 */
model NginxDeploymentWafPolicyApplyingStatus {
  /** The apply status code. */
  code: string;

  /** The human-readable apply status. */
  displayStatus: string;

  /** The timestamp when apply status was recorded. */
  time: string;
}

/**
 * Response model for listing WAF policy metadata.
 */
model WafPolicyMetadataListResponse {
  /** The collection of WAF policy metadata. */
  value: NginxDeploymentWafPolicyMetadata[];

  /** The link to the next page of results. */
  nextLink?: string;
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
  compilingState: NginxDeploymentWafPolicyCompilingStatus;

  /** The applying status of the WAF policy metadata. */
  applyingState: NginxDeploymentWafPolicyApplyingStatus;
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
