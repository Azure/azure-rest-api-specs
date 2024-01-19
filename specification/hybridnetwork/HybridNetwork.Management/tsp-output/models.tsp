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

@doc("The current provisioning state.")
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

@doc("The configuration group schema state.")
enum VersionState {
  Unknown,
  Preview,
  Active,
  Deprecated,
  Validating,
  ValidationFailed,
}

@doc("Publisher Scope.")
enum PublisherScope {
  Unknown,
  Private,
}

@doc("The resource reference arm id type.")
enum IdType {
  Unknown,
  Open,
  Secret,
}

@doc("The secret type which indicates if secret or not.")
enum ConfigurationGroupValueConfigurationType {
  Unknown,
  Secret,
  Open,
}

@doc("The NFVI type.")
enum NfviType {
  Unknown,
  AzureArcKubernetes,
  AzureCore,
  AzureOperatorNexus,
}

@doc("The secret type which indicates if secret or not.")
enum NetworkFunctionConfigurationType {
  Unknown,
  Secret,
  Open,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("The http method of the request.")
enum HttpMethod {
  Unknown,
  Post,
  Put,
  Get,
  Patch,
  Delete,
}

@doc("The component resource deployment status.")
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

@doc("The status of a Pod.")
enum PodStatus {
  Unknown,
  Succeeded,
  Failed,
  Running,
  Pending,
  Terminating,
  NotReady,
}

@doc("The type of pod event.")
enum PodEventType {
  Normal,
  Warning,
}

@doc("The network function type.")
enum NetworkFunctionType {
  Unknown,
  VirtualNetworkFunction,
  ContainerizedNetworkFunction,
}

@doc("The resource element template type.")
enum Type {
  Unknown,
  ArmResourceDefinition,
  NetworkFunctionDefinition,
}

@doc("The artifact store type.")
enum ArtifactStoreType {
  Unknown,
  AzureContainerRegistry,
  AzureStorageAccount,
}

@doc("The replication strategy.")
enum ArtifactReplicationStrategy {
  Unknown,
  SingleReplication,
}

@doc("The artifact manifest state.")
enum ArtifactManifestState {
  Unknown,
  Uploading,
  Uploaded,
  Validating,
  ValidationFailed,
  Succeeded,
}

@doc("The artifact type.")
enum ArtifactType {
  Unknown,
  OCIArtifact,
  VhdImageFile,
  ArmTemplate,
  ImageFile,
}

@doc("The credential type.")
enum CredentialType {
  Unknown,
  AzureContainerRegistryScopedToken,
  AzureStorageAccountToken,
}

@doc("The artifact state.")
enum ArtifactState {
  Unknown,
  Preview,
  Active,
  Deprecated,
}

@doc("Name of this Sku")
enum SkuName {
  Basic,
  Standard,
}

@doc("The application enablement.")
enum ApplicationEnablement {
  Unknown,
  Enabled,
  Disabled,
}

@doc("The network function type.")
enum ContainerizedNetworkFunctionNfviType {
  Unknown,
  AzureArcKubernetes,
}

@doc("The network function type.")
enum VirtualNetworkFunctionNfviType {
  Unknown,
  AzureCore,
  AzureOperatorNexus,
}

@doc("The artifact type.")
enum AzureArcKubernetesArtifactType {
  Unknown,
  HelmPackage,
}

@doc("The artifact type.")
enum AzureCoreArtifactType {
  Unknown,
  VhdImageFile,
  ArmTemplate,
}

@doc("The artifact type.")
enum AzureOperatorNexusArtifactType {
  Unknown,
  ImageFile,
  ArmTemplate,
}

@doc("The template type.")
enum TemplateType {
  Unknown,
  ArmTemplate,
}

@doc("The configuration generation type.")
enum ConfigurationGenerationType {
  Unknown,
  HandlebarTemplate,
}

@doc("Configuration group schema properties.")
model ConfigurationGroupSchemaPropertiesFormat {
  @doc("The provisioning state of the Configuration group schema resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The configuration group schema version state.")
  @visibility("read")
  versionState?: VersionState;

  @doc("Description of what schema can contain.")
  description?: string;

  @doc("Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.")
  schemaDefinition?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Publisher configuration group schema update request definition.")
model ConfigurationGroupSchemaVersionUpdateState {
  @doc("The configuration group schema state.")
  @visibility("read", "create")
  versionState?: VersionState;
}

@doc("Hybrid configuration group value properties.")
@discriminator("configurationType")
model ConfigurationGroupValuePropertiesFormat {
  @doc("The provisioning state of the site resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The publisher name for the configuration group schema.")
  @visibility("read")
  publisherName?: string;

  @doc("The scope of the publisher.")
  @visibility("read")
  publisherScope?: PublisherScope;

  @doc("The configuration group schema name.")
  @visibility("read")
  configurationGroupSchemaName?: string;

  @doc("The location of the configuration group schema offering.")
  @visibility("read")
  configurationGroupSchemaOfferingLocation?: string;

  @doc("The configuration group schema resource reference.")
  configurationGroupSchemaResourceReference?: DeploymentResourceIdReference;
}

@doc("The azure resource reference which is used for deployment.")
@discriminator("idType")
model DeploymentResourceIdReference {}

@doc("Network function properties.")
@discriminator("configurationType")
model NetworkFunctionPropertiesFormat {
  @doc("The provisioning state of the network function resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The publisher name for the network function.")
  @visibility("read")
  publisherName?: string;

  @doc("The scope of the publisher.")
  @visibility("read")
  publisherScope?: PublisherScope;

  @doc("The network function definition group name for the network function.")
  @visibility("read")
  networkFunctionDefinitionGroupName?: string;

  @doc("The network function definition version for the network function.")
  @visibility("read")
  networkFunctionDefinitionVersion?: string;

  @doc("The location of the network function definition offering.")
  @visibility("read")
  networkFunctionDefinitionOfferingLocation?: string;

  @doc("The network function definition version resource reference.")
  networkFunctionDefinitionVersionResourceReference?: DeploymentResourceIdReference;

  @doc("The nfvi type for the network function.")
  nfviType?: NfviType;

  @doc("The nfviId for the network function.")
  nfviId?: string;

  @doc("Indicates if software updates are allowed during deployment.")
  allowSoftwareUpdate?: boolean;

  @doc("The role configuration override values from the user.")
  roleOverrideValues?: string[];
}

@doc("Payload for execute request post call.")
model ExecuteRequestParameters {
  @doc("The endpoint of service to call.")
  serviceEndpoint: string;

  @doc("The request metadata.")
  requestMetadata: RequestMetadata;
}

@doc("Request metadata of execute request post call payload.")
model RequestMetadata {
  @doc("The relative path of the request.")
  relativePath: string;

  @doc("The http method of the request.")
  httpMethod: HttpMethod;

  @doc("The serialized body of the request.")
  serializedBody: string;

  @doc("The api version of the request.")
  apiVersion?: string;
}

@doc("The component properties of the network function.")
model ComponentProperties {
  @doc("The provisioning state of the component resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The JSON-serialized deployment profile of the component resource.")
  @visibility("read")
  deploymentProfile?: string;

  @doc("The deployment status of the component resource.")
  @visibility("read")
  deploymentStatus?: DeploymentStatusProperties;
}

@doc("The deployment status properties of the network function component.")
model DeploymentStatusProperties {
  @doc("The status of the component resource.")
  status?: Status;

  @doc("The resource related to the component resource.")
  resources?: Resources;

  @doc("The next expected update of deployment status.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExpectedUpdateAt?: utcDateTime;
}

@doc("The resources of the network function component.")
model Resources {
  @doc("Deployments that are related to component resource.")
  deployments?: Deployment[];

  @doc("Pods related to component resource.")
  pods?: Pod[];

  @doc("Replica sets related to component resource.")
  replicaSets?: ReplicaSet[];

  @doc("Stateful sets related to component resource.")
  statefulSets?: StatefulSet[];

  @doc("Daemonsets related to component resource.")
  daemonSets?: DaemonSet[];
}

@doc("Helm Deployment status properties.")
model Deployment {
  @doc("The name of the deployment.")
  name?: string;

  @doc("The namespace of the deployment.")
  `namespace`?: string;

  @doc("Desired number of pods")
  desired?: int32;

  @doc("Number of ready pods.")
  ready?: int32;

  @doc("Number of upto date pods.")
  upToDate?: int32;

  @doc("Number of available pods.")
  available?: int32;

  @doc("Creation Time of deployment.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Helm Pod status properties.")
model Pod {
  @doc("The name of the Pod.")
  name?: string;

  @doc("The namespace of the Pod.")
  `namespace`?: string;

  @doc("Desired number of containers")
  desired?: int32;

  @doc("Number of ready containers.")
  ready?: int32;

  @doc("The status of a pod.")
  status?: PodStatus;

  @doc("Creation Time of Pod.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Last 5 Pod events.")
  events?: PodEvent[];
}

@doc("Pod Event  properties.")
model PodEvent {
  @doc("The type of pod event.")
  type?: PodEventType;

  @doc("Event reason.")
  reason?: string;

  @doc("Event message.")
  message?: string;

  @doc("Event Last seen.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeenTime?: utcDateTime;
}

@doc("Helm ReplicaSet status properties.")
model ReplicaSet {
  @doc("The name of the replicaSet.")
  name?: string;

  @doc("The namespace of the replicaSet.")
  `namespace`?: string;

  @doc("Desired number of pods")
  desired?: int32;

  @doc("Number of ready pods.")
  ready?: int32;

  @doc("Number of current pods.")
  current?: int32;

  @doc("Creation Time of replicaSet.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Helm StatefulSet status properties.")
model StatefulSet {
  @doc("The name of the statefulset.")
  name?: string;

  @doc("The namespace of the statefulset.")
  `namespace`?: string;

  @doc("Desired number of pods")
  desired?: int32;

  @doc("Number of ready pods.")
  ready?: int32;

  @doc("Creation Time of statefulset.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Helm DaemonSet status properties.")
model DaemonSet {
  @doc("The name of the daemonSet.")
  name?: string;

  @doc("The namespace of the daemonSet.")
  `namespace`?: string;

  @doc("Desired number of pods")
  desired?: int32;

  @doc("Current number of pods")
  current?: int32;

  @doc("Number of Ready pods")
  ready?: int32;

  @doc("Number of  upto date pods")
  upToDate?: int32;

  @doc("Number of available pods.")
  available?: int32;

  @doc("Creation Time of daemonSet.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;
}

@doc("Network function definition group properties.")
model NetworkFunctionDefinitionGroupPropertiesFormat {
  @doc("The provisioning state of the network function definition groups resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network function definition group description.")
  description?: string;
}

@doc("Network function definition version properties.")
@discriminator("networkFunctionType")
model NetworkFunctionDefinitionVersionPropertiesFormat {
  @doc("The provisioning state of the network function definition version resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network function definition version state.")
  @visibility("read")
  versionState?: VersionState;

  @doc("The network function definition version description.")
  description?: string;

  @doc("The deployment parameters of the network function definition version.")
  deployParameters?: string;
}

@doc("Publisher network function definition version update request definition.")
model NetworkFunctionDefinitionVersionUpdateState {
  @doc("The network function definition version state. Only the 'Active' and 'Deprecated' states are allowed for updates. Other states are used for internal state transitioning.")
  @visibility("read", "create")
  versionState?: VersionState;
}

@doc("network service design group properties.")
model NetworkServiceDesignGroupPropertiesFormat {
  @doc("The provisioning state of the network service design groups resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network service design group description.")
  description?: string;
}

@doc("network service design version properties.")
model NetworkServiceDesignVersionPropertiesFormat {
  @doc("The provisioning state of the network service design version resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network service design version state.")
  @visibility("read")
  versionState?: VersionState;

  @doc("The network service design version description.")
  description?: string;

  @doc("The configuration schemas to used to define the values.")
  configurationGroupSchemaReferences?: Record<ReferencedResource>;

  @doc("The nfvis from the site.")
  nfvisFromSite?: Record<NfviDetails>;

  @doc("List of resource element template")
  resourceElementTemplates?: ResourceElementTemplate[];
}

@doc("Reference to another resource.")
model ReferencedResource {
  @doc("Resource ID.")
  id?: string;
}

@doc("The nfvi details.")
model NfviDetails {
  @doc("The nfvi name.")
  name?: string;

  @doc("The nfvi type.")
  type?: string;
}

@doc("The resource element template object.")
@discriminator("type")
model ResourceElementTemplate {
  @doc("Name of the resource element template.")
  name?: string;

  @doc("The depends on profile.")
  dependsOnProfile?: DependsOnProfile;
}

@doc("Depends on profile definition.")
model DependsOnProfile {
  @doc("Application installation operation dependency.")
  installDependsOn?: string[];

  @doc("Application deletion operation dependency.")
  uninstallDependsOn?: string[];

  @doc("Application update operation dependency.")
  updateDependsOn?: string[];
}

@doc("Publisher network service design version update request definition.")
model NetworkServiceDesignVersionUpdateState {
  @doc("The network service design version state.")
  @visibility("read", "create")
  versionState?: VersionState;
}

@doc("publisher properties.")
model PublisherPropertiesFormat {
  @doc("The provisioning state of the publisher resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The publisher scope.")
  @visibility("read", "create")
  scope?: PublisherScope;
}

@doc("Artifact store properties.")
model ArtifactStorePropertiesFormat {
  @doc("The provisioning state of the application groups resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The artifact store type.")
  @visibility("read", "create")
  storeType?: ArtifactStoreType;

  @doc("The replication strategy.")
  replicationStrategy?: ArtifactReplicationStrategy;

  managedResourceGroupConfiguration?: ArtifactStorePropertiesFormatManagedResourceGroupConfiguration;

  @doc("The created storage resource id")
  @visibility("read")
  storageResourceId?: string;
}

model ArtifactStorePropertiesFormatManagedResourceGroupConfiguration {
  @doc("The managed resource group name.")
  @visibility("read", "create")
  name?: string;

  @doc("The managed resource group location.")
  @visibility("read", "create")
  location?: string;
}

@doc("Artifact manifest properties.")
model ArtifactManifestPropertiesFormat {
  @doc("The provisioning state of the ArtifactManifest resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The artifact manifest state.")
  @visibility("read")
  artifactManifestState?: ArtifactManifestState;

  @doc("The artifacts list.")
  artifacts?: ManifestArtifactFormat[];
}

@doc("Manifest artifact properties.")
model ManifestArtifactFormat {
  @doc("The artifact name")
  @visibility("read", "create")
  artifactName?: string;

  @doc("The artifact type.")
  @visibility("read", "create")
  artifactType?: ArtifactType;

  @doc("The artifact version.")
  @visibility("read", "create")
  artifactVersion?: string;
}

@doc("The artifact manifest credential definition.")
@discriminator("credentialType")
model ArtifactAccessCredential {}

@doc("The artifact manifest updating request payload. Only the 'Uploaded' state is allowed for updates. Other states are used for internal state transitioning.")
model ArtifactManifestUpdateState {
  @doc("The artifact manifest state.")
  @visibility("read", "create")
  artifactManifestState?: ArtifactManifestState;
}

@doc("The proxy artifact list result.")
model ProxyArtifactOverviewListResult
  is Azure.Core.Page<ProxyArtifactListOverview>;

@doc("The proxy artifact overview.")
model ProxyArtifactListOverview extends ProxyResource {}

@doc("The proxy artifact list result.")
model ProxyArtifactVersionsOverviewListResult
  is Azure.Core.Page<ProxyArtifactVersionsListOverview>;

@doc("The proxy artifact overview.")
model ProxyArtifactVersionsListOverview extends ProxyResource {
  @doc("Proxy Artifact overview properties.")
  @visibility("read")
  properties?: ProxyArtifactOverviewPropertiesValue;
}

model ProxyArtifactOverviewPropertiesValue {
  @doc("The artifact type.")
  artifactType?: ArtifactType;

  @doc("The artifact version.")
  artifactVersion?: string;

  @doc("The artifact state")
  artifactState?: ArtifactState;
}

@doc("The artifact updating request payload.")
model ArtifactChangeState {
  @doc("Artifact update state properties.")
  properties?: ArtifactChangeStateProperties;
}

@doc("The artifact update state properties.")
model ArtifactChangeStateProperties {
  @doc("The artifact state")
  artifactState?: ArtifactState;
}

@doc("Site properties.")
model SitePropertiesFormat {
  @doc("The provisioning state of the site resource. **TODO**: Confirm if this is needed.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of NFVIs")
  nfvis?: NFVIs[];

  @doc("The list of site network services on the site.")
  @visibility("read")
  siteNetworkServiceReferences?: ReferencedResource[];
}

@doc("The NFVI object.")
@discriminator("nfviType")
model NFVIs {
  @doc("Name of the nfvi.")
  name?: string;
}

@doc("Site network service properties.")
model SiteNetworkServicePropertiesFormat {
  @doc("The provisioning state of the site network service resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("The site details")
  siteReference?: ReferencedResource;

  @doc("The publisher name for the site network service.")
  @visibility("read")
  publisherName?: string;

  @doc("The scope of the publisher.")
  @visibility("read")
  publisherScope?: PublisherScope;

  @doc("The network service design group name for the site network service.")
  @visibility("read")
  networkServiceDesignGroupName?: string;

  @doc("The network service design version for the site network service.")
  @visibility("read")
  networkServiceDesignVersionName?: string;

  @doc("The location of the network service design offering.")
  @visibility("read")
  networkServiceDesignVersionOfferingLocation?: string;

  @doc("The network service design version resource reference.")
  networkServiceDesignVersionResourceReference?: DeploymentResourceIdReference;

  @doc("The goal state of the site network service resource. This has references to the configuration group value objects that describe the desired state of the site network service.")
  desiredStateConfigurationGroupValueReferences?: Record<ReferencedResource>;

  @doc("The network service design version for the site network service.")
  @visibility("read")
  lastStateNetworkServiceDesignVersionName?: string;

  @doc("The last state of the site network service resource.")
  @visibility("read")
  lastStateConfigurationGroupValueReferences?: Record<ReferencedResource>;
}

@doc("Managed resource group configuration.")
model ManagedResourceGroupConfiguration {
  @doc("Managed resource group name.")
  name?: string;

  @doc("Managed resource group location.")
  location?: string;
}

@doc("Sku, to be associated with a SiteNetworkService.")
model Sku {
  @doc("Name of this Sku")
  name: SkuName;

  @doc("The SKU tier based on the SKU name.")
  @visibility("read")
  tier?: SkuTier;
}

@doc("Reference to an Azure ARC custom location resource.")
model CustomLocationResourceId {
  @doc("Azure ARC custom location resource ID.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][xX][tT][eE][nN][dD][eE][dD][lL][oO][cC][aA][tT][iI][oO][nN]/[cC][uU][sS][tT][oO][mM][lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+$")
  id?: string;
}

@doc("Network function application definition.")
model NetworkFunctionApplication {
  @doc("The name of the network function application.")
  name?: string;

  @doc("Depends on profile definition.")
  dependsOnProfile?: DependsOnProfile;
}

@doc("Artifact profile properties.")
model ArtifactProfile {
  @doc("The reference to artifact store.")
  artifactStore?: ReferencedResource;
}

@doc("Mapping rule profile properties.")
model MappingRuleProfile {
  @doc("The application enablement.")
  applicationEnablement?: ApplicationEnablement;
}

@doc("The azure container registry scoped token credential definition.")
model AzureContainerRegistryScopedTokenCredential
  extends ArtifactAccessCredential {
  @doc("The username of the credential.")
  username?: string;

  @doc("The credential value.")
  acrToken?: string;

  @doc("The Acr server url")
  acrServerUrl?: string;

  @doc("The repositories that could be accessed using the current credential.")
  repositories?: string[];

  @doc("The UTC time when credential will expire.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("The credential type.")
  credentialType: "AzureContainerRegistryScopedToken";
}

@doc("The azure storage account credential definition.")
model AzureStorageAccountCredential extends ArtifactAccessCredential {
  @doc("The storage account Id")
  storageAccountId?: string;

  @doc("The containers that could be accessed using the current credential.")
  containerCredentials?: AzureStorageAccountContainerCredential[];

  @doc("The UTC time when credential will expire.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  @doc("The credential type.")
  credentialType: "AzureStorageAccountToken";
}

@doc("The azure storage account container credential definition.")
model AzureStorageAccountContainerCredential {
  @doc("The storage account container name")
  containerName?: string;

  @doc("The storage account container sas uri")
  containerSasUri?: string;
}

@doc("Secret deployment resource id reference.")
model SecretDeploymentResourceReference extends DeploymentResourceIdReference {
  @doc("Resource ID.")
  @visibility("create", "update")
  id?: string;

  @doc("The resource reference arm id type.")
  idType: "Secret";
}

@doc("Non secret deployment resource id reference.")
model OpenDeploymentResourceReference extends DeploymentResourceIdReference {
  @doc("Resource ID.")
  id?: string;

  @doc("The resource reference arm id type.")
  idType: "Open";
}

@doc("The ConfigurationValue with secrets.")
model ConfigurationValueWithSecrets
  extends ConfigurationGroupValuePropertiesFormat {
  @doc("Name and value pairs that define the configuration value secrets. It can be a well formed escaped JSON string.")
  @visibility("create", "update")
  secretConfigurationValue?: string;

  @doc("The value which indicates if configuration values are secrets")
  configurationType: "Secret";
}

@doc("The ConfigurationValue with no secrets.")
model ConfigurationValueWithoutSecrets
  extends ConfigurationGroupValuePropertiesFormat {
  @doc("Name and value pairs that define the configuration value. It can be a well formed escaped JSON string.")
  configurationValue?: string;

  @doc("The value which indicates if configuration values are secrets")
  configurationType: "Open";
}

@doc("NetworkFunction with secrets.")
model NetworkFunctionValueWithSecrets extends NetworkFunctionPropertiesFormat {
  @doc("The JSON-serialized secret deployment values from the user. This contains secrets like passwords,keys etc")
  @visibility("create", "update")
  secretDeploymentValues?: string;

  @doc("The value which indicates if NF  values are secrets")
  configurationType: "Secret";
}

@doc("NetworkFunction with no secrets.")
model NetworkFunctionValueWithoutSecrets
  extends NetworkFunctionPropertiesFormat {
  @doc("The JSON-serialized deployment values from the user.")
  deploymentValues?: string;

  @doc("The value which indicates if NF  values are secrets")
  configurationType: "Open";
}

@doc("Containerized network function network function definition version properties.")
model ContainerizedNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  @doc("Containerized network function template.")
  networkFunctionTemplate?: ContainerizedNetworkFunctionTemplate;

  @doc("The network function type.")
  networkFunctionType: "ContainerizedNetworkFunction";
}

@doc("Containerized network function template.")
@discriminator("nfviType")
model ContainerizedNetworkFunctionTemplate {}

@doc("Virtual network function network function definition version properties.")
model VirtualNetworkFunctionNetworkFunctionDefinitionVersion
  extends NetworkFunctionDefinitionVersionPropertiesFormat {
  @doc("Virtual network function template.")
  networkFunctionTemplate?: VirtualNetworkFunctionTemplate;

  @doc("The network function type.")
  networkFunctionType: "VirtualNetworkFunction";
}

@doc("Virtual network function template.")
@discriminator("nfviType")
model VirtualNetworkFunctionTemplate {}

@doc("Azure Arc kubernetes network function template.")
model AzureArcKubernetesNetworkFunctionTemplate
  extends ContainerizedNetworkFunctionTemplate {
  @doc("Network function applications.")
  networkFunctionApplications?: AzureArcKubernetesNetworkFunctionApplication[];

  @doc("The network function type.")
  nfviType: "AzureArcKubernetes";
}

@doc("Azure arc kubernetes network function application definition.")
@discriminator("artifactType")
model AzureArcKubernetesNetworkFunctionApplication
  extends NetworkFunctionApplication {}

@doc("Azure arc kubernetes helm application configurations.")
model AzureArcKubernetesHelmApplication
  extends AzureArcKubernetesNetworkFunctionApplication {
  @doc("Azure arc kubernetes artifact profile.")
  artifactProfile?: AzureArcKubernetesArtifactProfile;

  @doc("Deploy mapping rule profile.")
  deployParametersMappingRuleProfile?: AzureArcKubernetesDeployMappingRuleProfile;

  @doc("The artifact type.")
  artifactType: "HelmPackage";
}

@doc("Azure arc kubernetes artifact profile properties.")
model AzureArcKubernetesArtifactProfile extends ArtifactProfile {
  @doc("Helm artifact profile.")
  helmArtifactProfile?: HelmArtifactProfile;
}

@doc("Helm artifact profile.")
model HelmArtifactProfile {
  @doc("Helm package name.")
  helmPackageName?: string;

  @doc("Helm package version range.")
  helmPackageVersionRange?: string;

  @doc("The registry values path list.")
  registryValuesPaths?: string[];

  @doc("The image pull secrets values path list.")
  imagePullSecretsValuesPaths?: string[];
}

@doc("Azure arc kubernetes deploy mapping rule profile.")
model AzureArcKubernetesDeployMappingRuleProfile extends MappingRuleProfile {
  @doc("The helm mapping rule profile.")
  helmMappingRuleProfile?: HelmMappingRuleProfile;
}

@doc("Helm mapping rule profile")
model HelmMappingRuleProfile {
  @doc("Helm release namespace.")
  releaseNamespace?: string;

  @doc("Helm release name.")
  releaseName?: string;

  @doc("Helm package version.")
  helmPackageVersion?: string;

  @doc("Helm release values.")
  @visibility("read", "create")
  values?: string;

  @doc("The helm deployment options")
  options?: HelmMappingRuleProfileOptions;
}

@doc("The helm deployment options")
model HelmMappingRuleProfileOptions {
  @doc("The helm deployment install options")
  installOptions?: HelmInstallOptions;

  @doc("The helm deployment upgrade options")
  upgradeOptions?: HelmUpgradeOptions;
}

@doc("The helm deployment install options")
model HelmInstallOptions {
  @doc("The helm deployment atomic options")
  atomic?: string;

  @doc("The helm deployment wait options")
  wait?: string;

  @doc("The helm deployment timeout options")
  timeout?: string;
}

@doc("The helm deployment install options")
model HelmUpgradeOptions {
  @doc("The helm deployment atomic options")
  atomic?: string;

  @doc("The helm deployment wait options")
  wait?: string;

  @doc("The helm deployment timeout options")
  timeout?: string;
}

@doc("Azure virtual network function template.")
model AzureCoreNetworkFunctionTemplate extends VirtualNetworkFunctionTemplate {
  @doc("Network function applications.")
  networkFunctionApplications?: AzureCoreNetworkFunctionApplication[];

  @doc("The network function type.")
  nfviType: "AzureCore";
}

@doc("Azure virtual network function application definition.")
@discriminator("artifactType")
model AzureCoreNetworkFunctionApplication extends NetworkFunctionApplication {}

@doc("Azure Operator Distributed Services network function template.")
model AzureOperatorNexusNetworkFunctionTemplate
  extends VirtualNetworkFunctionTemplate {
  @doc("Network function applications.")
  networkFunctionApplications?: AzureOperatorNexusNetworkFunctionApplication[];

  @doc("The network function type.")
  nfviType: "AzureOperatorNexus";
}

@doc("Azure Operator Distributed Services network function application definition.")
@discriminator("artifactType")
model AzureOperatorNexusNetworkFunctionApplication
  extends NetworkFunctionApplication {}

@doc("Azure core network function vhd application definition.")
model AzureCoreNetworkFunctionVhdApplication
  extends AzureCoreNetworkFunctionApplication {
  @doc("Azure vhd image artifact profile.")
  artifactProfile?: AzureCoreVhdImageArtifactProfile;

  @doc("Deploy mapping rule profile.")
  deployParametersMappingRuleProfile?: AzureCoreVhdImageDeployMappingRuleProfile;

  @doc("The artifact type.")
  artifactType: "VhdImageFile";
}

@doc("Azure vhd artifact profile properties.")
model AzureCoreVhdImageArtifactProfile extends ArtifactProfile {
  @doc("Vhd artifact profile.")
  vhdArtifactProfile?: VhdImageArtifactProfile;
}

@doc("Vhd artifact profile.")
model VhdImageArtifactProfile {
  @doc("Vhd name.")
  vhdName?: string;

  @doc("Vhd version.")
  vhdVersion?: string;
}

@doc("Azure vhd deploy mapping rule profile.")
model AzureCoreVhdImageDeployMappingRuleProfile extends MappingRuleProfile {
  @doc("The vhd mapping rule profile.")
  vhdImageMappingRuleProfile?: VhdImageMappingRuleProfile;
}

@doc("Vhd mapping rule profile")
model VhdImageMappingRuleProfile {
  @doc("List of values.")
  userConfiguration?: string;
}

@doc("Azure core network function Template application definition.")
model AzureCoreNetworkFunctionArmTemplateApplication
  extends AzureCoreNetworkFunctionApplication {
  @doc("Azure template artifact profile.")
  artifactProfile?: AzureCoreArmTemplateArtifactProfile;

  @doc("Deploy mapping rule profile.")
  deployParametersMappingRuleProfile?: AzureCoreArmTemplateDeployMappingRuleProfile;

  @doc("The artifact type.")
  artifactType: "ArmTemplate";
}

@doc("Azure template artifact profile properties.")
model AzureCoreArmTemplateArtifactProfile extends ArtifactProfile {
  @doc("Template artifact profile.")
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

@doc("Template artifact profile.")
model ArmTemplateArtifactProfile {
  @doc("Template name.")
  templateName?: string;

  @doc("Template version.")
  templateVersion?: string;
}

@doc("Azure template deploy mapping rule profile.")
model AzureCoreArmTemplateDeployMappingRuleProfile extends MappingRuleProfile {
  @doc("The template mapping rule profile.")
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

@doc("Template mapping rule profile")
model ArmTemplateMappingRuleProfile {
  @doc("List of template parameters.")
  templateParameters?: string;
}

@doc("Azure Operator Distributed Services network function image application definition.")
model AzureOperatorNexusNetworkFunctionImageApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  @doc("Azure Operator Distributed Services image artifact profile.")
  artifactProfile?: AzureOperatorNexusImageArtifactProfile;

  @doc("Deploy mapping rule profile.")
  deployParametersMappingRuleProfile?: AzureOperatorNexusImageDeployMappingRuleProfile;

  @doc("The artifact type.")
  artifactType: "ImageFile";
}

@doc("Azure Operator Distributed Services image artifact profile properties.")
model AzureOperatorNexusImageArtifactProfile extends ArtifactProfile {
  @doc("Image artifact profile.")
  imageArtifactProfile?: ImageArtifactProfile;
}

@doc("Image artifact profile.")
model ImageArtifactProfile {
  @doc("Image name.")
  imageName?: string;

  @doc("Image version.")
  imageVersion?: string;
}

@doc("Azure Operator Distributed Services image deploy mapping rule profile.")
model AzureOperatorNexusImageDeployMappingRuleProfile
  extends MappingRuleProfile {
  @doc("The vhd mapping rule profile.")
  imageMappingRuleProfile?: ImageMappingRuleProfile;
}

@doc("Image mapping rule profile")
model ImageMappingRuleProfile {
  @doc("List of values.")
  userConfiguration?: string;
}

@doc("Azure Operator Distributed Services network function Template application definition.")
model AzureOperatorNexusNetworkFunctionArmTemplateApplication
  extends AzureOperatorNexusNetworkFunctionApplication {
  @doc("Azure Operator Distributed Services Template artifact profile.")
  artifactProfile?: AzureOperatorNexusArmTemplateArtifactProfile;

  @doc("Deploy mapping rule profile.")
  deployParametersMappingRuleProfile?: AzureOperatorNexusArmTemplateDeployMappingRuleProfile;

  @doc("The artifact type.")
  artifactType: "ArmTemplate";
}

@doc("Azure Operator Distributed Services vhd artifact profile properties.")
model AzureOperatorNexusArmTemplateArtifactProfile extends ArtifactProfile {
  @doc("Template artifact profile.")
  templateArtifactProfile?: ArmTemplateArtifactProfile;
}

@doc("Azure Operator Distributed Services template deploy mapping rule profile.")
model AzureOperatorNexusArmTemplateDeployMappingRuleProfile
  extends MappingRuleProfile {
  @doc("The template mapping rule profile.")
  templateMappingRuleProfile?: ArmTemplateMappingRuleProfile;
}

@doc("The arm resource definition resource element template details.")
model ArmResourceDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  @doc("The resource element template type.")
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  @doc("The resource element template type.")
  type: "ArmResourceDefinition";
}

@doc("The arm template RE.")
model ArmResourceDefinitionResourceElementTemplate {
  @doc("The template type.")
  templateType?: TemplateType;

  @doc("Name and value pairs that define the parameter values. It can be  a well formed escaped JSON string.")
  parameterValues?: string;

  @doc("Artifact profile properties.")
  artifactProfile?: NSDArtifactProfile;
}

@doc("Artifact profile properties.")
model NSDArtifactProfile {
  @doc("The artifact store resource id")
  artifactStoreReference?: ReferencedResource;

  @doc("Artifact name.")
  artifactName?: string;

  @doc("Artifact version.")
  artifactVersion?: string;
}

@doc("The network function definition resource element template details.")
model NetworkFunctionDefinitionResourceElementTemplateDetails
  extends ResourceElementTemplate {
  @doc("The resource element template type.")
  configuration?: ArmResourceDefinitionResourceElementTemplate;

  @doc("The resource element template type.")
  type: "NetworkFunctionDefinition";
}

@doc("The proxy artifact overview.")
model ProxyArtifactOverview extends ProxyResource {
  @doc("Proxy Artifact properties overview.")
  @visibility("read")
  properties?: ProxyArtifactOverviewPropertiesFormat;
}

@doc("Proxy Artifact overview properties.")
model ProxyArtifactOverviewPropertiesFormat {
  @doc("The proxy artifact overview properties.")
  artifactVersions?: ProxyArtifactOverviewPropertiesValue[];
}

@doc("The Azure Core NFVI detail.")
model AzureCoreNfviDetails extends NFVIs {
  @doc("Location of the Azure core.")
  location?: string;

  @doc("The NFVI type.")
  nfviType: "AzureCore";
}

@doc("The AzureArcK8sCluster NFVI detail.")
model AzureArcK8SClusterNfviDetails extends NFVIs {
  @doc("The reference to the custom location.")
  customLocationReference?: ReferencedResource;

  @doc("The NFVI type.")
  nfviType: "AzureArcKubernetes";
}

@doc("The AzureOperatorNexusCluster NFVI detail.")
model AzureOperatorNexusClusterNfviDetails extends NFVIs {
  @doc("The reference to the custom location.")
  customLocationReference?: ReferencedResource;

  @doc("The NFVI type.")
  nfviType: "AzureOperatorNexus";
}
