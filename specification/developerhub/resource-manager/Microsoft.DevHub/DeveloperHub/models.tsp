import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevHub;

/**
 * Determines the authorization status of requests.
 */
union AuthorizationStatus {
  string,

  /**
   * Requests authorized successfully
   */
  Authorized: "Authorized",

  /**
   * Requests returned NotFound response
   */
  NotFound: "NotFound",

  /**
   * Requests returned other error response
   */
  Error: "Error",
}

/**
 * The status of the Pull Request submitted against the users repository.
 */
union PullRequestStatus {
  string,

  /**
   * Pull Request state unknown.
   */
  `unknown`: "unknown",

  /**
   * Pull Request submitted to repository.
   */
  submitted: "submitted",

  /**
   * Pull Request merged into repository.
   */
  merged: "merged",

  /**
   * Workflow no longer found within repository.
   */
  removed: "removed",
}

/**
 * Determines the authorization status of requests.
 */
union QuickStartTemplateType {
  string,

  /**
   * The template has not use quick start template
   */
  None: "None",

  /**
   * The template use quick start template of HCI
   */
  HCI: "HCI",

  /**
   * The template use quick start template of HCI and AKS
   */
  HCIAKS: "HCIAKS",

  /**
   * The template use quick start template of HCI and ArcVM
   */
  HCIARCVM: "HCIARCVM",
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
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Determines the type of manifests within the repository.
 */
union ManifestType {
  string,

  /**
   * Repositories using helm
   */
  helm: "helm",

  /**
   * Repositories using kubernetes manifests
   */
  kube: "kube",

  /**
   * Repositories using kustomize
   */
  kustomize: "kustomize",
}

/**
 * Describes the status of the workflow run
 */
union WorkflowRunStatus {
  string,

  /**
   * Workflow run is queued
   */
  queued: "queued",

  /**
   * Workflow run is inprogress
   */
  inprogress: "inprogress",

  /**
   * Workflow run is completed
   */
  completed: "completed",
}

/**
 * The programming language used.
 */
union GenerationLanguage {
  string,

  /**
   * clojure language
   */
  clojure: "clojure",

  /**
   * csharp language
   */
  csharp: "csharp",

  /**
   * erlang language
   */
  erlang: "erlang",

  /**
   * go language
   */
  go: "go",

  /**
   * gomodule language
   */
  gomodule: "gomodule",

  /**
   * gradle language
   */
  gradle: "gradle",

  /**
   * java language
   */
  java: "java",

  /**
   * javascript language
   */
  javascript: "javascript",

  /**
   * php language
   */
  php: "php",

  /**
   * python language
   */
  python: "python",

  /**
   * ruby language
   */
  ruby: "ruby",

  /**
   * rust language
   */
  rust: "rust",

  /**
   * swift language
   */
  swift: "swift",
}

/**
 * The mode of generation to be used for generating Dockerfiles.
 */
union DockerfileGenerationMode {
  string,

  /**
   * Dockerfiles will be generated
   */
  enabled: "enabled",

  /**
   * Dockerfiles will not be generated
   */
  disabled: "disabled",
}

/**
 * The mode of generation to be used for generating Manifest.
 */
union ManifestGenerationMode {
  string,

  /**
   * Manifests will be generated
   */
  enabled: "enabled",

  /**
   * Manifests will not be generated
   */
  disabled: "disabled",
}

/**
 * Determines the type of manifests to be generated.
 */
union GenerationManifestType {
  string,

  /**
   * Helm manifests
   */
  helm: "helm",

  /**
   * Kubernetes manifests
   */
  kube: "kube",
}

/**
 * The status of the Pull Request submitted against the users repository.
 */
union RepositoryProviderType {
  string,

  /**
   * GitHub repository provider type.
   */
  github: "github",

  /**
   * ADO repository provider type.
   */
  ado: "ado",
}

/**
 * The type of the template.
 */
union TemplateType {
  string,

  /**
   * Deployment template type.
   */
  deployment: "deployment",

  /**
   * Manifest template type.
   */
  manifest: "manifest",

  /**
   * Workflow template type.
   */
  workflow: "workflow",

  /**
   * Dockerfile template type.
   */
  dockerfile: "dockerfile",
}

/**
 * The type of the template parameter.
 */
union ParameterType {
  string,

  /**
   * string parameter type.
   */
  string: "string",

  /**
   * boolean parameter type.
   */
  bool: "bool",

  /**
   * int parameter type.
   */
  int: "int",

  /**
   * float parameter type.
   */
  float: "float",

  /**
   * object parameter type.
   */
  object: "object",
}

/**
 * The type of the template parameter.
 */
union ParameterKind {
  string,

  /**
   * azure container registry name
   */
  azureContainerRegistry: "azureContainerRegistry",

  /**
   * azure keyvault uri
   */
  azureKeyvaultUri: "azureKeyvaultUri",

  /**
   * azure managed cluster name
   */
  azureManagedCluster: "azureManagedCluster",

  /**
   * azure resource group
   */
  azureResourceGroup: "azureResourceGroup",

  /**
   * azure service connection
   */
  azureServiceConnection: "azureServiceConnection",

  /**
   * container image name
   */
  containerImageName: "containerImageName",

  /**
   * container image version
   */
  containerImageVersion: "containerImageVersion",

  /**
   * cluster resource type
   */
  clusterResourceType: "clusterResourceType",

  /**
   * directory path
   */
  dirPath: "dirPath",

  /**
   * dockerfile name
   */
  dockerFileName: "dockerFileName",

  /**
   * environment variables in the form of a json object
   */
  envVarMap: "envVarMap",

  /**
   * file path
   */
  filePath: "filePath",

  /**
   * boolean flag
   */
  flag: "flag",

  /**
   * helm overrides in the form of a string key1=value1,key2=value2
   */
  helmChartOverrides: "helmChartOverrides",

  /**
   * kubernetes deployment image pull policy
   */
  imagePullPolicy: "imagePullPolicy",

  /**
   * kubernetes ingress host name
   */
  ingressHostName: "ingressHostName",

  /**
   * kubernetes namespace
   */
  kubernetesNamespace: "kubernetesNamespace",

  /**
   * kubernetes probe http path
   */
  kubernetesProbeHttpPath: "kubernetesProbeHttpPath",

  /**
   * kubernetes probe period
   */
  kubernetesProbePeriod: "kubernetesProbePeriod",

  /**
   * kubernetes probe timeout
   */
  kubernetesProbeTimeout: "kubernetesProbeTimeout",

  /**
   * kubernetes probe threshold
   */
  kubernetesProbeThreshold: "kubernetesProbeThreshold",

  /**
   * kubernetes probe type
   */
  kubernetesProbeType: "kubernetesProbeType",

  /**
   * kubernetes probe delay
   */
  kubernetesProbeDelay: "kubernetesProbeDelay",

  /**
   * kubernetes resource limit
   */
  kubernetesResourceLimit: "kubernetesResourceLimit",

  /**
   * kubernetes resource name
   */
  kubernetesResourceName: "kubernetesResourceName",

  /**
   * kubernetes resource request
   */
  kubernetesResourceRequest: "kubernetesResourceRequest",

  /**
   * kubernetes label value
   */
  label: "label",

  /**
   * service port
   */
  port: "port",

  /**
   * repository branch name
   */
  repositoryBranch: "repositoryBranch",

  /**
   * workflow name
   */
  workflowName: "workflowName",

  /**
   * kubernetes replica count
   */
  replicaCount: "replicaCount",

  /**
   * kubernetes scaling resource type
   */
  scalingResourceType: "scalingResourceType",

  /**
   * kubernetes resource utilization type
   */
  scalingResourceUtilization: "scalingResourceUtilization",

  /**
   * kubernetes resource limit
   */
  resourceLimit: "resourceLimit",

  /**
   * workflow authentication type
   */
  workflowAuthType: "workflowAuthType",
}

/**
 * Properties of a IacProfile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IacProfileProperties {
  /**
   * GitHub Profile of a IacProfile
   */
  githubProfile?: IacGitHubProfile;

  /**
   * Terraform Profile of a IacProfile
   */
  terraformProfile?: TerraformProfile;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  stages?: StageProperties[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  templates?: IacTemplateProperties[];
}

/**
 * GitHub Profile of a IacProfile.
 */
model IacGitHubProfile {
  /**
   * Repository Name
   */
  @summary("The name of the repository the IacProfile is associated with.")
  repositoryName?: string;

  /**
   * Repository Main Branch
   */
  @summary("The name of the main branch of the repository the IacProfile is associated with.")
  repositoryMainBranch?: string;

  /**
   * Repository Owner
   */
  @summary("The owner of the repository the IacProfile is associated with.")
  repositoryOwner?: string;

  /**
   * Determines the authorization status of requests.
   */
  @visibility(Lifecycle.Read)
  authStatus?: AuthorizationStatus;

  /**
   * The number associated with the submitted pull request.
   */
  @visibility(Lifecycle.Read)
  pullNumber?: int32;

  /**
   * The status of the Pull Request submitted against the users repository.
   */
  @visibility(Lifecycle.Read)
  prStatus?: PullRequestStatus;

  /**
   * Repository Branch Name
   */
  @summary("The name of the branch current operation is associated with.")
  branchName?: string;
}

/**
 * Terraform backend profile.
 */
model TerraformProfile {
  /**
   * Terraform Storage Account Subscription
   */
  @summary("The subscription id of the storage account that save terraform state.")
  storageAccountSubscription?: string;

  /**
   * Terraform Storage Account Resource Group
   */
  @summary("The resource group of the storage account that save terraform state.")
  storageAccountResourceGroup?: string;

  /**
   * Terraform Storage Account Name
   */
  @summary("The name of the storage account that save terraform state.")
  storageAccountName?: string;

  /**
   * Terraform Container Name
   */
  @summary("The name of the container that save terraform state.")
  storageContainerName?: string;
}

/**
 * Properties of a Stage.
 */
model StageProperties {
  /**
   * Stage Name
   */
  @summary("The name of the stage.")
  stageName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dependencies?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gitEnvironment?: string;
}

/**
 * Properties of a IacTemplate.
 */
model IacTemplateProperties {
  /**
   * Template Name
   */
  @summary("The name of the template.")
  templateName?: string;

  /**
   * the source store of the template
   */
  @summary("The source resource Id of the template.")
  sourceResourceId?: string;

  /**
   * the source stage of the template
   */
  @summary("The sample instance stage of the template.")
  instanceStage?: string;

  /**
   * the sample instance name of the template
   */
  @summary("The sample instance name of the template.")
  instanceName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  templateDetails?: IacTemplateDetails[];

  /**
   * Determines the authorization status of requests.
   */
  @visibility(Lifecycle.Read)
  quickStartTemplateType?: QuickStartTemplateType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IacTemplateDetails {
  /**
   * The name of the products.
   */
  productName?: string;

  /**
   * Count of the product
   */
  count?: int32;

  /**
   * Naming convention of this product
   */
  namingConvention?: string;
}

/**
 * Resource tags.
 */
model TagsObject {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExportTemplateRequest {
  /**
   * Template Name
   */
  @summary("The name of the template.")
  templateName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resourceGroupIds?: string[];
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  siteId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceStage?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrLinkResponse {
  /**
   * The link of the pull request.
   */
  prLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ScaleTemplateRequest {
  /**
   * Template Name
   */
  @summary("The name of the template.")
  templateName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scaleRequirement?: ScaleProperty[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ScaleProperty {
  /**
   * The region of the store
   */
  region?: string;

  /**
   * The stage of the store
   */
  stage?: string;

  /**
   * Number of the store
   */
  numberOfStore?: int32;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * GitHubOAuth request object
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GitHubOAuthCallRequest {
  /**
   * The URL the client will redirect to on successful authentication. If empty, no redirect will occur.
   */
  redirectUrl?: string;
}

/**
 * URL used to authorize the Developer Hub GitHub App
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GitHubOAuthInfoResponse {
  /**
   * URL for authorizing the Developer Hub GitHub App
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authURL?: string;

  /**
   * OAuth token used to make calls to GitHub
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  token?: string;
}

/**
 * The response from List GitHubOAuth operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GitHubOAuthProperties {
  /**
   * user making request
   */
  username?: string;
}

/**
 * The response from List GitHubOAuth operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GitHubOAuthListResponse {
  /**
   * Singleton list response containing one GitHubOAuthResponse response
   */
  @pageItems
  value?: GitHubOAuthResponse[];
}

/**
 * Workflow properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowProperties {
  /**
   * Profile of a github workflow.
   */
  githubWorkflowProfile?: GitHubWorkflowProfile;

  /**
   * Properties for generating artifacts like dockerfile and manifests.
   */
  artifactGenerationProperties?: ArtifactGenerationProperties;

  /**
   * Profile of an azure pipeline.
   */
  azurePipelineProfile?: AzurePipelineProfile;

  /**
   * Profile of an template workflow.
   */
  templateWorkflowProfile?: TemplateWorkflowProfile;
}

/**
 * GitHub Workflow Profile
 */
model GitHubWorkflowProfile {
  /**
   * Repository Owner
   */
  @summary("The owner of the repository the workflow is associated with.")
  repositoryOwner?: string;

  /**
   * Repository Name
   */
  @summary("The name of the repository the workflow is associated with.")
  repositoryName?: string;

  /**
   * Repository Branch Name
   */
  @summary("The name of the branch the workflow is associated with.")
  branchName?: string;

  /**
   * Path to the Dockerfile within the repository.
   */
  @summary("Path to Dockerfile within the repository.")
  dockerfile?: string;

  /**
   * Path to Dockerfile Build Context within the repository.
   */
  @summary("Path to Dockerfile Build Context within the repository.")
  dockerBuildContext?: string;

  /**
   * Deployment details of the repository associated with the workflow.
   */
  deploymentProperties?: Deployment;

  /**
   * Kubernetes namespace the application is deployed to.
   */
  @summary("The Kubernetes namespace the application is deployed to")
  `namespace`?: string;

  /**
   * Information on the azure container registry
   */
  acr?: ACR;

  /**
   * The fields needed for OIDC with GitHub.
   */
  oidcCredentials?: GitHubWorkflowProfileOidcCredentials;

  /**
   * The Azure Kubernetes Cluster Resource the application will be deployed to.
   */
  @summary("The Azure Kubernetes Managed Cluster resource.")
  aksResourceId?: string;

  /**
   * The URL to the Pull Request submitted against the users repository.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  prURL?: string;

  /**
   * The number associated with the submitted pull request.
   */
  @visibility(Lifecycle.Read)
  pullNumber?: int32;

  /**
   * The status of the Pull Request submitted against the users repository.
   */
  @visibility(Lifecycle.Read)
  prStatus?: PullRequestStatus;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastWorkflowRun?: WorkflowRun;

  /**
   * Determines the authorization status of requests.
   */
  @visibility(Lifecycle.Read)
  authStatus?: AuthorizationStatus;
}

/**
 * Deployment details of the repository associated with the workflow.
 */
model Deployment {
  /**
   * Determines the type of manifests within the repository.
   */
  manifestType?: ManifestType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kubeManifestLocations?: string[];

  /**
   * Helm chart directory path in repository.
   */
  helmChartPath?: string;

  /**
   * Helm Values.yaml file location in repository.
   */
  helmValues?: string;

  /**
   * Manifest override values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Manifest override values.")
  overrides?: Record<string>;
}

/**
 * Information on the azure container registry
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ACR {
  /**
   * ACR subscription id
   */
  acrSubscriptionId?: string;

  /**
   * ACR resource group
   */
  acrResourceGroup?: string;

  /**
   * ACR registry
   */
  acrRegistryName?: string;

  /**
   * ACR repository
   */
  acrRepositoryName?: string;
}

/**
 * The fields needed for OIDC with GitHub.
 */
model GitHubWorkflowProfileOidcCredentials {
  /**
   * Azure Application Client ID
   */
  azureClientId?: string;

  /**
   * Azure Directory (tenant) ID
   */
  azureTenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WorkflowRun {
  /**
   * Describes if the workflow run succeeded.
   */
  @visibility(Lifecycle.Read)
  succeeded?: boolean;

  /**
   * URL to the run of the workflow.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  workflowRunURL?: string;

  /**
   * The timestamp of the last workflow run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRunAt?: utcDateTime;

  /**
   * Describes the status of the workflow run
   */
  @visibility(Lifecycle.Read)
  workflowRunStatus?: WorkflowRunStatus;
}

/**
 * Properties used for generating artifacts such as Dockerfiles and manifests.
 */
@summary("Artifact Generation Properties")
model ArtifactGenerationProperties {
  /**
   * The programming language used.
   */
  generationLanguage?: GenerationLanguage;

  /**
   * The version of the language image used for execution in the generated dockerfile.
   */
  languageVersion?: string;

  /**
   * The version of the language image used for building the code in the generated dockerfile.
   */
  builderVersion?: string;

  /**
   * The port the application is exposed on.
   */
  port?: string;

  /**
   * The name of the app.
   */
  appName?: string;

  /**
   * The directory to output the generated Dockerfile to.
   */
  dockerfileOutputDirectory?: string;

  /**
   * The directory to output the generated manifests to.
   */
  manifestOutputDirectory?: string;

  /**
   * The mode of generation to be used for generating Dockerfiles.
   */
  dockerfileGenerationMode?: DockerfileGenerationMode;

  /**
   * The mode of generation to be used for generating Manifest.
   */
  manifestGenerationMode?: ManifestGenerationMode;

  /**
   * Determines the type of manifests to be generated.
   */
  manifestType?: GenerationManifestType;

  /**
   * The name of the image to be generated.
   */
  imageName?: string;

  /**
   * The namespace to deploy the application to.
   */
  `namespace`?: string;

  /**
   * The tag to apply to the generated image.
   */
  imageTag?: string;
}

/**
 * Azure Pipeline Profile
 */
model AzurePipelineProfile {
  /**
   * Details of the ADO repository associated with the workflow.
   */
  repository?: ADORepository;

  /**
   * The name of the ARM Service Connection the pipeline is associated with.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  armServiceConnection?: string;

  /**
   * Build details of the repository associated with the workflow.
   */
  build?: Build;

  /**
   * Deployment details of the repository associated with the workflow.
   */
  deployment?: Deployment;

  /**
   * Kubernetes namespace the application is deployed to.
   */
  `namespace`?: string;

  /**
   * Resource identifier for azure container registry repository associated with the workflow.
   */
  acr?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerRegistry/registries";
    }
  ]>;

  /**
   * The Azure Kubernetes Cluster Resource the application will be deployed to.
   */
  clusterId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    }
  ]>;

  /**
   * Details of the pull request containing the workflow.
   */
  pullRequest?: PullRequest;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastWorkflowRun?: WorkflowRun;

  /**
   * Determines the authorization status of requests.
   */
  @visibility(Lifecycle.Read)
  authStatus?: AuthorizationStatus;
}

/**
 * Details of the ADO repository associated with the workflow.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ADORepository {
  /**
   * The owner of the repository the workflow is associated with.
   */
  repositoryOwner?: string;

  /**
   * The name of the repository the workflow is associated with.
   */
  repositoryName?: string;

  /**
   * The name of the branch the workflow is associated with.
   */
  branchName?: string;

  /**
   * The name of the Azure DevOps organization the pipeline is associated with.
   */
  adoOrganization?: string;

  /**
   * The name of the project the pipeline is associated with.
   */
  projectName?: string;
}

/**
 * Build details of the repository associated with the workflow.
 */
model Build {
  /**
   * Path to the Dockerfile within the repository.
   */
  dockerfile?: string;

  /**
   * Path to Dockerfile Build Context within the repository.
   */
  dockerBuildContext?: string;
}

/**
 * Details of the pull request containing the workflow.
 */
model PullRequest {
  /**
   * The URL to the Pull Request submitted against the users repository.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  prURL?: string;

  /**
   * The number associated with the submitted pull request.
   */
  @visibility(Lifecycle.Read)
  pullNumber?: int32;

  /**
   * The status of the Pull Request submitted against the users repository.
   */
  @visibility(Lifecycle.Read)
  prStatus?: PullRequestStatus;
}

/**
 * Template Workflow Profile
 */
model TemplateWorkflowProfile {
  /**
   * The status of the Pull Request submitted against the users repository.
   */
  repositoryProvider?: RepositoryProviderType;

  /**
   * The properties of ADO OAuth.
   */
  workflowTemplate?: TemplateReference;

  /**
   * The properties of ADO OAuth.
   */
  deploymentTemplate?: TemplateReference;

  /**
   * The properties of ADO OAuth.
   */
  dockerfileTemplate?: TemplateReference;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  manifestTemplates?: TemplateReference[];

  /**
   * Details of the GitHub repository and credentials associated with the workflow.
   */
  gitHubProviderProfile?: GitHubProviderProfile;

  /**
   * Details of the GitHub repository associated with the workflow.
   */
  adoProviderProfile?: ADOProviderProfile;

  /**
   * Details of the pull request containing the workflow.
   */
  pullRequest?: PullRequest;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  lastWorkflowRun?: WorkflowRun;

  /**
   * Determines the authorization status of requests.
   */
  @visibility(Lifecycle.Read)
  authStatus?: AuthorizationStatus;
}

/**
 * The properties of ADO OAuth.
 */
model TemplateReference {
  /**
   * The versioned template arm resource id.
   */
  templateId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DevHub/templates/versions";
    }
  ]>;

  /**
   * destination for template creation
   */
  destination?: string;

  /**
   * parameters for template creation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;
}

/**
 * Details of the GitHub repository and credentials associated with the workflow.
 */
model GitHubProviderProfile {
  /**
   * Details of the GitHub repository associated with the workflow.
   */
  repository?: GitHubRepository;

  /**
   * The fields needed for OIDC with GitHub.
   */
  oidcCredentials?: OidcCredentials;
}

/**
 * Details of the GitHub repository associated with the workflow.
 */
model GitHubRepository {
  /**
   * The owner of the repository the workflow is associated with.
   */
  repositoryOwner?: string;

  /**
   * The name of the repository the workflow is associated with.
   */
  repositoryName?: string;

  /**
   * The name of the branch the workflow is associated with.
   */
  branchName?: string;
}

/**
 * The fields needed for OIDC with GitHub.
 */
model OidcCredentials {
  /**
   * Azure Application Client ID
   */
  azureClientId?: string;

  /**
   * Azure Directory (tenant) ID
   */
  azureTenantId?: string;
}

/**
 * Details of the GitHub repository associated with the workflow.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ADOProviderProfile {
  /**
   * Details of the ADO repository associated with the workflow.
   */
  repository?: ADORepository;

  /**
   * The name of the ARM Service Connection the pipeline is associated with.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  armServiceConnection?: string;
}

/**
 * delete response if content must be provided on delete operation
 */
model DeleteWorkflowResponse {
  /**
   * delete status message
   */
  status?: string;
}

/**
 * ADOOAuth request object
 */
model AdooAuthCallRequest {
  /**
   * The URL the client will redirect to on successful authentication. If empty, no redirect will occur.
   */
  redirectUrl?: string;
}

/**
 * Response containing ADO OAuth information
 */
model AdooAuthInfoResponse {
  /**
   * URL used to authorize ADO app using Entra ID
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  authURL?: string;

  /**
   * OAuth token used to make calls to ADO APIs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  token?: string;
}

/**
 * The properties of ADO OAuth.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ADOOAuth {
  /**
   * user making request
   */
  username?: string;
}

/**
 * The response from List ADOOAuth operation.
 */
model AdooAuthListResponse is Azure.Core.Page<AdooAuthResponse>;

/**
 * Template properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TemplateProperties {
  /**
   * The name of the template.
   */
  @summary("Template Name")
  templateName?: string;

  /**
   * The default version of the template.
   */
  @summary("Template Default Version")
  defaultVersion?: string;

  /**
   * The valid versions of the template.
   */
  @summary("Template Versions")
  versions?: string[];

  /**
   * Description of the template
   */
  @summary("Template Description")
  description?: string;

  /**
   * The type of the template.
   */
  @visibility(Lifecycle.Read)
  templateType?: TemplateType;
}

/**
 * VersionedTemplate properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VersionedTemplateProperties {
  /**
   * The version of the template.
   */
  @summary("Template Version")
  version?: string;

  /**
   * The type of the template.
   */
  @visibility(Lifecycle.Read)
  templateType?: TemplateType;

  /**
   * The template parameters.
   */
  @summary("Template Parameters")
  parameters?: Parameter[];
}

/**
 * Parameter for the template.
 */
model Parameter {
  /**
   * The paramater name.
   */
  @summary("Parameter name")
  name?: string;

  /**
   * Description of what the paramater is used for.
   */
  @summary("Parameter description")
  description?: string;

  /**
   * The type of the template parameter.
   */
  @visibility(Lifecycle.Read)
  parameterType?: ParameterType;

  /**
   * The type of the template parameter.
   */
  @visibility(Lifecycle.Read)
  parameterKind?: ParameterKind;

  /**
   * Whether the parameter is required.
   */
  @summary("Parameter required")
  required?: boolean;

  /**
   * A reference to a default parameter value or a reference parameter to take the value from.
   */
  default?: ParameterDefault;
}

/**
 * A reference to a default parameter value or a reference parameter to take the value from.
 */
model ParameterDefault {
  /**
   * The default value for this parameter.
   */
  @summary("ParameterDefault value")
  value?: string;

  /**
   * The Parameter to reference a value from.
   */
  @summary("ParameterDefault Reference Parameter")
  referenceParameter?: string;
}

/**
 * Generated template files returned as a map<path string,content string>
 */
model GenerateVersionedTemplateResponse {
  /**
   * files returned as a map<path string,content string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  generatedFiles?: Record<string>;
}
