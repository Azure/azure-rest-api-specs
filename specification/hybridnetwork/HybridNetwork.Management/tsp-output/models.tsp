import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridNetwork;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  Unknown,
  Succeeded,
  Accepted,
  Deleting,
  Failed,
  Canceled,
  Deleted,
  Converging,
}

/**
 * The configuration group schema state.
 */
enum VersionState {
  Unknown,
  Preview,
  Active,
  Deprecated,
  Validating,
  ValidationFailed,
}

/**
 * Publisher Scope.
 */
enum PublisherScope {
  Unknown,
  Private,
}

/**
 * The resource reference arm id type.
 */
enum IdType {
  Unknown,
  Open,
  Secret,
}

/**
 * The secret type which indicates if secret or not.
 */
enum ConfigurationGroupValueConfigurationType {
  Unknown,
  Secret,
  Open,
}

/**
 * The NFVI type.
 */
enum NfviType {
  Unknown,
  AzureArcKubernetes,
  AzureCore,
  AzureOperatorNexus,
}

/**
 * The secret type which indicates if secret or not.
 */
enum NetworkFunctionConfigurationType {
  Unknown,
  Secret,
  Open,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The http method of the request.
 */
enum HttpMethod {
  Unknown,
  Post,
  Put,
  Get,
  Patch,
  Delete,
}

/**
 * The component resource deployment status.
 */
enum Status {
  Unknown,
  Deployed,
  Uninstalled,
  Superseded,
  Failed,
  Uninstalling,
  `Pending-Install`,
  `Pending-Upgrade`,
  `Pending-Rollback`,
  Downloading,
  Installing,
  Reinstalling,
  Rollingback,
  Upgrading,
}

/**
 * The status of a Pod.
 */
enum PodStatus {
  Unknown,
  Succeeded,
  Failed,
  Running,
  Pending,
  Terminating,
  NotReady,
}

/**
 * The type of pod event.
 */
enum PodEventType {
  Normal,
  Warning,
}

/**
 * The network function type.
 */
enum NetworkFunctionType {
  Unknown,
  VirtualNetworkFunction,
  ContainerizedNetworkFunction,
}

/**
 * The resource element template type.
 */
enum Type {
  Unknown,
  ArmResourceDefinition,
  NetworkFunctionDefinition,
}

/**
 * The artifact store type.
 */
enum ArtifactStoreType {
  Unknown,
  AzureContainerRegistry,
  AzureStorageAccount,
}

/**
 * The replication strategy.
 */
enum ArtifactReplicationStrategy {
  Unknown,
  SingleReplication,
}

/**
 * The artifact manifest state.
 */
enum ArtifactManifestState {
  Unknown,
  Uploading,
  Uploaded,
  Validating,
  ValidationFailed,
  Succeeded,
}

/**
 * The artifact type.
 */
enum ArtifactType {
  Unknown,
  OCIArtifact,
  VhdImageFile,
  ArmTemplate,
  ImageFile,
}

/**
 * The credential type.
 */
enum CredentialType {
  Unknown,
  AzureContainerRegistryScopedToken,
  AzureStorageAccountToken,
}

/**
 * The artifact state.
 */
enum ArtifactState {
  Unknown,
  Preview,
  Active,
  Deprecated,
}

/**
 * Name of this Sku
 */
enum SkuName {
  Basic,
  Standard,
}

/**
 * The application enablement.
 */
enum ApplicationEnablement {
  Unknown,
  Enabled,
  Disabled,
}

/**
 * The network function type.
 */
enum ContainerizedNetworkFunctionNfviType {
  Unknown,
  AzureArcKubernetes,
}

/**
 * The network function type.
 */
enum VirtualNetworkFunctionNfviType {
  Unknown,
  AzureCore,
  AzureOperatorNexus,
}

/**
 * The artifact type.
 */
enum AzureArcKubernetesArtifactType {
  Unknown,
  HelmPackage,
}

/**
 * The artifact type.
 */
enum AzureCoreArtifactType {
  Unknown,
  VhdImageFile,
  ArmTemplate,
}

/**
 * The artifact type.
 */
enum AzureOperatorNexusArtifactType {
  Unknown,
  ImageFile,
  ArmTemplate,
}

/**
 * The template type.
 */
enum TemplateType {
  Unknown,
  ArmTemplate,
}

/**
 * The configuration generation type.
 */
enum ConfigurationGenerationType {
  Unknown,
  HandlebarTemplate,
}

/**
 * Configuration group schema properties.
 */
model ConfigurationGroupSchemaPropertiesFormat {
  /**
   * The provisioning state of the Configuration group schema resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The configuration group schema version state.
   */
  @visibility("read")
  versionState?: VersionState;

  /**
   * Description of what schema can contain.
   */
  description?: string;

  /**
   * Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.
   */
  schemaDefinition?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Publisher configuration group schema update request definition.
 */
model ConfigurationGroupSchemaVersionUpdateState {
  /**
   * The configuration group schema state.
   */
  @visibility("read", "create")
  versionState?: VersionState;
}

/**
 * Hybrid configuration group value properties.
 */
@discriminator("configurationType")
model ConfigurationGroupValuePropertiesFormat {
  /**
   * The provisioning state of the site resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The publisher name for the configuration group schema.
   */
  @visibility("read")
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  @visibility("read")
  publisherScope?: PublisherScope;

  /**
   * The configuration group schema name.
   */
  @visibility("read")
  configurationGroupSchemaName?: string;

  /**
   * The location of the configuration group schema offering.
   */
  @visibility("read")
  configurationGroupSchemaOfferingLocation?: string;

  /**
   * The configuration group schema resource reference.
   */
  configurationGroupSchemaResourceReference?: DeploymentResourceIdReference;
}

/**
 * The azure resource reference which is used for deployment.
 */
@discriminator("idType")
model DeploymentResourceIdReference {}

/**
 * Network function properties.
 */
@discriminator("configurationType")
model NetworkFunctionPropertiesFormat {
  /**
   * The provisioning state of the network function resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The publisher name for the network function.
   */
  @visibility("read")
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  @visibility("read")
  publisherScope?: PublisherScope;

  /**
   * The network function definition group name for the network function.
   */
  @visibility("read")
  networkFunctionDefinitionGroupName?: string;

  /**
   * The network function definition version for the network function.
   */
  @visibility("read")
  networkFunctionDefinitionVersion?: string;

  /**
   * The location of the network function definition offering.
   */
  @visibility("read")
  networkFunctionDefinitionOfferingLocation?: string;

  /**
   * The network function definition version resource reference.
   */
  networkFunctionDefinitionVersionResourceReference?: DeploymentResourceIdReference;

  /**
   * The nfvi type for the network function.
   */
  nfviType?: NfviType;

  /**
   * The nfviId for the network function.
   */
  nfviId?: string;

  /**
   * Indicates if software updates are allowed during deployment.
   */
  allowSoftwareUpdate?: boolean;

  /**
   * The role configuration override values from the user.
   */
  roleOverrideValues?: string[];
}

/**
 * Payload for execute request post call.
 */
model ExecuteRequestParameters {
  /**
   * The endpoint of service to call.
   */
  serviceEndpoint: string;

  /**
   * The request metadata.
   */
  requestMetadata: RequestMetadata;
}

/**
 * Request metadata of execute request post call payload.
 */
model RequestMetadata {
  /**
   * The relative path of the request.
   */
  relativePath: string;

  /**
   * The http method of the request.
   */
  httpMethod: HttpMethod;

  /**
   * The serialized body of the request.
   */
  serializedBody: string;

  /**
   * The api version of the request.
   */
  apiVersion?: string;
}

/**
 * The component properties of the network function.
 */
model ComponentProperties {
  /**
   * The provisioning state of the component resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The JSON-serialized deployment profile of the component resource.
   */
  @visibility("read")
  deploymentProfile?: string;

  /**
   * The deployment status of the component resource.
   */
  @visibility("read")
  deploymentStatus?: DeploymentStatusProperties;
}

/**
 * The deployment status properties of the network function component.
 */
model DeploymentStatusProperties {
  /**
   * The status of the component resource.
   */
  status?: Status;

  /**
   * The resource related to the component resource.
   */
  resources?: Resources;

  /**
   * The next expected update of deployment status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExpectedUpdateAt?: utcDateTime;
}

/**
 * The resources of the network function component.
 */
model Resources {
  /**
   * Deployments that are related to component resource.
   */
  deployments?: Deployment[];

  /**
   * Pods related to component resource.
   */
  pods?: Pod[];

  /**
   * Replica sets related to component resource.
   */
  replicaSets?: ReplicaSet[];

  /**
   * Stateful sets related to component resource.
   */
  statefulSets?: StatefulSet[];

  /**
   * Daemonsets related to component resource.
   */
  daemonSets?: DaemonSet[];
}

/**
 * Helm Deployment status properties.
 */
model Deployment {
  /**
   * The name of the deployment.
   */
  name?: string;

  /**
   * The namespace of the deployment.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Number of upto date pods.
   */
  upToDate?: int32;

  /**
   * Number of available pods.
   */
  available?: int32;

  /**
   * Creation Time of deployment.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm Pod status properties.
 */
model Pod {
  /**
   * The name of the Pod.
   */
  name?: string;

  /**
   * The namespace of the Pod.
   */
  `namespace`?: string;

  /**
   * Desired number of containers
   */
  desired?: int32;

  /**
   * Number of ready containers.
   */
  ready?: int32;

  /**
   * The status of a pod.
   */
  status?: PodStatus;

  /**
   * Creation Time of Pod.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last 5 Pod events.
   */
  events?: PodEvent[];
}

/**
 * Pod Event  properties.
 */
model PodEvent {
  /**
   * The type of pod event.
   */
  type?: PodEventType;

  /**
   * Event reason.
   */
  reason?: string;

  /**
   * Event message.
   */
  message?: string;

  /**
   * Event Last seen.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeenTime?: utcDateTime;
}

/**
 * Helm ReplicaSet status properties.
 */
model ReplicaSet {
  /**
   * The name of the replicaSet.
   */
  name?: string;

  /**
   * The namespace of the replicaSet.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Number of current pods.
   */
  current?: int32;

  /**
   * Creation Time of replicaSet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm StatefulSet status properties.
 */
model StatefulSet {
  /**
   * The name of the statefulset.
   */
  name?: string;

  /**
   * The namespace of the statefulset.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Number of ready pods.
   */
  ready?: int32;

  /**
   * Creation Time of statefulset.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Helm DaemonSet status properties.
 */
model DaemonSet {
  /**
   * The name of the daemonSet.
   */
  name?: string;

  /**
   * The namespace of the daemonSet.
   */
  `namespace`?: string;

  /**
   * Desired number of pods
   */
  desired?: int32;

  /**
   * Current number of pods
   */
  current?: int32;

  /**
   * Number of Ready pods
   */
  ready?: int32;

  /**
   * Number of  upto date pods
   */
  upToDate?: int32;

  /**
   * Number of available pods.
   */
  available?: int32;

  /**
   * Creation Time of daemonSet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

/**
 * Network function definition group properties.
 */
model NetworkFunctionDefinitionGroupPropertiesFormat {
  /**
   * The provisioning state of the network function definition groups resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The network function definition group description.
   */
  description?: string;
}

/**
 * Network function definition version properties.
 */
@discriminator("networkFunctionType")
model NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * The provisioning state of the network function definition version resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The network function definition version state.
   */
  @visibility("read")
  versionState?: VersionState;

  /**
   * The network function definition version description.
   */
  description?: string;

  /**
   * The deployment parameters of the network function definition version.
   */
  deployParameters?: string;
}

/**
 * Publisher network function definition version update request definition.
 */
model NetworkFunctionDefinitionVersionUpdateState {
  /**
   * The network function definition version state. Only the 'Active' and 'Deprecated' states are allowed for updates. Other states are used for internal state transitioning.
   */
  @visibility("read", "create")
  versionState?: VersionState;
}

/**
 * network service design group properties.
 */
model NetworkServiceDesignGroupPropertiesFormat {
  /**
   * The provisioning state of the network service design groups resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The network service design group description.
   */
  description?: string;
}

/**
 * network service design version properties.
 */
model NetworkServiceDesignVersionPropertiesFormat {
  /**
   * The provisioning state of the network service design version resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The network service design version state.
   */
  @visibility("read")
  versionState?: VersionState;

  /**
   * The network service design version description.
   */
  description?: string;

  /**
   * The configuration schemas to used to define the values.
   */
  configurationGroupSchemaReferences?: Record<ReferencedResource>;

  /**
   * The nfvis from the site.
   */
  nfvisFromSite?: Record<NfviDetails>;

  /**
   * List of resource element template
   */
  resourceElementTemplates?: ResourceElementTemplate[];
}

/**
 * Reference to another resource.
 */
model ReferencedResource {
  /**
   * Resource ID.
   */
  id?: string;
}

/**
 * The nfvi details.
 */
model NfviDetails {
  /**
   * The nfvi name.
   */
  name?: string;

  /**
   * The nfvi type.
   */
  type?: string;
}

/**
 * The resource element template object.
 */
@discriminator("type")
model ResourceElementTemplate {
  /**
   * Name of the resource element template.
   */
  name?: string;

  /**
   * The depends on profile.
   */
  dependsOnProfile?: DependsOnProfile;
}

/**
 * Depends on profile definition.
 */
model DependsOnProfile {
  /**
   * Application installation operation dependency.
   */
  installDependsOn?: string[];

  /**
   * Application deletion operation dependency.
   */
  uninstallDependsOn?: string[];

  /**
   * Application update operation dependency.
   */
  updateDependsOn?: string[];
}

/**
 * Publisher network service design version update request definition.
 */
model NetworkServiceDesignVersionUpdateState {
  /**
   * The network service design version state.
   */
  @visibility("read", "create")
  versionState?: VersionState;
}

/**
 * publisher properties.
 */
model PublisherPropertiesFormat {
  /**
   * The provisioning state of the publisher resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The publisher scope.
   */
  @visibility("read", "create")
  scope?: PublisherScope;
}

/**
 * Artifact store properties.
 */
model ArtifactStorePropertiesFormat {
  /**
   * The provisioning state of the application groups resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The artifact store type.
   */
  @visibility("read", "create")
  storeType?: ArtifactStoreType;

  /**
   * The replication strategy.
   */
  replicationStrategy?: ArtifactReplicationStrategy;

  managedResourceGroupConfiguration?: ArtifactStorePropertiesFormatManagedResourceGroupConfiguration;

  /**
   * The created storage resource id
   */
  @visibility("read")
  storageResourceId?: string;
}

model ArtifactStorePropertiesFormatManagedResourceGroupConfiguration {
  /**
   * The managed resource group name.
   */
  @visibility("read", "create")
  name?: string;

  /**
   * The managed resource group location.
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * Artifact manifest properties.
 */
model ArtifactManifestPropertiesFormat {
  /**
   * The provisioning state of the ArtifactManifest resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The artifact manifest state.
   */
  @visibility("read")
  artifactManifestState?: ArtifactManifestState;

  /**
   * The artifacts list.
   */
  artifacts?: ManifestArtifactFormat[];
}

/**
 * Manifest artifact properties.
 */
model ManifestArtifactFormat {
  /**
   * The artifact name
   */
  @visibility("read", "create")
  artifactName?: string;

  /**
   * The artifact type.
   */
  @visibility("read", "create")
  artifactType?: ArtifactType;

  /**
   * The artifact version.
   */
  @visibility("read", "create")
  artifactVersion?: string;
}

/**
 * The artifact manifest credential definition.
 */
@discriminator("credentialType")
model ArtifactAccessCredential {}

/**
 * The artifact manifest updating request payload. Only the 'Uploaded' state is allowed for updates. Other states are used for internal state transitioning.
 */
model ArtifactManifestUpdateState {
  /**
   * The artifact manifest state.
   */
  @visibility("read", "create")
  artifactManifestState?: ArtifactManifestState;
}

/**
 * The proxy artifact list result.
 */
model ProxyArtifactOverviewListResult
  is Azure.Core.Page<ProxyArtifactListOverview>;

/**
 * The proxy artifact overview.
 */
model ProxyArtifactListOverview extends ProxyResource {}

/**
 * The proxy artifact list result.
 */
model ProxyArtifactVersionsOverviewListResult
  is Azure.Core.Page<ProxyArtifactVersionsListOverview>;

/**
 * The proxy artifact overview.
 */
model ProxyArtifactVersionsListOverview extends ProxyResource {
  /**
   * Proxy Artifact overview properties.
   */
  @visibility("read")
  properties?: ProxyArtifactOverviewPropertiesValue;
}

model ProxyArtifactOverviewPropertiesValue {
  /**
   * The artifact type.
   */
  artifactType?: ArtifactType;

  /**
   * The artifact version.
   */
  artifactVersion?: string;

  /**
   * The artifact state
   */
  artifactState?: ArtifactState;
}

/**
 * The artifact updating request payload.
 */
model ArtifactChangeState {
  /**
   * Artifact update state properties.
   */
  properties?: ArtifactChangeStateProperties;
}

/**
 * The artifact update state properties.
 */
model ArtifactChangeStateProperties {
  /**
   * The artifact state
   */
  artifactState?: ArtifactState;
}

/**
 * Site properties.
 */
model SitePropertiesFormat {
  /**
   * The provisioning state of the site resource. **TODO**: Confirm if this is needed.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * List of NFVIs
   */
  nfvis?: NFVIs[];

  /**
   * The list of site network services on the site.
   */
  @visibility("read")
  siteNetworkServiceReferences?: ReferencedResource[];
}

/**
 * The NFVI object.
 */
@discriminator("nfviType")
model NFVIs {
  /**
   * Name of the nfvi.
   */
  name?: string;
}

/**
 * Site network service properties.
 */
model SiteNetworkServicePropertiesFormat {
  /**
   * The provisioning state of the site network service resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Managed resource group configuration.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The site details
   */
  siteReference?: ReferencedResource;

  /**
   * The publisher name for the site network service.
   */
  @visibility("read")
  publisherName?: string;

  /**
   * The scope of the publisher.
   */
  @visibility("read")
  publisherScope?: PublisherScope;

  /**
   * The network service design group name for the site network service.
   */
  @visibility("read")
  networkServiceDesignGroupName?: string;

  /**
   * The network service design version for the site network service.
   */
  @visibility("read")
  networkServiceDesignVersionName?: string;

  /**
   * The location of the network service design offering.
   */
  @visibility("read")
  networkServiceDesignVersionOfferingLocation?: string;

  /**
   * The network service design version resource reference.
   */
  networkServiceDesignVersionResourceReference?: DeploymentResourceIdReference;

  /**
   * The goal state of the site network service resource. This has references to the configuration group value objects that describe the desired state of the site network service.
   */
  desiredStateConfigurationGroupValueReferences?: Record<ReferencedResource>;

  /**
   * The network service design version for the site network service.
   */
  @visibility("read")
  lastStateNetworkServiceDesignVersionName?: string;

  /**
   * The last state of the site network service resource.
   */
  @visibility("read")
  lastStateConfigurationGroupValueReferences?: Record<ReferencedResource>;
}

/**
 * Managed resource group configuration.
 */
model ManagedResourceGroupConfiguration {
  /**
   * Managed resource group name.
   */
  name?: string;

  /**
   * Managed resource group location.
   */
  location?: string;
}

/**
 * Sku, to be associated with a SiteNetworkService.
 */
model Sku {
  /**
   * Name of this Sku
   */
  name: SkuName;

  /**
   * The SKU tier based on the SKU name.
   */
  @visibility("read")
  tier?: SkuTier;
}

/**
 * Reference to an Azure ARC custom location resource.
 */
model CustomLocationResourceId {
  /**
   * Azure ARC custom location resource ID.
   */
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][xX][tT][eE][nN][dD][eE][dD][lL][oO][cC][aA][tT][iI][oO][nN]/[cC][uU][sS][tT][oO][mM][lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+$")
  id?: string;
}

/**
 * Network function application definition.
 */
model NetworkFunctionApplication {
  /**
   * The name of the network function application.
   */
  name?: string;

  /**
   * Depends on profile definition.
   */
  dependsOnProfile?: DependsOnProfile;
}

/**
 * Artifact profile properties.
 */
model ArtifactProfile {
  /**
   * The reference to artifact store.
   */
  artifactStore?: ReferencedResource;
}

/**
 * Mapping rule profile properties.
 */
model MappingRuleProfile {
  /**
   * The application enablement.
   */
  applicationEnablement?: ApplicationEnablement;
}

/**
 * The azure container registry scoped token credential definition.
 */
model AzureContainerRegistryScopedTokenCredential
  extends ArtifactAccessCredential {
  /**
   * The username of the credential.
   */
  username?: string;

  /**
   * The credential value.
   */
  acrToken?: string;

  /**
   * The Acr server url
   */
  acrServerUrl?: string;

  /**
   * The repositories that could be accessed using the current credential.
   */
  repositories?: string[];

  /**
   * The UTC time when credential will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The credential type.
   */
  credentialType: "AzureContainerRegistryScopedToken";
}

/**
 * The azure storage account credential definition.
 */
model AzureStorageAccountCredential extends ArtifactAccessCredential {
  /**
   * The storage account Id
   */
  storageAccountId?: string;

  /**
   * The containers that could be accessed using the current credential.
   */
  containerCredentials?: AzureStorageAccountContainerCredential[];

  /**
   * The UTC time when credential will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The credential type.
   */
  credentialType: "AzureStorageAccountToken";
}

/**
 * The azure storage account container credential definition.
 */
model AzureStorageAccountContainerCredential {
  /**
   * The storage account container name
   */
  containerName?: string;

  /**
   * The storage account container sas uri
   */
  containerSasUri?: string;
}

/**
 * Secret deployment resource id reference.
 */
model SecretDeploymentResourceReference extends DeploymentResourceIdReference {
  /**
   * Resource ID.
   */
  @visibility("create", "update")
  id?: string;

  /**
   * The resource reference arm id type.
   */
  idType: "Secret";
}

/**
 * Non secret deployment resource id reference.
 */
model OpenDeploymentResourceReference extends DeploymentResourceIdReference {
  /**
   * Resource ID.
   */
  id?: string;

  /**
   * The resource reference arm id type.
   */
  idType: "Open";
}

/**
 * The ConfigurationValue with secrets.
 */
model ConfigurationValueWithSecrets
  extends ConfigurationGroupValuePropertiesFormat {
  /**
   * Name and value pairs that define the configuration value secrets. It can be a well formed escaped JSON string.
   */
  @visibility("create", "update")
  secretConfigurationValue?: string;

  /**
   * The value which indicates if configuration values are secrets
   */
  configurationType: "Secret";
}

/**
 * The ConfigurationValue with no secrets.
 */
model ConfigurationValueWithoutSecrets
  extends ConfigurationGroupValuePropertiesFormat {
  /**
   * Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.
   */
  configurationValue?: string;

  /**
   * The value which indicates if configuration values are secrets
   */
  configurationType: "Open";
}

/**
 * NetworkFunction with secrets.
 */
model NetworkFunctionValueWithSecrets extends NetworkFunctionPropertiesFormat {
  /**
   * The JSON-serialized secret deployment values from the user. This contains secrets like passwords,keys etc
   */
  @visibility("create", "update")
  secretDeploymentValues?: string;

  /**
   * The value which indicates if NF  values are secrets
   */
  configurationType: "Secret";
}

/**
 * NetworkFunction with no secrets.
 */
model NetworkFunctionValueWithoutSecrets
  extends NetworkFunctionPropertiesFormat {
  /**
   * The JSON-serialized deployment values from the user.
   */
  deploymentValues?: string;

  /**
   * The value which indicates if NF  values are secrets
   */
  configurationType: "Open";
}

/**
 * Containerized network function network function definition version properties.
 */
model ContainerizedNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * Containerized network function template.
   */
  networkFunctionTemplate?: ContainerizedNetworkFunctionTemplate;

  /**
   * The network function type.
   */
  networkFunctionType: "ContainerizedNetworkFunction";
}

/**
 * Containerized network function template.
 */
@discriminator("nfviType")
model ContainerizedNetworkFunctionTemplate {}

/**
 * Virtual network function network function definition version properties.
 */
model VirtualNetworkFunctionNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  /**
   * Virtual network function template.
   */
  networkFunctionTemplate?: VirtualNetworkFunctionTemplate;

  /**
   * The network function type.
   */
  networkFunctionType: "VirtualNetworkFunction";
}

/**
 * Virtual network function template.
 */
@discriminator("nfviType")
model VirtualNetworkFunctionTemplate {}

/**
 * Azure Arc kubernetes network function template.
 */
model AzureArcKubernetesNetworkFunctionTemplate
  extends ContainerizedNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  networkFunctionApplications?: AzureArcKubernetesNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureArcKubernetes";
}

/**
 * Azure arc kubernetes network function application definition.
 */
@discriminator("artifactType")
model AzureArcKubernetesNetworkFunctionApplication
  extends NetworkFunctionApplication {}

/**
 * Azure arc kubernetes helm application configurations.
 */
model AzureArcKubernetesHelmApplication
  extends AzureArcKubernetesNetworkFunctionApplication {
  /**
   * Azure arc kubernetes artifact profile.
   */
  artifactProfile?: AzureArcKubernetesArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureArcKubernetesDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "HelmPackage";
}

/**
 * Azure arc kubernetes artifact profile properties.
 */
model AzureArcKubernetesArtifactProfile extends ArtifactProfile {
  /**
   * Helm artifact profile.
   */
  helmArtifactProfile?: HelmArtifactProfile;
}

/**
 * Helm artifact profile.
 */
model HelmArtifactProfile {
  /**
   * Helm package name.
   */
  helmPackageName?: string;

  /**
   * Helm package version range.
   */
  helmPackageVersionRange?: string;

  /**
   * The registry values path list.
   */
  registryValuesPaths?: string[];

  /**
   * The image pull secrets values path list.
   */
  imagePullSecretsValuesPaths?: string[];
}

/**
 * Azure arc kubernetes deploy mapping rule profile.
 */
model AzureArcKubernetesDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The helm mapping rule profile.
   */
  helmMappingRuleProfile?: HelmMappingRuleProfile;
}

/**
 * Helm mapping rule profile
 */
model HelmMappingRuleProfile {
  /**
   * Helm release namespace.
   */
  releaseNamespace?: string;

  /**
   * Helm release name.
   */
  releaseName?: string;

  /**
   * Helm package version.
   */
  helmPackageVersion?: string;

  /**
   * Helm release values.
   */
  @visibility("read", "create")
  values?: string;

  /**
   * The helm deployment options
   */
  options?: HelmMappingRuleProfileOptions;
}

/**
 * The helm deployment options
 */
model HelmMappingRuleProfileOptions {
  /**
   * The helm deployment install options
   */
  installOptions?: HelmInstallOptions;

  /**
   * The helm deployment upgrade options
   */
  upgradeOptions?: HelmUpgradeOptions;
}

/**
 * The helm deployment install options
 */
model HelmInstallOptions {
  /**
   * The helm deployment atomic options
   */
  atomic?: string;

  /**
   * The helm deployment wait options
   */
  wait?: string;

  /**
   * The helm deployment timeout options
   */
  timeout?: string;
}

/**
 * The helm deployment install options
 */
model HelmUpgradeOptions {
  /**
   * The helm deployment atomic options
   */
  atomic?: string;

  /**
   * The helm deployment wait options
   */
  wait?: string;

  /**
   * The helm deployment timeout options
   */
  timeout?: string;
}

/**
 * Azure virtual network function template.
 */
model AzureCoreNetworkFunctionTemplate extends VirtualNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  networkFunctionApplications?: AzureCoreNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureCore";
}

/**
 * Azure virtual network function application definition.
 */
@discriminator("artifactType")
model AzureCoreNetworkFunctionApplication extends NetworkFunctionApplication {}

/**
 * Azure Operator Distributed Services network function template.
 */
model AzureOperatorNexusNetworkFunctionTemplate
  extends VirtualNetworkFunctionTemplate {
  /**
   * Network function applications.
   */
  networkFunctionApplications?: AzureOperatorNexusNetworkFunctionApplication[];

  /**
   * The network function type.
   */
  nfviType: "AzureOperatorNexus";
}

/**
 * Azure Operator Distributed Services network function application definition.
 */
@discriminator("artifactType")
model AzureOperatorNexusNetworkFunctionApplication
  extends NetworkFunctionApplication {}

/**
 * Azure core network function vhd application definition.
 */
model AzureCoreNetworkFunctionVhdApplication
  extends AzureCoreNetworkFunctionApplication {
  /**
   * Azure vhd image artifact profile.
   */
  artifactProfile?: AzureCoreVhdImageArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureCoreVhdImageDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "VhdImageFile";
}

/**
 * Azure vhd artifact profile properties.
 */
model AzureCoreVhdImageArtifactProfile extends ArtifactProfile {
  /**
   * Vhd artifact profile.
   */
  vhdArtifactProfile?: VhdImageArtifactProfile;
}

/**
 * Vhd artifact profile.
 */
model VhdImageArtifactProfile {
  /**
   * Vhd name.
   */
  vhdName?: string;

  /**
   * Vhd version.
   */
  vhdVersion?: string;
}

/**
 * Azure vhd deploy mapping rule profile.
 */
model AzureCoreVhdImageDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The vhd mapping rule profile.
   */
  vhdImageMappingRuleProfile?: VhdImageMappingRuleProfile;
}

/**
 * Vhd mapping rule profile
 */
model VhdImageMappingRuleProfile {
  /**
   * List of values.
   */
  userConfiguration?: string;
}

/**
 * Azure core network function Template application definition.
 */
model AzureCoreNetworkFunctionArmTemplateApplication
  extends AzureCoreNetworkFunctionApplication {
  /**
   * Azure template artifact profile.
   */
  artifactProfile?: AzureCoreArmTemplateArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureCoreArmTemplateDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ArmTemplate";
}

/**
 * Azure template artifact profile properties.
 */
model AzureCoreArmTemplateArtifactProfile extends ArtifactProfile {
  /**
   * Template artifact profile.
   */
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

/**
 * Template artifact profile.
 */
model ArmTemplateArtifactProfile {
  /**
   * Template name.
   */
  templateName?: string;

  /**
   * Template version.
   */
  templateVersion?: string;
}

/**
 * Azure template deploy mapping rule profile.
 */
model AzureCoreArmTemplateDeployMappingRuleProfile extends MappingRuleProfile {
  /**
   * The template mapping rule profile.
   */
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

/**
 * Template mapping rule profile
 */
model ArmTemplateMappingRuleProfile {
  /**
   * List of template parameters.
   */
  templateParameters?: string;
}

/**
 * Azure Operator Distributed Services network function image application definition.
 */
model AzureOperatorNexusNetworkFunctionImageApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  /**
   * Azure Operator Distributed Services image artifact profile.
   */
  artifactProfile?: AzureOperatorNexusImageArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureOperatorNexusImageDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ImageFile";
}

/**
 * Azure Operator Distributed Services image artifact profile properties.
 */
model AzureOperatorNexusImageArtifactProfile extends ArtifactProfile {
  /**
   * Image artifact profile.
   */
  imageArtifactProfile?: ImageArtifactProfile;
}

/**
 * Image artifact profile.
 */
model ImageArtifactProfile {
  /**
   * Image name.
   */
  imageName?: string;

  /**
   * Image version.
   */
  imageVersion?: string;
}

/**
 * Azure Operator Distributed Services image deploy mapping rule profile.
 */
model AzureOperatorNexusImageDeployMappingRuleProfile
  extends MappingRuleProfile {
  /**
   * The vhd mapping rule profile.
   */
  imageMappingRuleProfile?: ImageMappingRuleProfile;
}

/**
 * Image mapping rule profile
 */
model ImageMappingRuleProfile {
  /**
   * List of values.
   */
  userConfiguration?: string;
}

/**
 * Azure Operator Distributed Services network function Template application definition.
 */
model AzureOperatorNexusNetworkFunctionArmTemplateApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  /**
   * Azure Operator Distributed Services Template artifact profile.
   */
  artifactProfile?: AzureOperatorNexusArmTemplateArtifactProfile;

  /**
   * Deploy mapping rule profile.
   */
  deployParametersMappingRuleProfile?: AzureOperatorNexusArmTemplateDeployMappingRuleProfile;

  /**
   * The artifact type.
   */
  artifactType: "ArmTemplate";
}

/**
 * Azure Operator Distributed Services vhd artifact profile properties.
 */
model AzureOperatorNexusArmTemplateArtifactProfile extends ArtifactProfile {
  /**
   * Template artifact profile.
   */
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

/**
 * Azure Operator Distributed Services template deploy mapping rule profile.
 */
model AzureOperatorNexusArmTemplateDeployMappingRuleProfile
  extends MappingRuleProfile {
  /**
   * The template mapping rule profile.
   */
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

/**
 * The arm resource definition resource element template details.
 */
model ArmResourceDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  /**
   * The resource element template type.
   */
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  /**
   * The resource element template type.
   */
  type: "ArmResourceDefinition";
}

/**
 * The arm template RE.
 */
model ArmResourceDefinitionResourceElementTemplate {
  /**
   * The template type.
   */
  templateType?: TemplateType;

  /**
   * Name and value pairs that define the parameter values. It can be  a well formed escaped JSON string.
   */
  parameterValues?: string;

  /**
   * Artifact profile properties.
   */
  artifactProfile?: NSDArtifactProfile;
}

/**
 * Artifact profile properties.
 */
model NSDArtifactProfile {
  /**
   * The artifact store resource id
   */
  artifactStoreReference?: ReferencedResource;

  /**
   * Artifact name.
   */
  artifactName?: string;

  /**
   * Artifact version.
   */
  artifactVersion?: string;
}

/**
 * The network function definition resource element template details.
 */
model NetworkFunctionDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  /**
   * The resource element template type.
   */
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  /**
   * The resource element template type.
   */
  type: "NetworkFunctionDefinition";
}

/**
 * The proxy artifact overview.
 */
model ProxyArtifactOverview extends ProxyResource {
  /**
   * Proxy Artifact properties overview.
   */
  @visibility("read")
  properties?: ProxyArtifactOverviewPropertiesFormat;
}

/**
 * Proxy Artifact overview properties.
 */
model ProxyArtifactOverviewPropertiesFormat {
  /**
   * The proxy artifact overview properties.
   */
  artifactVersions?: ProxyArtifactOverviewPropertiesValue[];
}

/**
 * The Azure Core NFVI detail.
 */
model AzureCoreNfviDetails extends NFVIs {
  /**
   * Location of the Azure core.
   */
  location?: string;

  /**
   * The NFVI type.
   */
  nfviType: "AzureCore";
}

/**
 * The AzureArcK8sCluster NFVI detail.
 */
model AzureArcK8SClusterNfviDetails extends NFVIs {
  /**
   * The reference to the custom location.
   */
  customLocationReference?: ReferencedResource;

  /**
   * The NFVI type.
   */
  nfviType: "AzureArcKubernetes";
}

/**
 * The AzureOperatorNexusCluster NFVI detail.
 */
model AzureOperatorNexusClusterNfviDetails extends NFVIs {
  /**
   * The reference to the custom location.
   */
  customLocationReference?: ReferencedResource;

  /**
   * The NFVI type.
   */
  nfviType: "AzureOperatorNexus";
}
