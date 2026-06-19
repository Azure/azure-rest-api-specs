import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/**
 * Scope at which the configuration will be installed.
 */
union ScopeType {
  string,

  /**
   * cluster
   */
  cluster: "cluster",

  /**
   * namespace
   */
  `namespace`: "namespace",
}

/**
 * Source Kind to pull the configuration data from.
 */
union SourceKindType {
  string,

  /**
   * GitRepository
   */
  GitRepository: "GitRepository",

  /**
   * Bucket
   */
  Bucket: "Bucket",

  /**
   * AzureBlob
   */
  AzureBlob: "AzureBlob",

  /**
   * OCIRepository
   */
  OCIRepository: "OCIRepository",
}

/**
 * Name of the provider used for authentication.
 */
union ProviderType {
  string,

  /**
   * Azure provider can be used to authenticate to Azure DevOps repositories using Managed Identity.
   */
  Azure: "Azure",

  /**
   * GitHub provider can be used to authenticate
   */
  GitHub: "GitHub",

  /**
   * Generic is the default provider that indicates secret-based authentication mechanism.
   */
  Generic: "Generic",
}

/**
 * The operation to be performed on the selected layer. The default value is 'extract', but it can be set to 'copy'.
 */
union OperationType {
  string,

  /**
   * extract
   */
  extract: "extract",

  /**
   * copy
   */
  copy: "copy",
}

/**
 * Compliance state of the cluster object.
 */
union FluxComplianceState {
  string,

  /**
   * Compliant
   */
  Compliant: "Compliant",

  /**
   * Non-Compliant
   */
  `Non-Compliant`: "Non-Compliant",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

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
 * Specify whether to validate the Kubernetes objects referenced in the Kustomization before applying them to the cluster.
 */
union KustomizationValidationType {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * client
   */
  client: "client",

  /**
   * server
   */
  server: "server",
}

/**
 * Properties to create a Flux Configuration resource
 */
model FluxConfigurationProperties {
  /**
   * Scope at which the operator will be installed.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scope?: ScopeType = ScopeType.cluster;

  /**
   * The namespace to which this configuration is installed to. Maximum of 253 lower case alphanumeric characters, hyphen and period only.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `namespace`?: string = "default";

  /**
   * Source Kind to pull the configuration data from.
   */
  sourceKind?: SourceKindType = SourceKindType.GitRepository;

  /**
   * Whether this configuration should suspend its reconciliation of its kustomizations and sources.
   */
  suspend?: boolean = false;

  /**
   * Parameters to reconcile to the GitRepository source kind type.
   */
  gitRepository?: GitRepositoryDefinition;

  /**
   * Parameters to reconcile to the Bucket source kind type.
   */
  bucket?: BucketDefinition;

  /**
   * Parameters to reconcile to the AzureBlob source kind type.
   */
  azureBlob?: AzureBlobDefinition;

  /**
   * Parameters to reconcile to the OCIRepository source kind type.
   */
  ociRepository?: OCIRepositoryDefinition;

  /**
   * Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kustomizations?: Record<KustomizationDefinition> | null;

  /**
   * Key-value pairs of protected configuration settings for the configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  configurationProtectedSettings?: Record<string> | null;

  /**
   * Statuses of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects provisioned by the fluxConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  statuses?: ObjectStatusDefinition[] | null;

  /**
   * Public Key associated with this fluxConfiguration (either generated within the cluster or provided by the user).
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  repositoryPublicKey?: string | null;

  /**
   * Branch and/or SHA of the source commit synced with the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceSyncedCommitId?: string | null;

  /**
   * Datetime the fluxConfiguration synced its source on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @visibility(Lifecycle.Read)
  sourceUpdatedAt?: utcDateTime | null;

  /**
   * Datetime the fluxConfiguration synced its status on the cluster with Azure.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @visibility(Lifecycle.Read)
  statusUpdatedAt?: utcDateTime | null;

  /**
   * Whether flux configuration deployment should wait for cluster to reconcile the kustomizations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  waitForReconciliation?: boolean | null;

  /**
   * Maximum duration to wait for flux configuration reconciliation. E.g PT1H, PT5M, P1D
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reconciliationWaitDuration?: string | null;

  /**
   * Combined status of the Flux Kubernetes resources created by the fluxConfiguration or created by the managed objects.
   */
  @visibility(Lifecycle.Read)
  complianceState?: FluxComplianceState = FluxComplianceState.Unknown;

  /**
   * Status of the creation of the fluxConfiguration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Error message returned to the user in the case of provisioning failure.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorMessage?: string | null;
}

/**
 * Parameters to reconcile to the GitRepository source kind type.
 */
model GitRepositoryDefinition {
  /**
   * The URL to sync for the flux configuration git repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * The maximum time to attempt to reconcile the cluster git repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the cluster git repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null = 600;

  /**
   * The source reference for the GitRepository object.
   */
  repositoryRef?: RepositoryRefDefinition;

  /**
   * Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sshKnownHosts?: string | null;

  /**
   * Plaintext HTTPS username used to access private git repositories over HTTPS
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpsUser?: string | null;

  /**
   * Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpsCACert?: string | null;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;

  /**
   * Name of the provider used for authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider?: ProviderType | null;
}

/**
 * The source reference for the GitRepository object.
 */
model RepositoryRefDefinition {
  /**
   * The git repository branch name to checkout.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  branch?: string | null;

  /**
   * The git repository tag name to checkout. This takes precedence over branch.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tag?: string | null;

  /**
   * The semver range used to match against git repository tags. This takes precedence over tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  semver?: string | null;

  /**
   * The commit SHA to checkout. This value must be combined with the branch name to be valid. This takes precedence over semver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commit?: string | null;
}

/**
 * Parameters to reconcile to the Bucket source kind type.
 */
model BucketDefinition {
  /**
   * The URL to sync for the flux configuration S3 bucket.
   */
  url?: string;

  /**
   * The bucket name to sync from the url endpoint for the flux configuration.
   */
  bucketName?: string;

  /**
   * Specify whether to use insecure communication when puling data from the S3 bucket.
   */
  insecure?: boolean = true;

  /**
   * The maximum time to attempt to reconcile the cluster bucket source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the cluster bucket source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null = 600;

  /**
   * Plaintext access key used to securely access the S3 bucket
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKey?: string | null;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * Parameters to reconcile to the AzureBlob source kind type.
 */
model AzureBlobDefinition {
  /**
   * The URL to sync for the flux configuration Azure Blob storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * The Azure Blob container name to sync from the url endpoint for the flux configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerName?: string | null;

  /**
   * The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the cluster Azure Blob source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null = 600;

  /**
   * Parameters to authenticate using Service Principal.
   */
  servicePrincipal?: ServicePrincipalDefinition;

  /**
   * The account key (shared key) to access the storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  accountKey?: string | null;

  /**
   * The Shared Access token to access the storage container
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  sasToken?: string | null;

  /**
   * Parameters to authenticate using a Managed Identity.
   */
  managedIdentity?: ManagedIdentityDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * Parameters to authenticate using Service Principal.
 */
model ServicePrincipalDefinition {
  /**
   * The client Id for authenticating a Service Principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string | null;

  /**
   * The tenant Id for authenticating a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: string | null;

  /**
   * The client secret for authenticating a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientSecret?: string | null;

  /**
   * Base64-encoded certificate used to authenticate a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificate?: string | null;

  /**
   * The password for the certificate used to authenticate a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificatePassword?: string | null;

  /**
   * Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate
   */
  clientCertificateSendChain?: boolean = false;
}

/**
 * Parameters to authenticate using a Managed Identity.
 */
model ManagedIdentityDefinition {
  /**
   * The client Id for authenticating a Managed Identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string | null;
}

/**
 * Parameters to reconcile to the OCIRepository source kind type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OCIRepositoryDefinition {
  /**
   * The URL to sync for the flux configuration OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: url | null;

  /**
   * The maximum time to attempt to reconcile the cluster OCI repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the cluster OCI repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null = 600;

  /**
   * The source reference for the OCIRepository object.
   */
  repositoryRef?: OCIRepositoryRefDefinition;

  /**
   * The layer to be pulled from the OCI artifact.
   */
  layerSelector?: LayerSelectorDefinition;

  /**
   * Verification of the authenticity of an OCI Artifact.
   */
  verify?: VerifyDefinition;

  /**
   * Specify whether to allow connecting to a non-TLS HTTP container registry.
   */
  insecure?: boolean = false;

  /**
   * Specifies whether to use Workload Identity to authenticate with the OCI repository.
   */
  useWorkloadIdentity?: boolean = false;

  /**
   * The service account name to authenticate with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceAccountName?: string | null;

  /**
   * Parameters to authenticate using TLS config for OCI repository.
   */
  tlsConfig?: TlsConfigDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * The source reference for the OCIRepository object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OCIRepositoryRefDefinition {
  /**
   * The OCI repository image tag name to pull. This defaults to 'latest'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tag?: string | null;

  /**
   * The semver range used to match against OCI repository tags. This takes precedence over tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  semver?: string | null;

  /**
   * The image digest to pull from OCI repository, the value should be in the format ‘sha256:’. This takes precedence over semver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  digest?: string | null;
}

/**
 * Parameters to specify which layer to pull from the OCI artifact. By default, the first layer in the artifact is pulled.
 */
model LayerSelectorDefinition {
  /**
   * The first layer matching the specified media type will be used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mediaType?: string | null;

  /**
   * The operation to be performed on the selected layer. The default value is 'extract', but it can be set to 'copy'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operation?: OperationType | null;
}

/**
 * Parameters to verify the authenticity of an OCI Artifact.
 */
model VerifyDefinition {
  /**
   * Verification provider name.
   */
  provider?: string;

  /**
   * An object containing trusted public keys of trusted authors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  verificationConfig?: Record<string> | null;

  /**
   * Array defining the criteria for matching the identity while verifying an OCI artifact.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchOidcIdentity?: MatchOidcIdentityDefinition[] | null;
}

/**
 * MatchOIDCIdentity defines the criteria for matching the identity while verifying an OCI artifact.
 */
model MatchOidcIdentityDefinition {
  /**
   * The regex pattern to match against to verify the OIDC issuer.
   */
  issuer?: string;

  /**
   * The regex pattern to match against to verify the identity subject.
   */
  subject?: string;
}

/**
 * Parameters to authenticate using TLS config for OCI repository.
 */
model TlsConfigDefinition {
  /**
   * Base64-encoded certificate used to authenticate a client with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificate?: string | null;

  /**
   * Base64-encoded private key used to authenticate a client with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  privateKey?: string | null;

  /**
   * Base64-encoded CA certificate used to verify the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  caCertificate?: string | null;
}

/**
 * The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.
 */
model KustomizationDefinition {
  /**
   * Name of the Kustomization, matching the key in the Kustomizations object map.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The path in the source reference to reconcile on the cluster.
   */
  path?: string = "";

  /**
   * Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dependsOn?: string[] | null;

  /**
   * The maximum time to attempt to reconcile the Kustomization on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null = 600;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retryIntervalInSeconds?: int64 | null;

  /**
   * Enable/disable garbage collections of Kubernetes objects created by this Kustomization.
   */
  prune?: boolean = false;

  /**
   * Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.
   */
  force?: boolean = false;

  /**
   * Enable/disable health check for all Kubernetes objects created by this Kustomization.
   */
  wait?: boolean = true;

  /**
   * Used for variable substitution for this Kustomization after kustomize build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  postBuild?: PostBuildDefinition | null;
}

/**
 * The postBuild definitions defining variable substitutions for this Kustomization after kustomize build.
 */
model PostBuildDefinition {
  /**
   * Key/value pairs holding the variables to be substituted in this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  substitute?: Record<string> | null;

  /**
   * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
   */
  @identifiers(#[])
  substituteFrom?: SubstituteFromDefinition[];
}

/**
 * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
 */
model SubstituteFromDefinition {
  /**
   * Define whether it is ConfigMap or Secret that holds the variables to be used in substitution.
   */
  kind?: string;

  /**
   * Name of the ConfigMap/Secret that holds the variables to be used in substitution.
   */
  name?: string;

  /**
   * Set to True to proceed without ConfigMap/Secret, if it is not present.
   */
  optional?: boolean = false;
}

/**
 * Statuses of objects deployed by the user-specified kustomizations from the git repository.
 */
model ObjectStatusDefinition {
  /**
   * Name of the applied object
   */
  name?: string;

  /**
   * Namespace of the applied object
   */
  `namespace`?: string;

  /**
   * Kind of the applied object
   */
  kind?: string;

  /**
   * Compliance state of the applied object showing whether the applied object has come into a ready state on the cluster.
   */
  complianceState?: FluxComplianceState = FluxComplianceState.Unknown;

  /**
   * Object reference to the Kustomization that applied this object
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  appliedBy?: ObjectReferenceDefinition | null;

  /**
   * List of Kubernetes object status conditions present on the cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  statusConditions?: ObjectStatusConditionDefinition[] | null;

  /**
   * Additional properties that are provided from objects of the HelmRelease kind
   */
  helmReleaseProperties?: HelmReleasePropertiesDefinition;
}

/**
 * Object reference to a Kubernetes object on a cluster
 */
model ObjectReferenceDefinition {
  /**
   * Name of the object
   */
  name?: string;

  /**
   * Namespace of the object
   */
  `namespace`?: string;
}

/**
 * Status condition of Kubernetes object
 */
model ObjectStatusConditionDefinition {
  /**
   * Last time this status condition has changed
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTransitionTime?: utcDateTime;

  /**
   * A more verbose description of the object status condition
   */
  message?: string;

  /**
   * Reason for the specified status condition type status
   */
  reason?: string;

  /**
   * Status of the Kubernetes object condition type
   */
  status?: string;

  /**
   * Object status condition type for this object
   */
  type?: string;
}

/**
 * Properties for HelmRelease objects
 */
model HelmReleasePropertiesDefinition {
  /**
   * The revision number of the last released object change
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastRevisionApplied?: int64 | null;

  /**
   * The reference to the HelmChart object used as the source to this HelmRelease
   */
  helmChartRef?: ObjectReferenceDefinition;

  /**
   * Total number of times that the HelmRelease failed to install or upgrade
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  failureCount?: int64 | null;

  /**
   * Number of times that the HelmRelease failed to install
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  installFailureCount?: int64 | null;

  /**
   * Number of times that the HelmRelease failed to upgrade
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  upgradeFailureCount?: int64 | null;
}

/**
 * The Flux Configuration Patch Request object.
 */
model FluxConfigurationPatch {
  /**
   * Updatable properties of an Flux Configuration Patch Request
   */
  properties?: FluxConfigurationPatchProperties;
}

/**
 * Updatable properties of an Flux Configuration Patch Request
 */
model FluxConfigurationPatchProperties {
  /**
   * Source Kind to pull the configuration data from.
   */
  sourceKind?: SourceKindType;

  /**
   * Whether this configuration should suspend its reconciliation of its kustomizations and sources.
   */
  suspend?: boolean;

  /**
   * Parameters to reconcile to the GitRepository source kind type.
   */
  gitRepository?: GitRepositoryPatchDefinition;

  /**
   * Parameters to reconcile to the Bucket source kind type.
   */
  bucket?: BucketPatchDefinition;

  /**
   * Parameters to reconcile to the AzureBlob source kind type.
   */
  azureBlob?: AzureBlobPatchDefinition;

  /**
   * Parameters to reconcile to the OCIRepository source kind type.
   */
  ociRepository?: OCIRepositoryPatchDefinition;

  /**
   * Array of kustomizations used to reconcile the artifact pulled by the source type on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kustomizations?: Record<KustomizationPatchDefinition>;

  /**
   * Key-value pairs of protected configuration settings for the configuration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationProtectedSettings?: Record<string>;
}

/**
 * Parameters to reconcile to the GitRepository source kind type.
 */
model GitRepositoryPatchDefinition {
  /**
   * The URL to sync for the flux configuration git repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * The maximum time to attempt to reconcile the cluster git repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the cluster git repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null;

  /**
   * The source reference for the GitRepository object.
   */
  repositoryRef?: RepositoryRefDefinition;

  /**
   * Base64-encoded known_hosts value containing public SSH keys required to access private git repositories over SSH
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sshKnownHosts?: string | null;

  /**
   * Plaintext HTTPS username used to access private git repositories over HTTPS
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpsUser?: string | null;

  /**
   * Base64-encoded HTTPS certificate authority contents used to access git private git repositories over HTTPS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  httpsCACert?: string | null;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;

  /**
   * Name of the provider used for authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provider?: ProviderType | null;
}

/**
 * Parameters to reconcile to the Bucket source kind type.
 */
model BucketPatchDefinition {
  /**
   * The URL to sync for the flux configuration S3 bucket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * The bucket name to sync from the url endpoint for the flux configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bucketName?: string | null;

  /**
   * Specify whether to use insecure communication when puling data from the S3 bucket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  insecure?: boolean | null;

  /**
   * The maximum time to attempt to reconcile the cluster bucket source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the cluster bucket source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null;

  /**
   * Plaintext access key used to securely access the S3 bucket
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessKey?: string | null;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * Parameters to reconcile to the AzureBlob source kind type.
 */
model AzureBlobPatchDefinition {
  /**
   * The URL to sync for the flux configuration Azure Blob storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: string | null;

  /**
   * The Azure Blob container name to sync from the url endpoint for the flux configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  containerName?: string | null;

  /**
   * The maximum time to attempt to reconcile the cluster Azure Blob source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the cluster Azure Blob source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null;

  /**
   * Parameters to authenticate using Service Principal.
   */
  servicePrincipal?: ServicePrincipalPatchDefinition;

  /**
   * The account key (shared key) to access the storage account
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  accountKey?: string | null;

  /**
   * The Shared Access token to access the storage container
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  sasToken?: string | null;

  /**
   * Parameters to authenticate using a Managed Identity.
   */
  managedIdentity?: ManagedIdentityPatchDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * Parameters to authenticate using Service Principal.
 */
model ServicePrincipalPatchDefinition {
  /**
   * The client Id for authenticating a Service Principal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string | null;

  /**
   * The tenant Id for authenticating a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tenantId?: string | null;

  /**
   * The client secret for authenticating a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientSecret?: string | null;

  /**
   * Base64-encoded certificate used to authenticate a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificate?: string;

  /**
   * The password for the certificate used to authenticate a Service Principal
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificatePassword?: string | null;

  /**
   * Specifies whether to include x5c header in client claims when acquiring a token to enable subject name / issuer based authentication for the Client Certificate
   */
  clientCertificateSendChain?: boolean;
}

/**
 * Parameters to authenticate using a Managed Identity.
 */
model ManagedIdentityPatchDefinition {
  /**
   * The client Id for authenticating a Managed Identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clientId?: string | null;
}

/**
 * Parameters to reconcile to the OCIRepository source kind type.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OCIRepositoryPatchDefinition {
  /**
   * The URL to sync for the flux configuration OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  url?: url | null;

  /**
   * The maximum time to attempt to reconcile the cluster OCI repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the cluster OCI repository source with the remote.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null;

  /**
   * The source reference for the OCIRepository object.
   */
  repositoryRef?: OCIRepositoryRefPatchDefinition;

  /**
   * The layer to be pulled from the OCI artifact.
   */
  layerSelector?: LayerSelectorPatchDefinition;

  /**
   * Verification of the authenticity of an OCI Artifact.
   */
  verify?: VerifyPatchDefinition;

  /**
   * Specify whether to allow connecting to a non-TLS HTTP container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  insecure?: boolean = false;

  /**
   * Specifies whether to use Workload Identity to authenticate with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  useWorkloadIdentity?: boolean = false;

  /**
   * The service account name to authenticate with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceAccountName?: string | null;

  /**
   * Parameters to authenticate using TLS config for OCI repository.
   */
  tlsConfig?: TlsConfigPatchDefinition;

  /**
   * Name of a local secret on the Kubernetes cluster to use as the authentication secret rather than the managed or user-provided configuration secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  localAuthRef?: string | null;
}

/**
 * The source reference for the OCIRepository object.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OCIRepositoryRefPatchDefinition {
  /**
   * The OCI repository image tag name to pull. This defaults to 'latest'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tag?: string | null;

  /**
   * The semver range used to match against OCI repository tags. This takes precedence over tag.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  semver?: string | null;

  /**
   * The image digest to pull from OCI repository, the value should be in the format ‘sha256:’. This takes precedence over semver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  digest?: string | null;
}

/**
 * Parameters to specify which layer to pull from the OCI artifact. By default, the first layer in the artifact is pulled.
 */
model LayerSelectorPatchDefinition {
  /**
   * The first layer matching the specified media type will be used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mediaType?: string | null;

  /**
   * The operation to be performed on the selected layer. The default value is 'extract', but it can be set to 'copy'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  operation?: OperationType | null;
}

/**
 * Parameters to verify the authenticity of an OCI Artifact.
 */
model VerifyPatchDefinition {
  /**
   * Verification provider name.
   */
  provider?: string;

  /**
   * An object containing trusted public keys of trusted authors.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  verificationConfig?: Record<string> | null;

  /**
   * Array defining the criteria for matching the OIDC identity while verifying an OCI artifact.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  matchOidcIdentity?: MatchOidcIdentityPatchDefinition[] | null;
}

/**
 * MatchOIDCIdentity defines the criteria for matching the identity while verifying an OCI artifact.
 */
model MatchOidcIdentityPatchDefinition {
  /**
   * The regex pattern to match against to verify the OIDC issuer.
   */
  issuer?: string;

  /**
   * The regex pattern to match against to verify the identity subject.
   */
  subject?: string;
}

/**
 * Parameters to authenticate using TLS config for OCI repository.
 */
model TlsConfigPatchDefinition {
  /**
   * Base64-encoded certificate used to authenticate a client with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  clientCertificate?: string | null;

  /**
   * Base64-encoded private key used to authenticate a client with the OCI repository.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  privateKey?: string | null;

  /**
   * Base64-encoded CA certificate used to verify the server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  caCertificate?: string | null;
}

/**
 * The Kustomization defining how to reconcile the artifact pulled by the source type on the cluster.
 */
model KustomizationPatchDefinition {
  /**
   * The path in the source reference to reconcile on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  path?: string | null;

  /**
   * Specifies other Kustomizations that this Kustomization depends on. This Kustomization will not reconcile until all dependencies have completed their reconciliation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dependsOn?: string[] | null;

  /**
   * The maximum time to attempt to reconcile the Kustomization on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  timeoutInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  syncIntervalInSeconds?: int64 | null;

  /**
   * The interval at which to re-reconcile the Kustomization on the cluster in the event of failure on reconciliation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  retryIntervalInSeconds?: int64 | null;

  /**
   * Enable/disable garbage collections of Kubernetes objects created by this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  prune?: boolean | null;

  /**
   * Enable/disable re-creating Kubernetes resources on the cluster when patching fails due to an immutable field change.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  force?: boolean | null;

  /**
   * Enable/disable health check for all Kubernetes objects created by this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  wait?: boolean | null;

  /**
   * Used for variable substitution for this Kustomization after kustomize build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  postBuild?: PostBuildPatchDefinition | null;
}

/**
 * The postBuild definitions defining variable substitutions for this Kustomization after kustomize build.
 */
model PostBuildPatchDefinition {
  /**
   * Key/value pairs holding the variables to be substituted in this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  substitute?: Record<string> | null;

  /**
   * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  substituteFrom?: SubstituteFromPatchDefinition[] | null;
}

/**
 * Array of ConfigMaps/Secrets from which the variables are substituted for this Kustomization.
 */
model SubstituteFromPatchDefinition {
  /**
   * Define whether it is ConfigMap or Secret that holds the variables to be used in substitution.
   */
  kind?: string;

  /**
   * Name of the ConfigMap/Secret that holds the variables to be used in substitution.
   */
  name?: string;

  /**
   * Set to True to proceed without ConfigMap/Secret, if it is not present.
   */
  optional?: boolean = false;
}

/**
 * Result of the request to list Flux Configurations.  It contains a list of FluxConfiguration objects and a URL link to get the next set of results.
 */
model FluxConfigurationsList is Azure.Core.Page<FluxConfiguration>;

/**
 * The current status of an async operation.
 */
model OperationStatusResult {
  /**
   * Fully qualified ID for the async operation.
   */
  id?: string;

  /**
   * Name of the async operation.
   */
  name?: string;

  /**
   * Operation status.
   */
  status: string;

  /**
   * Additional information, if available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<string>;

  /**
   * If present, details of the operation error.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}
