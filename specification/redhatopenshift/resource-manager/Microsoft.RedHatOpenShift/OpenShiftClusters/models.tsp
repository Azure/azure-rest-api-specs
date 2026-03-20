import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.RedHatOpenShift;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * ProvisioningState represents a provisioning state.
 */
union ProvisioningState {
  string,

  /**
   * AdminUpdating
   */
  AdminUpdating: "AdminUpdating",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * FipsValidatedModules determines if FIPS is used.
 */
union FipsValidatedModules {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The outbound routing strategy used to provide your cluster egress to the internet.
 */
union OutboundType {
  string,

  /**
   * Loadbalancer
   */
  Loadbalancer: "Loadbalancer",

  /**
   * UserDefinedRouting
   */
  UserDefinedRouting: "UserDefinedRouting",
}

/**
 * PreconfiguredNSG represents whether customers want to use their own NSG attached to the subnets
 */
union PreconfiguredNSG {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * EncryptionAtHost represents encryption at host state
 */
union EncryptionAtHost {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Visibility represents visibility.
 */
union Visibility {
  string,

  /**
   * Private
   */
  Private: "Private",

  /**
   * Public
   */
  Public: "Public",
}

/**
 * Operation represents an RP operation.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The object that describes the operation.
   */
  display?: Display;

  /**
   * Sources of requests to this operation.  Comma separated list with valid values user or system, e.g. "user,system".
   */
  origin?: string;
}

/**
 * OperationList represents an RP operation list.
 */
model OperationList is Azure.Core.Page<Operation>;

/**
 * Display represents the display details of an operation.
 */
model Display {
  /**
   * Friendly name of the resource provider.
   */
  provider?: string;

  /**
   * Resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * Operation type: read, write, delete, listKeys/action, etc.
   */
  operation?: string;

  /**
   * Friendly name of the operation.
   */
  description?: string;
}

/**
 * CloudError represents a cloud error.
 */
@error
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * CloudErrorBody represents the body of a cloud error.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#[])
  details?: CloudErrorBody[];
}

/**
 * OpenShiftVersionList represents a List of available versions.
 */
model OpenShiftVersionList is Azure.Core.Page<OpenShiftVersion>;

/**
 * OpenShiftVersionProperties represents the properties of an OpenShiftVersion.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OpenShiftVersionProperties {
  /**
   * Version represents the version to create the cluster at.
   */
  version?: string;
}

/**
 * PlatformWorkloadIdentityRoleSetList represents a List of role sets.
 */
model PlatformWorkloadIdentityRoleSetList
  is Azure.Core.Page<PlatformWorkloadIdentityRoleSet>;

/**
 * PlatformWorkloadIdentityRoleSetProperties represents the properties of a PlatformWorkloadIdentityRoleSet resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PlatformWorkloadIdentityRoleSetProperties {
  /**
   * OpenShiftVersion represents the version associated with this set of roles.
   */
  openShiftVersion?: string;

  /**
   * PlatformWorkloadIdentityRoles represents the set of roles associated with this version.
   */
  @identifiers(#[])
  platformWorkloadIdentityRoles?: PlatformWorkloadIdentityRole[];
}

/**
 * PlatformWorkloadIdentityRole represents a mapping from a particular OCP operator to the built-in role that should be assigned to that operator's corresponding managed identity.
 */
model PlatformWorkloadIdentityRole {
  /**
   * OperatorName represents the name of the operator that this role is for.
   */
  operatorName?: string;

  /**
   * RoleDefinitionName represents the name of the role.
   */
  roleDefinitionName?: string;

  /**
   * RoleDefinitionID represents the resource ID of the role definition.
   */
  roleDefinitionId?: string;
}

/**
 * OpenShiftClusterList represents a list of OpenShift clusters.
 */
model OpenShiftClusterList is Azure.Core.Page<OpenShiftCluster>;

/**
 * OpenShiftClusterProperties represents an OpenShift cluster's properties.
 */
model OpenShiftClusterProperties {
  /**
   * The cluster provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Existing property from original swagger"
  provisioningState?: ProvisioningState;

  /**
   * The cluster profile.
   */
  clusterProfile?: ClusterProfile;

  /**
   * The console profile.
   */
  consoleProfile?: ConsoleProfile;

  /**
   * The cluster service principal profile.
   */
  servicePrincipalProfile?: ServicePrincipalProfile;

  /**
   * The workload identity profile.
   */
  platformWorkloadIdentityProfile?: PlatformWorkloadIdentityProfile;

  /**
   * The cluster network profile.
   */
  networkProfile?: NetworkProfile;

  /**
   * The cluster master profile.
   */
  masterProfile?: MasterProfile;

  /**
   * The cluster worker profiles.
   */
  @identifiers(#[])
  workerProfiles?: WorkerProfile[];

  /**
   * The cluster worker profiles status.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  workerProfilesStatus?: WorkerProfile[];

  /**
   * The cluster API server profile.
   */
  apiserverProfile?: APIServerProfile;

  /**
   * The cluster ingress profiles.
   */
  @identifiers(#[])
  ingressProfiles?: IngressProfile[];
}

/**
 * ClusterProfile represents a cluster profile.
 */
model ClusterProfile {
  /**
   * The pull secret for the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Existing property from original swagger"
  pullSecret?: string;

  /**
   * The domain for the cluster.
   */
  domain?: string;

  /**
   * The version of the cluster.
   */
  version?: string;

  /**
   * The ID of the cluster resource group.
   */
  resourceGroupId?: string;

  /**
   * If FIPS validated crypto modules are used
   */
  fipsValidatedModules?: FipsValidatedModules;

  /**
   * The URL of the managed OIDC issuer in a workload identity cluster.
   */
  @visibility(Lifecycle.Read)
  oidcIssuer?: string;
}

/**
 * ConsoleProfile represents a console profile.
 */
model ConsoleProfile {
  /**
   * The URL to access the cluster console.
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * ServicePrincipalProfile represents a service principal profile.
 */
model ServicePrincipalProfile {
  /**
   * The client ID used for the cluster.
   */
  clientId?: string;

  /**
   * The client secret used for the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Existing property from original swagger"
  clientSecret?: string;
}

/**
 * PlatformWorkloadIdentityProfile encapsulates all information that is specific to workload identity clusters.
 */
model PlatformWorkloadIdentityProfile {
  /**
   * UpgradeableTo stores a single OpenShift version a workload identity cluster can be upgraded to
   */
  upgradeableTo?: string;

  /**
   * Dictionary of <PlatformWorkloadIdentity>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  platformWorkloadIdentities?: Record<PlatformWorkloadIdentity>;
}

/**
 * PlatformWorkloadIdentity stores information representing a single workload identity.
 */
model PlatformWorkloadIdentity {
  /**
   * The resource ID of the PlatformWorkloadIdentity resource
   */
  resourceId?: string;

  /**
   * The ClientID of the PlatformWorkloadIdentity resource
   */
  @visibility(Lifecycle.Read)
  clientId?: string;

  /**
   * The ObjectID of the PlatformWorkloadIdentity resource
   */
  @visibility(Lifecycle.Read)
  objectId?: string;
}

/**
 * NetworkProfile represents a network profile.
 */
model NetworkProfile {
  /**
   * The CIDR used for OpenShift/Kubernetes Pods.
   */
  podCidr?: string;

  /**
   * The CIDR used for OpenShift/Kubernetes Services.
   */
  serviceCidr?: string;

  /**
   * The OutboundType used for egress traffic.
   */
  outboundType?: OutboundType;

  /**
   * The cluster load balancer profile.
   */
  loadBalancerProfile?: LoadBalancerProfile;

  /**
   * Specifies whether subnets are pre-attached with an NSG
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
  preconfiguredNSG?: PreconfiguredNSG;
}

/**
 * LoadBalancerProfile represents the profile of the cluster public load balancer.
 */
model LoadBalancerProfile {
  /**
   * The desired managed outbound IPs for the cluster public load balancer.
   */
  managedOutboundIps?: ManagedOutboundIPs;

  /**
   * The list of effective outbound IP addresses of the public load balancer.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  effectiveOutboundIps?: EffectiveOutboundIP[];
}

/**
 * ManagedOutboundIPs represents the desired managed outbound IPs for the cluster public load balancer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing model from original swagger"
model ManagedOutboundIPs {
  /**
   * Count represents the desired number of IPv4 outbound IPs created and managed by Azure for the cluster public load balancer.  Allowed values are in the range of 1 - 20.  The default value is 1.
   */
  count?: int32;
}

/**
 * EffectiveOutboundIP represents an effective outbound IP resource of the cluster public load balancer.
 */
model EffectiveOutboundIP {
  /**
   * The fully qualified Azure resource id of an IP address resource.
   */
  id?: string;
}

/**
 * MasterProfile represents a master profile.
 */
model MasterProfile {
  /**
   * The size of the master VMs.
   */
  vmSize?: string;

  /**
   * The Azure resource ID of the master subnet.
   */
  subnetId?: string;

  /**
   * Whether master virtual machines are encrypted at host.
   */
  encryptionAtHost?: EncryptionAtHost;

  /**
   * The resource ID of an associated DiskEncryptionSet, if applicable.
   */
  diskEncryptionSetId?: string;
}

/**
 * WorkerProfile represents a worker profile.
 */
model WorkerProfile {
  /**
   * The worker profile name.
   */
  name?: string;

  /**
   * The size of the worker VMs.
   */
  vmSize?: string;

  /**
   * The disk size of the worker VMs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
  diskSizeGB?: int32;

  /**
   * The Azure resource ID of the worker subnet.
   */
  subnetId?: string;

  /**
   * The number of worker VMs.
   */
  count?: int32;

  /**
   * Whether master virtual machines are encrypted at host.
   */
  encryptionAtHost?: EncryptionAtHost;

  /**
   * The resource ID of an associated DiskEncryptionSet, if applicable.
   */
  diskEncryptionSetId?: string;
}

/**
 * APIServerProfile represents an API server profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing model from original swagger"
model APIServerProfile {
  /**
   * API server visibility.
   */
  visibility?: Visibility;

  /**
   * The URL to access the cluster API server.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * The IP of the cluster API server.
   */
  @visibility(Lifecycle.Read)
  ip?: string;
}

/**
 * IngressProfile represents an ingress profile.
 */
model IngressProfile {
  /**
   * The ingress profile name.
   */
  name?: string;

  /**
   * Ingress visibility.
   */
  visibility?: Visibility;

  /**
   * The IP of the ingress.
   */
  @visibility(Lifecycle.Read)
  ip?: string;
}

/**
 * OpenShiftCluster represents an Azure Red Hat OpenShift cluster.
 */
model OpenShiftClusterUpdate {
  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The cluster properties.
   */
  properties?: OpenShiftClusterProperties;

  /**
   * Identity stores information about the cluster MSI(s) in a workload identity cluster.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * OpenShiftClusterAdminKubeconfig represents an OpenShift cluster's admin kubeconfig.
 */
model OpenShiftClusterAdminKubeconfig {
  /**
   * The base64-encoded kubeconfig file.
   */
  @secret
  kubeconfig?: string;
}

/**
 * OpenShiftClusterCredentials represents an OpenShift cluster's credentials.
 */
model OpenShiftClusterCredentials {
  /**
   * The username for the kubeadmin user.
   */
  kubeadminUsername?: string;

  /**
   * The password for the kubeadmin user.
   */
  @secret
  kubeadminPassword?: string;
}
