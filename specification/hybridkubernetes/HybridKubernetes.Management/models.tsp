import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Kubernetes;

/**
 * Indicates the kind of Arc connected cluster based on host infrastructure.
 */
union ConnectedClusterKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProvisionedCluster: "ProvisionedCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AWS: "AWS",
}

/**
 * The current deployment state of connectedClusters.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * Represents the connectivity status of the connected cluster.
 */
union ConnectivityStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connecting: "Connecting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AgentNotInstalled: "AgentNotInstalled",
}

/**
 * Property which describes the state of private link on a connected cluster resource.
 */
union PrivateLinkState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Indicates whether Azure Hybrid Benefit is opted in
 */
union AzureHybridBenefit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

/**
 * Indicates whether the Arc agents on the be upgraded automatically to the latest version. Defaults to Enabled.
 */
union AutoUpgradeOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The mode of client authentication.
 */
union AuthenticationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Token: "Token",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AAD: "AAD",
}

/**
 * The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  None,
  SystemAssigned,
}

/**
 * Identity for the connected cluster.
 */
model ConnectedClusterIdentity {
  /**
   * The principal id of connected cluster identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id associated with the connected cluster. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the connected cluster. The type 'SystemAssigned, includes a system created identity. The type 'None' means no identity is assigned to the connected cluster.
   */
  type: ResourceIdentityType = ResourceIdentityType.SystemAssigned;
}

/**
 * Properties of the connected cluster.
 */
model ConnectedClusterProperties {
  /**
   * Base64 encoded public certificate used by the agent to do the initial handshake to the backend services in Azure.
   */
  agentPublicKeyCertificate: string;

  /**
   * The Kubernetes version of the connected cluster resource
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * Number of nodes present in the connected cluster resource
   */
  @visibility(Lifecycle.Read)
  totalNodeCount?: int32;

  /**
   * Number of CPU cores present in the connected cluster resource
   */
  @visibility(Lifecycle.Read)
  totalCoreCount?: int32;

  /**
   * Version of the agent running on the connected cluster resource
   */
  @visibility(Lifecycle.Read)
  agentVersion?: string;

  /**
   * Provisioning state of the connected cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * The Kubernetes distribution running on this connected cluster.
   */
  distribution?: string;

  /**
   * The Kubernetes distribution version on this connected cluster.
   */
  distributionVersion?: string;

  /**
   * The infrastructure on which the Kubernetes cluster represented by this connected cluster is running on.
   */
  infrastructure?: string;

  /**
   * Connected cluster offering
   */
  @visibility(Lifecycle.Read)
  offering?: string;

  /**
   * Expiration time of the managed identity certificate
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  managedIdentityCertificateExpirationTime?: utcDateTime;

  /**
   * Time representing the last instance when heart beat was received from the cluster
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectivityTime?: utcDateTime;

  /**
   * Represents the connectivity status of the connected cluster.
   */
  @visibility(Lifecycle.Read)
  connectivityStatus?: ConnectivityStatus;

  /**
   * Property which describes the state of private link on a connected cluster resource.
   */
  privateLinkState?: PrivateLinkState = PrivateLinkState.Disabled;

  /**
   * This is populated only if privateLinkState is enabled. The resource id of the private link scope this connected cluster is assigned to, if any.
   */
  privateLinkScopeResourceId?: string;

  /**
   * Indicates whether Azure Hybrid Benefit is opted in
   */
  azureHybridBenefit?: AzureHybridBenefit = "NotApplicable";

  /**
   * AAD profile for the connected cluster.
   */
  aadProfile?: AadProfile;

  /**
   * Arc agentry configuration for the provisioned cluster.
   */
  arcAgentProfile?: ArcAgentProfile;

  /**
   * Security profile for the connected cluster.
   */
  securityProfile?: SecurityProfile;

  /**
   * Open ID Connect (OIDC) Issuer Profile for the connected cluster.
   */
  oidcIssuerProfile?: OidcIssuerProfile;

  /**
   * Details of the gateway used by the Arc router for connectivity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gateway?: Gateway | null;

  /**
   * Configuration settings for customizing the behavior of the connected cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arcAgentryConfigurations?: ArcAgentryConfigurations[] | null;

  /**
   * More properties related to the Connected Cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  miscellaneousProperties?: Record<string>;
}

/**
 * AAD Profile specifies attributes for Azure Active Directory integration.
 */
model AadProfile {
  /**
   * Whether to enable Azure RBAC for Kubernetes authorization.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableAzureRBAC?: boolean;

  /**
   * The list of AAD group object IDs that will have admin role of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  adminGroupObjectIDs?: string[];

  /**
   * The AAD tenant ID to use for authentication. If not specified, will use the tenant of the deployment subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantID?: string;
}

/**
 * Defines the Arc Agent properties for the clusters.
 */
model ArcAgentProfile {
  /**
   * Version of the Arc agents to be installed on the cluster resource
   */
  desiredAgentVersion?: string;

  /**
   * Indicates whether the Arc agents on the be upgraded automatically to the latest version. Defaults to Enabled.
   */
  agentAutoUpgrade?: AutoUpgradeOptions = AutoUpgradeOptions.Enabled;

  /**
   * List of system extensions that are installed on the cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemComponents?: SystemComponent[];

  /**
   * List of arc agentry and system components errors on the cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  agentErrors?: AgentError[];

  /**
   * Represents the current state of the Arc agentry and its dependent components.
   */
  @visibility(Lifecycle.Read)
  agentState?: string;
}

/**
 * System extensions and its current versions installed on the cluster resource.
 */
model SystemComponent {
  /**
   * Type of the system extension
   */
  type?: string;

  /**
   * Version of the system extension to be installed on the cluster resource.
   */
  userSpecifiedVersion?: string;

  /**
   * Major Version of the system extension that is currently installed on the cluster resource.
   */
  majorVersion?: int32;

  /**
   * Version of the system extension that is currently installed on the cluster resource.
   */
  @visibility(Lifecycle.Read)
  currentVersion?: string;
}

/**
 * Agent Errors if any during agent or system component upgrade.
 */
model AgentError {
  /**
   * Agent error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Severity of the error message.
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Agent component where error message occured.
   */
  @visibility(Lifecycle.Read)
  component?: string;

  /**
   * The timestamp of error occured (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Security Profile specifies attributes for cluster security features.
 */
model SecurityProfile {
  /**
   * The workload identity feature webhook.
   */
  workloadIdentity?: SecurityProfileWorkloadIdentity;
}

/**
 * The workload identity feature webhook.
 */
model SecurityProfileWorkloadIdentity {
  /**
   * Whether to enable or disable the workload identity Webhook
   */
  enabled?: boolean;
}

/**
 * OIDC Issuer Profile specifies attributes for workload identity integration.
 */
model OidcIssuerProfile {
  /**
   * Whether to enable oidc issuer for workload identity integration.
   */
  enabled?: boolean;

  /**
   * The issuer url for hybrid clusters connected to Arc used for the workload identity feature.
   */
  @visibility(Lifecycle.Read)
  issuerUrl?: string;

  /**
   * The issuer url for public cloud clusters - AKS, EKS, GKE - used for the workload identity feature.
   */
  selfHostedIssuerUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Gateway {
  /**
   * Indicates whether the gateway for arc router connectivity is enabled.
   */
  enabled?: boolean;

  /**
   * The resource ID of the gateway used for the Arc router feature.
   */
  @removed(Versions.v2025_08_01_preview)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/gateways";
    }
  ]>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ArcAgentryConfigurations {
  /**
   * Specifies the name of the feature for the configuration setting.
   */
  feature?: string;

  /**
   * The configuration settings for the feature that do not contain any sensitive or secret information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: Record<string> | null;

  /**
   * The configuration settings for the feature that contain any sensitive or secret information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  protectedSettings?: Record<string> | null;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Object containing updates for patch operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectedClusterPatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Describes the connected cluster resource properties that can be updated during PATCH operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConnectedClusterPatchProperties;
}

/**
 * Properties which can be patched on the connected cluster resource.
 */
model ConnectedClusterPatchProperties {
  /**
   * Represents the distribution of the connected cluster
   */
  distribution?: string;

  /**
   * Represents the Kubernetes distribution version on this connected cluster.
   */
  distributionVersion?: string;

  /**
   * Indicates whether Azure Hybrid Benefit is opted in
   */
  azureHybridBenefit?: AzureHybridBenefit;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ListClusterUserCredentialProperties {
  /**
   * The mode of client authentication.
   */
  authenticationMethod: AuthenticationMethod;

  /**
   * Boolean value to indicate whether the request is for client side proxy or not
   */
  clientProxy: boolean;
}

/**
 * The list of credential result response.
 */
model CredentialResults {
  /**
   * Contains the REP (rendezvous endpoint) and “Sender” access token.
   */
  @visibility(Lifecycle.Read)
  hybridConnectionConfig?: HybridConnectionConfig;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  kubeconfigs?: CredentialResult[];
}

/**
 * Contains the REP (rendezvous endpoint) and “Sender” access token.
 */
model HybridConnectionConfig {
  /**
   * Timestamp when this token will be expired.
   */
  @visibility(Lifecycle.Read)
  expirationTime?: int64;

  /**
   * Name of the connection
   */
  @visibility(Lifecycle.Read)
  hybridConnectionName?: string;

  /**
   * Name of the relay.
   */
  @visibility(Lifecycle.Read)
  relay?: string;

  /**
   * Sender access token
   */
  @visibility(Lifecycle.Read)
  token?: string;

  /**
   * TenantID of the relay
   */
  @visibility(Lifecycle.Read)
  relayTid?: string;

  /**
   * Type of relay
   */
  @visibility(Lifecycle.Read)
  relayType?: string;
}

/**
 * The credential result response.
 */
model CredentialResult {
  /**
   * The name of the credential.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility(Lifecycle.Read)
  value?: bytes;
}

/**
 * The paginated list of connected Clusters
 */
model ConnectedClusterList is Azure.Core.Page<ConnectedCluster>;

/**
 * The paginated list of connected cluster API operations.
 */
@Azure.Core.pagedResult
model OperationList {
  /**
   * The list of connected cluster API operations.
   */
  @Azure.Core.items
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value: Operation[];

  /**
   * The link to fetch the next page of connected cluster API operations.
   */
  @nextLink
  nextLink?: string;
}
