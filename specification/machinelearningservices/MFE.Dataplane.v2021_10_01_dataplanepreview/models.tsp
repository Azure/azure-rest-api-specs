import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningServices;

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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ListViewType {
  string,

  /**
   * ActiveOnly
   */
  ActiveOnly: "ActiveOnly",

  /**
   * ArchivedOnly
   */
  ArchivedOnly: "ArchivedOnly",

  /**
   * All
   */
  All: "All",
}

/**
 * Enum to determine the type of data.
 */
union DataType {
  string,

  /**
   * uri_file
   */
  uri_file: "uri_file",

  /**
   * uri_folder
   */
  uri_folder: "uri_folder",

  /**
   * mltable
   */
  mltable: "mltable",
}

/**
 * Protection level associated with the Intellectual Property.
 */
union ProtectionLevel {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * None
   */
  None: "None",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DataReferenceCredentialType {
  string,

  /**
   * SAS
   */
  SAS: "SAS",

  /**
   * DockerCredentials
   */
  DockerCredentials: "DockerCredentials",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * NoCredentials
   */
  NoCredentials: "NoCredentials",
}

/**
 * Environment type is either user created or curated by Azure ML service
 */
union EnvironmentType {
  string,

  /**
   * Curated
   */
  Curated: "Curated",

  /**
   * UserCreated
   */
  UserCreated: "UserCreated",
}

/**
 * The type of operating system.
 */
union OperatingSystemType {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

/**
 * Enum to determine which reference method to use for an asset.
 */
union ReferenceType {
  string,

  /**
   * Id
   */
  Id: "Id",

  /**
   * DataPath
   */
  DataPath: "DataPath",

  /**
   * OutputPath
   */
  OutputPath: "OutputPath",
}

/**
 * Base environment type.
 */
union BaseEnvironmentSourceType {
  string,

  /**
   * EnvironmentAsset
   */
  EnvironmentAsset: "EnvironmentAsset",
}

/**
 * Inferencing server type for various targets.
 */
union InferencingServerType {
  string,

  /**
   * AzureMLOnline
   */
  AzureMLOnline: "AzureMLOnline",

  /**
   * AzureMLBatch
   */
  AzureMLBatch: "AzureMLBatch",

  /**
   * Triton
   */
  Triton: "Triton",

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * Type of the inputs.
 */
union PackageInputType {
  string,

  /**
   * UriFile
   */
  UriFile: "UriFile",

  /**
   * UriFolder
   */
  UriFolder: "UriFolder",
}

/**
 * Mounting type of the model or the inputs
 */
union PackageInputDeliveryMode {
  string,

  /**
   * Copy
   */
  Copy: "Copy",

  /**
   * Download
   */
  Download: "Download",
}

/**
 * Input path type for package inputs.
 */
union InputPathType {
  string,

  /**
   * Url
   */
  Url: "Url",

  /**
   * PathId
   */
  PathId: "PathId",

  /**
   * PathVersion
   */
  PathVersion: "PathVersion",
}

/**
 * Package build state returned in package response.
 */
union PackageBuildState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Enum to determine the datastore secrets type.
 */
union SecretsType {
  string,

  /**
   * AccountKey
   */
  AccountKey: "AccountKey",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * Sas
   */
  Sas: "Sas",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",
}

/**
 * Enum to determine the datastore credentials type.
 */
union CredentialsType {
  string,

  /**
   * AccountKey
   */
  AccountKey: "AccountKey",

  /**
   * Certificate
   */
  Certificate: "Certificate",

  /**
   * None
   */
  None: "None",

  /**
   * Sas
   */
  Sas: "Sas",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",
}

/**
 * Enum to determine identity framework.
 */
union IdentityConfigurationType {
  string,

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * AMLToken
   */
  AMLToken: "AMLToken",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ServiceDataAccessAuthIdentity {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * WorkspaceSystemAssignedIdentity
   */
  WorkspaceSystemAssignedIdentity: "WorkspaceSystemAssignedIdentity",

  /**
   * WorkspaceUserAssignedIdentity
   */
  WorkspaceUserAssignedIdentity: "WorkspaceUserAssignedIdentity",
}

/**
 * Enum to determine the datastore contents type.
 */
union DatastoreType {
  string,

  /**
   * AzureBlob
   */
  AzureBlob: "AzureBlob",

  /**
   * AzureDataLakeGen1
   */
  AzureDataLakeGen1: "AzureDataLakeGen1",

  /**
   * AzureDataLakeGen2
   */
  AzureDataLakeGen2: "AzureDataLakeGen2",

  /**
   * AzureFile
   */
  AzureFile: "AzureFile",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EarlyTerminationPolicyType {
  string,

  /**
   * Bandit
   */
  Bandit: "Bandit",

  /**
   * MedianStopping
   */
  MedianStopping: "MedianStopping",

  /**
   * TruncationSelection
   */
  TruncationSelection: "TruncationSelection",
}

/**
 * Different Binding types
 */
union BindingType {
  string,

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Enum to determine the job distribution type.
 */
union DistributionType {
  string,

  /**
   * PyTorch
   */
  PyTorch: "PyTorch",

  /**
   * TensorFlow
   */
  TensorFlow: "TensorFlow",

  /**
   * Mpi
   */
  Mpi: "Mpi",
}

/**
 * Enum to determine the Job Input Type.
 */
union JobInputType {
  string,

  /**
   * Dataset
   */
  Dataset: "Dataset",

  /**
   * Uri
   */
  Uri: "Uri",

  /**
   * Literal
   */
  Literal: "Literal",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union JobLimitsType {
  string,

  /**
   * Command
   */
  Command: "Command",

  /**
   * Sweep
   */
  Sweep: "Sweep",
}

/**
 * Enum to determine the Job Output Type.
 */
union JobOutputType {
  string,

  /**
   * Uri
   */
  Uri: "Uri",

  /**
   * Dataset
   */
  Dataset: "Dataset",
}

/**
 * Enum to determine the type of job.
 */
union JobType {
  string,

  /**
   * Command
   */
  Command: "Command",

  /**
   * Sweep
   */
  Sweep: "Sweep",

  /**
   * Pipeline
   */
  Pipeline: "Pipeline",

  /**
   * Base
   */
  Base: "Base",
}

/**
 * The status of a job.
 */
union JobStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Starting
   */
  Starting: "Starting",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Preparing
   */
  Preparing: "Preparing",

  /**
   * Queued
   */
  Queued: "Queued",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Finalizing
   */
  Finalizing: "Finalizing",

  /**
   * CancelRequested
   */
  CancelRequested: "CancelRequested",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * NotResponding
   */
  NotResponding: "NotResponding",

  /**
   * Paused
   */
  Paused: "Paused",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Enum to determine the input data delivery mode.
 */
union InputDataDeliveryMode {
  string,

  /**
   * ReadOnlyMount
   */
  ReadOnlyMount: "ReadOnlyMount",

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Download
   */
  Download: "Download",
}

/**
 * Output data delivery mode enums.
 */
union OutputDataDeliveryMode {
  string,

  /**
   * ReadWriteMount
   */
  ReadWriteMount: "ReadWriteMount",

  /**
   * Upload
   */
  Upload: "Upload",
}

/**
 * Defines supported metric goals for hyperparameter tuning
 */
union Goal {
  string,

  /**
   * Minimize
   */
  Minimize: "Minimize",

  /**
   * Maximize
   */
  Maximize: "Maximize",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SamplingAlgorithm {
  string,

  /**
   * Grid
   */
  Grid: "Grid",

  /**
   * Random
   */
  Random: "Random",

  /**
   * Bayesian
   */
  Bayesian: "Bayesian",
}

/**
 * A paginated list of CodeContainer entities.
 */
model CodeContainerResourceArmPaginatedResult
  is Azure.Core.Page<CodeContainerData>;

/**
 * Container for code asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CodeContainerDetails extends AssetContainer {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AssetContainer extends ResourceBase {
  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;

  /**
   * The latest version inside this container.
   */
  @visibility(Lifecycle.Read)
  latestVersion?: string;

  /**
   * The next auto incremental version
   */
  @visibility(Lifecycle.Read)
  nextVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceBase {
  /**
   * The asset description text.
   */
  description?: string;

  /**
   * The asset property dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * A paginated list of CodeVersion entities.
 */
model CodeVersionResourceArmPaginatedResult is Azure.Core.Page<CodeVersionData>;

/**
 * Code asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CodeVersionDetails extends AssetBase {
  /**
   * Uri where code is located
   */
  codeUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AssetBase extends ResourceBase {
  /**
   * If the name version are system generated (anonymous registration).
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isAnonymous?: boolean;

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;
}

/**
 * A paginated list of ComponentContainer entities.
 */
model ComponentContainerResourceArmPaginatedResult
  is Azure.Core.Page<ComponentContainerData>;

/**
 * Component container definition.
 * <see href="https://learn.microsoft.com/azure/machine-learning/reference-yaml-component-command" />
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ComponentContainerDetails extends AssetContainer {}

/**
 * A paginated list of ComponentVersion entities.
 */
model ComponentVersionResourceArmPaginatedResult
  is Azure.Core.Page<ComponentVersionData>;

/**
 * Definition of a component version: defines resources that span component types.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ComponentVersionDetails extends AssetBase {
  /**
   * Defines Component definition details.
   * <see href="https://learn.microsoft.com/azure/machine-learning/reference-yaml-component-command" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentSpec?: unknown;
}

/**
 * A paginated list of DataContainer entities.
 */
model DataContainerResourceArmPaginatedResult
  is Azure.Core.Page<DataContainerData>;

/**
 * Container for data asset versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataContainerDetails extends AssetContainer {
  /**
   * Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;
}

/**
 * A paginated list of DataVersionBase entities.
 */
model DataVersionBaseResourceArmPaginatedResult
  is Azure.Core.Page<DataVersionBaseData>;

/**
 * Data version base definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("dataType")
model DataVersionBaseDetails extends AssetBase {
  /**
   * Specifies the type of data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataType: DataType;

  /**
   * Uri of the data. Usage/meaning depends on Microsoft.MachineLearning.ManagementFrontEnd.Contracts.V20211001Dataplane.Assets.DataVersionBase.DataType
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  dataUri: string;

  /**
   * Intellectual Property details. Used if data is an Intellectual Property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  intellectualProperty?: IntellectualProperty;
}

/**
 * Intellectual Property details for a resource.
 */
model IntellectualProperty {
  /**
   * Protection level of the Intellectual Property.
   */
  protectionLevel?: ProtectionLevel;

  /**
   * Publisher of the Intellectual Property. Must be the same as Registry publisher name.
   */
  @pattern("[a-zA-Z0-9_]")
  publisher: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model BlobReferenceSASRequestDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  assetId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  blobUri?: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model BlobReferenceSASResponseDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  blobReferenceForConsumption?: BlobReferenceForConsumptionDto;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model BlobReferenceForConsumptionDto {
  /**
   * https://blob.windows.core.net/Container/Path
   */
  blobUri?: url;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credential?: DataReferenceCredentialDto;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  storageAccountArmId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("credentialType")
model DataReferenceCredentialDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credentialType: DataReferenceCredentialType;
}

/**
 * A paginated list of EnvironmentContainer entities.
 */
model EnvironmentContainerResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentContainerData>;

/**
 * Container for environment specification versions.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model EnvironmentContainerDetails extends AssetContainer {}

/**
 * A paginated list of EnvironmentVersion entities.
 */
model EnvironmentVersionResourceArmPaginatedResult
  is Azure.Core.Page<EnvironmentVersionData>;

/**
 * Environment version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model EnvironmentVersionDetails extends AssetBase {
  /**
   * Configuration settings for Docker build context.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  build?: BuildContext;

  /**
   * Standard configuration file used by Conda that lets you install any kind of package, including Python, R, and C/C++ packages.
   * <see href="https://repo2docker.readthedocs.io/en/latest/config_files.html#environment-yml-install-a-conda-environment" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  condaFile?: string;

  /**
   * Environment type is either user managed or curated by the Azure ML service
   * <see href="https://learn.microsoft.com/azure/machine-learning/resource-curated-environments" />
   */
  @visibility(Lifecycle.Read)
  environmentType?: EnvironmentType;

  /**
   * Name of the image that will be used for the environment.
   * <seealso href="https://learn.microsoft.com/azure/machine-learning/how-to-deploy-custom-docker-image#use-a-custom-base-image" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  image?: string;

  /**
   * Defines configuration specific to inference.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inferenceConfig?: InferenceContainerProperties;

  /**
   * Intellectual Property details. Used if environment is an Intellectual Property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  intellectualProperty?: IntellectualProperty;

  /**
   * The OS type of the environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  osType?: OperatingSystemType;

  /**
   * Stage in the environment lifecycle assigned to this environment
   */
  stage?: string;
}

/**
 * Configuration settings for Docker build context
 */
model BuildContext {
  /**
   * URI of the Docker build context used to build the image. Supports blob URIs on environment creation and may return blob or Git URIs.
   * <seealso href="https://docs.docker.com/engine/reference/commandline/build/#extended-description" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  contextUri: string;

  /**
   * Path to the Dockerfile in the build context.
   * <seealso href="https://docs.docker.com/engine/reference/builder/" />
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerfilePath?: string = "Dockerfile";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model InferenceContainerProperties {
  /**
   * The route to check the liveness of the inference server container.
   */
  livenessRoute?: Route;

  /**
   * The route to check the readiness of the inference server container.
   */
  readinessRoute?: Route;

  /**
   * The port to send the scoring requests to, within the inference server container.
   */
  scoringRoute?: Route;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Route {
  /**
   * The path for the route.
   */
  @pattern("[a-zA-Z0-9_]")
  path: string;

  /**
   * The port for the route.
   */
  port: int32;
}

/**
 * Azure Resource Manager resource envelope.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceManagementAssetReferenceData
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Additional attributes of the entity.
   */
  properties: ResourceManagementAssetReferenceDetails;
}

/**
 * Resource Management asset reference.
 */
model ResourceManagementAssetReferenceDetails extends AssetReferenceBase {
  /**
   * Destination asset name for import
   */
  destinationName?: string;

  /**
   * Destination asset version for import
   */
  destinationVersion?: string;

  /**
   * ARM resource ID of the source asset.
   */
  sourceAssetId: string;

  /**
   * Specifies the type of asset reference.
   */
  referenceType: "ResourceManagementId";
}

/**
 * Base definition for asset references.
 */
@discriminator("referenceType")
model AssetReferenceBase {
  /**
   * Specifies the type of asset reference.
   */
  referenceType: ReferenceType;
}

/**
 * A paginated list of ModelContainer entities.
 */
model ModelContainerResourceArmPaginatedResult
  is Azure.Core.Page<ModelContainerData>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ModelContainerDetails extends AssetContainer {}

/**
 * A paginated list of ModelVersion entities.
 */
model ModelVersionResourceArmPaginatedResult
  is Azure.Core.Page<ModelVersionData>;

/**
 * Model asset version details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ModelVersionDetails extends AssetBase {
  /**
   * Mapping of model flavors to their properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  flavors?: Record<FlavorData>;

  /**
   * Intellectual Property details. Used if model is an Intellectual Property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  intellectualProperty?: IntellectualProperty;

  /**
   * Name of the training job which produced this model
   */
  jobName?: string;

  /**
   * The storage format for this entity. Used for NCD.
   */
  modelType?: string;

  /**
   * The URI path to the model contents.
   */
  modelUri?: string;

  /**
   * AssetId of origin model.
   */
  originAssetId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  defaultDeploymentTemplate?: ModelVersionDefaultDeploymentTemplate;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FlavorData {
  /**
   * Model flavor-specific data.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  data?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ModelVersionDefaultDeploymentTemplate {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  assetId?: string;
}

/**
 * Model package operation request properties.
 */
model PackageRequest {
  /**
   * Base environment to start with.
   */
  baseEnvironmentSource?: BaseEnvironmentSource;

  /**
   * Collection of environment variables.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  environmentVariables?: Record<string>;

  /**
   * Inferencing server configurations.
   */
  inferencingServer: InferencingServer;

  /**
   * Collection of inputs.
   */
  inputs?: ModelPackageInput[];

  /**
   * Model configuration including the mount mode.
   */
  modelConfiguration?: ModelConfiguration;

  /**
   * Properties dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * The sku architecture type.
   */
  skuArchitectureType?: string;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Arm ID of the target environment to be created by package operation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  targetEnvironmentId: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("baseEnvironmentSourceType")
model BaseEnvironmentSource {
  /**
   * Base environment type.
   */
  baseEnvironmentSourceType: BaseEnvironmentSourceType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("serverType")
model InferencingServer {
  /**
   * Inferencing server type for various targets.
   */
  serverType: InferencingServerType;
}

/**
 * Model package input options.
 */
model ModelPackageInput {
  /**
   * Type of the input included in the target image.
   */
  inputType: PackageInputType;

  /**
   * Input delivery mode of the input.
   */
  mode?: PackageInputDeliveryMode;

  /**
   * Relative mount path of the input in the target image.
   */
  mountPath?: string;

  /**
   * Location of the input.
   */
  path: PackageInputPathBase;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("inputPathType")
model PackageInputPathBase {
  /**
   * Input path type for package inputs.
   */
  inputPathType: InputPathType;
}

/**
 * Model configuration options.
 */
model ModelConfiguration {
  /**
   * Input delivery mode for the model.
   */
  mode?: PackageInputDeliveryMode;

  /**
   * Relative mounting path of the model in the target image.
   */
  mountPath?: string;
}

/**
 * Package response returned after async package operation completes successfully.
 */
model PackageResponse {
  /**
   * Base environment to start with.
   */
  @visibility(Lifecycle.Read)
  baseEnvironmentSource?: BaseEnvironmentSource;

  /**
   * Build id of the image build operation.
   */
  @visibility(Lifecycle.Read)
  buildId?: string;

  /**
   * Build state of the image build operation.
   */
  @visibility(Lifecycle.Read)
  buildState?: PackageBuildState;

  /**
   * Collection of environment variables.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  environmentVariables?: Record<string>;

  /**
   * Inferencing server configurations.
   */
  @visibility(Lifecycle.Read)
  inferencingServer?: InferencingServer;

  /**
   * Collection of inputs.
   */
  @visibility(Lifecycle.Read)
  inputs?: ModelPackageInput[];

  /**
   * Log url of the image build operation.
   */
  @visibility(Lifecycle.Read)
  logUrl?: string;

  /**
   * Model configuration including the mount mode.
   */
  @visibility(Lifecycle.Read)
  modelConfiguration?: ModelConfiguration;

  /**
   * Properties dictionary.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * The sku architecture type.
   */
  skuArchitectureType?: string;

  /**
   * Tag dictionary. Tags can be added, removed, and updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Asset ID of the target environment created by package operation.
   */
  @visibility(Lifecycle.Read)
  targetEnvironmentId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TemporaryDataReferenceRequestDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  assetId?: string;

  /**
   * If TemporaryDataReferenceId = null then random guid will be used.
   */
  temporaryDataReferenceId?: string;

  /**
   * Either TemporaryBlobReference or TemporaryImageReference
   */
  temporaryDataReferenceType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TemporaryDataReferenceResponseDto {
  /**
   * Container level read, write, list SAS
   */
  blobReferenceForConsumption?: BlobReferenceForConsumptionDto;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  imageReferenceForConsumption?: ImageReferenceForConsumptionDto;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  temporaryDataReferenceId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  temporaryDataReferenceType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ImageReferenceForConsumptionDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  acrDetails?: AcrDetail;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  credential?: DataReferenceCredentialDto;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  imageName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  imageRegistryReference?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AcrDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  acrAddress?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  acrName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  acrRegion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  armScope?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceGroupName?: string;

  #suppress "@azure-tools/typespec-azure-core/no-format"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @format("uuid")
  subscriptionId?: string;
}

/**
 * Account key datastore credentials configuration.
 */
model AccountKeyDatastoreCredentials extends DatastoreCredentials {
  /**
   * Storage account secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: AccountKeyDatastoreSecrets;

  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: "AccountKey";
}

/**
 * Datastore account key secrets.
 */
model AccountKeyDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage account key.
   */
  key?: string;

  /**
   * Credential type used to authentication with storage.
   */
  secretsType: "AccountKey";
}

/**
 * Base definition for datastore secrets.
 */
@discriminator("secretsType")
model DatastoreSecrets {
  /**
   * Credential type used to authentication with storage.
   */
  secretsType: SecretsType;
}

/**
 * Base definition for datastore credentials.
 */
@discriminator("credentialsType")
model DatastoreCredentials {
  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: CredentialsType;
}

/**
 * AML Token identity configuration.
 */
model AmlToken extends IdentityConfiguration {
  /**
   * Specifies the type of identity framework.
   */
  identityType: "AMLToken";
}

/**
 * Base definition for identity configuration.
 */
@discriminator("identityType")
model IdentityConfiguration {
  /**
   * Specifies the type of identity framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identityType: IdentityConfigurationType;
}

/**
 * Azure Blob datastore configuration.
 */
model AzureBlobDatastore extends Datastore {
  /**
   * Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountName?: string;

  /**
   * Storage account container name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  containerName?: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * Storage type backing the datastore.
   */
  datastoreType: "AzureBlob";
}

/**
 * Base definition for datastore contents configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("datastoreType")
model Datastore extends ResourceBase {
  /**
   * Account credentials.
   */
  credentials: DatastoreCredentials;

  /**
   * Storage type backing the datastore.
   */
  datastoreType: DatastoreType;

  /**
   * Readonly property to indicate if datastore is the workspace default datastore
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * Azure Data Lake Gen1 datastore configuration.
 */
model AzureDataLakeGen1Datastore extends Datastore {
  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * Azure Data Lake store name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  storeName: string;

  /**
   * Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen1";
}

/**
 * Azure Data Lake Gen2 datastore configuration.
 */
model AzureDataLakeGen2Datastore extends Datastore {
  /**
   * Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * The name of the Data Lake Gen2 filesystem.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  filesystem: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * Storage type backing the datastore.
   */
  datastoreType: "AzureDataLakeGen2";
}

/**
 * Azure File datastore configuration.
 */
model AzureFileDatastore extends Datastore {
  /**
   * Storage account name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  accountName: string;

  /**
   * Azure cloud endpoint for the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * TODO - File share name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  fileShareName: string;

  /**
   * Protocol used to communicate with the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  protocol?: string;

  /**
   * Indicates which identity to use to authenticate service data access to customer's storage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceDataAccessAuthIdentity?: ServiceDataAccessAuthIdentity;

  /**
   * Storage type backing the datastore.
   */
  datastoreType: "AzureFile";
}

/**
 * Azure ML batch inferencing server configurations.
 */
model AzureMLBatchInferencingServer extends InferencingServer {
  /**
   * Code configuration for AML batch inferencing server.
   */
  codeConfiguration?: CodeConfiguration;

  /**
   * Inferencing server type for various targets.
   */
  serverType: "AzureMLBatch";
}

/**
 * Configuration for a scoring code asset.
 */
model CodeConfiguration {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * The script to execute on startup. eg. "score.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  scoringScript: string;
}

/**
 * Azure ML online inferencing configurations.
 */
model AzureMLOnlineInferencingServer extends InferencingServer {
  /**
   * Code configuration for AML inferencing server.
   */
  codeConfiguration?: CodeConfiguration;

  /**
   * Inferencing server type for various targets.
   */
  serverType: "AzureMLOnline";
}

/**
 * Defines an early termination policy based on slack criteria, and a frequency and delay interval for evaluation
 */
model BanditPolicy extends EarlyTerminationPolicy {
  /**
   * Absolute distance allowed from the best performing run.
   */
  slackAmount?: float32;

  /**
   * Ratio of the allowed distance from the best performing run.
   */
  slackFactor?: float32;

  /**
   * Name of policy configuration
   */
  policyType: "Bandit";
}

/**
 * Early termination policies enable canceling poor-performing runs before they complete
 */
@discriminator("policyType")
model EarlyTerminationPolicy {
  /**
   * Number of intervals by which to delay the first evaluation.
   */
  delayEvaluation?: int32;

  /**
   * Interval (number of runs) between policy evaluations.
   */
  evaluationInterval?: int32;

  /**
   * Name of policy configuration
   */
  policyType: EarlyTerminationPolicyType;
}

/**
 * Base environment type.
 */
model BaseEnvironmentId extends BaseEnvironmentSource {
  /**
   * Resource id accepting ArmId or AzureMlId.
   */
  @pattern("[a-zA-Z0-9_]")
  resourceId: string;

  /**
   * Base environment type.
   */
  baseEnvironmentSourceType: "EnvironmentAsset";
}

/**
 * Basic binding with simple source and destination
 */
model BasicBinding extends Binding {
  /**
   * Destination reference
   */
  destination?: string;

  /**
   * Source reference
   */
  source?: string;

  /**
   * Type of Binding
   */
  bindingType: "Basic";
}

/**
 * Binding Inputs/Outputs to ComponentJob Inputs/Outputs etc
 */
@discriminator("bindingType")
model Binding {
  /**
   * Type of Binding
   */
  bindingType: BindingType;
}

/**
 * Certificate datastore credentials configuration.
 */
model CertificateDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  authorityUrl?: string;

  /**
   * Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * Service principal secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: CertificateDatastoreSecrets;

  /**
   * ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId: string;

  /**
   * Thumbprint of the certificate used for authentication.
   */
  @pattern("[a-zA-Z0-9_]")
  thumbprint: string;

  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: "Certificate";
}

/**
 * Datastore certificate secrets.
 */
model CertificateDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal certificate.
   */
  certificate?: string;

  /**
   * Credential type used to authentication with storage.
   */
  secretsType: "Certificate";
}

/**
 * Command job definition.
 */
model CommandJob extends JobBase {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration;

  /**
   * The ARM resource ID of the Environment specification for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string>;

  /**
   * Identity configuration. If set, this should be one of AmlToken, ManagedIdentity, or null.
   * Defaults to AmlToken if null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: IdentityConfiguration;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Command Job limit.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: CommandJobLimits;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Input parameters.
   */
  @visibility(Lifecycle.Read)
  parameters?: unknown;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: ResourceConfiguration;

  /**
   * Specifies the type of job.
   */
  jobType: "Command";
}

/**
 * Base definition for job distribution configuration.
 */
@discriminator("distributionType")
model DistributionConfiguration {
  /**
   * Specifies the type of distribution framework.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distributionType: DistributionType;
}

/**
 * Command job definition.
 */
@discriminator("jobInputType")
model JobInput {
  /**
   * Description for the input.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobInputType: JobInputType;
}

/**
 * Command Job limit class.
 */
model CommandJobLimits extends JobLimits {
  /**
   * JobLimit type.
   */
  jobLimitsType: "Command";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@discriminator("jobLimitsType")
model JobLimits {
  /**
   * JobLimit type.
   */
  jobLimitsType: JobLimitsType;

  /**
   * The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.
   */
  timeout?: duration;
}

/**
 * Job output definition container information on where to find job output/logs.
 */
@discriminator("jobOutputType")
model JobOutput {
  /**
   * Description for the output.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  description?: string;

  /**
   * Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobOutputType: JobOutputType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceConfiguration {
  /**
   * Optional number of instances or nodes used by the compute target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceCount?: int32 = 1;

  /**
   * Optional type of VM used as supported by the compute target.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  instanceType?: string;

  /**
   * Additional properties bag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: Record<unknown>;
}

/**
 * Base definition for a job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("jobType")
model JobBase extends ResourceBase {
  /**
   * ARM resource ID of the compute resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeId?: string;

  /**
   * Display name of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName?: string;

  /**
   * The name of the experiment the job belongs to. If not set, the job is placed in the "Default" experiment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  experimentName?: string = "Default";

  /**
   * Is the asset archived?
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  isArchived?: boolean;

  /**
   * Specifies the type of job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobType: JobType;

  /**
   * TODO - Parent job name.
   */
  @visibility(Lifecycle.Read)
  parentJobName?: string;

  /**
   * List of JobEndpoints.
   * For local jobs, a job endpoint will have an endpoint value of FileStreamObject.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  services?: Record<JobService>;

  /**
   * Status of the job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;
}

/**
 * Job endpoint definition
 */
model JobService {
  /**
   * Url for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * Any error in the service.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Endpoint type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobServiceType?: string;

  /**
   * Port for endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  port?: int32;

  /**
   * Additional properties to set on the endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Status of endpoint.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Definition of a ComponentJob.
 */
model ComponentJob {
  /**
   * Reference to component artifact.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentId?: string;

  /**
   * ARM resource ID of the compute resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  computeId?: string;

  /**
   * Data input set for job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Data output set for job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Override component default settings
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  overrides?: unknown;
}

/**
 * Custom inference server configurations.
 */
model CustomInferencingServer extends InferencingServer {
  /**
   * Inference configuration for custom inferencing.
   */
  inferenceConfiguration?: OnlineInferenceConfiguration;

  /**
   * Inferencing server type for various targets.
   */
  serverType: "Custom";
}

/**
 * Online inference configuration options.
 */
model OnlineInferenceConfiguration {
  /**
   * Additional configurations
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  configurations?: Record<string>;

  /**
   * Entry script or command to invoke.
   */
  entryScript?: string;

  /**
   * The route to check the liveness of the inference server container.
   */
  livenessRoute?: Route;

  /**
   * The route to check the readiness of the inference server container.
   */
  readinessRoute?: Route;

  /**
   * The port to send the scoring requests to, within the inference server container.
   */
  scoringRoute?: Route;
}

/**
 * Reference to an asset via its path in a datastore.
 */
model DataPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the datastore where the asset is located.
   */
  datastoreId?: string;

  /**
   * The path of the file/directory in the datastore.
   */
  path?: string;

  /**
   * Specifies the type of asset reference.
   */
  referenceType: "DataPath";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DockerCredentialDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  password?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userName?: string;
}

/**
 * Reference to an asset via its ARM resource ID.
 */
model IdAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the asset.
   */
  @pattern("[a-zA-Z0-9_]")
  assetId: string;

  /**
   * Specifies the type of asset reference.
   */
  referenceType: "Id";
}

/**
 * Basic Job class with all job base properties.
 */
model Job extends JobBase {
  /**
   * Specifies the type of job.
   */
  jobType: "Base";
}

/**
 * InputDataset type.
 */
model JobInputDataset extends JobInput {
  /**
   * Dataset ARM Id for the input
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("[a-zA-Z0-9_]")
  datasetId: string;

  /**
   * Dataset Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: InputDataDeliveryMode;

  /**
   * Specifies the type of job.
   */
  jobInputType: "Dataset";
}

/**
 * Literal input type.
 */
model JobInputLiteral extends JobInput {
  /**
   * Literal value for the input.
   */
  value?: string;

  /**
   * Specifies the type of job.
   */
  jobInputType: "Literal";
}

/**
 * Input uri type.
 */
model JobInputUri extends JobInput {
  /**
   * Input Uri Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: InputDataDeliveryMode;

  /**
   * Uri path.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  uri: UriReference;

  /**
   * Specifies the type of job.
   */
  jobInputType: "Uri";
}

/**
 * TODO - UriReference.
 */
model UriReference {
  /**
   * Single file uri path
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  file?: string;

  /**
   * Folder uri path
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  folder?: string;
}

/**
 * Dataset output.
 */
model JobOutputDataset extends JobOutput {
  /**
   * Output Delivery Mode.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode?: OutputDataDeliveryMode;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "Dataset";
}

/**
 * Uri output.
 */
model JobOutputUri extends JobOutput {
  /**
   * Output Delivery Mode.
   */
  @visibility(Lifecycle.Read)
  mode?: OutputDataDeliveryMode;

  /**
   * Uri path.
   */
  @visibility(Lifecycle.Read)
  uri?: UriReference;

  /**
   * Specifies the type of job.
   */
  jobOutputType: "Uri";
}

/**
 * MLTable data definition
 */
model MLTableData extends DataVersionBaseDetails {
  /**
   * Uris referenced in the MLTable definition (required for lineage)
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  referencedUris?: string[];

  /**
   * Specifies the type of data.
   */
  dataType: "mltable";
}

/**
 * Managed identity configuration.
 */
model ManagedIdentity extends IdentityConfiguration {
  /**
   * Specifies a user-assigned identity by client ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  clientId?: string;

  /**
   * Specifies a user-assigned identity by object ID. For system-assigned, do not set this field.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  objectId?: string;

  /**
   * Specifies a user-assigned identity by ARM resource ID. For system-assigned, do not set this field.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId?: string;

  /**
   * Specifies the type of identity framework.
   */
  identityType: "Managed";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManagedIdentityCredentialDto {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  managedIdentityType?: string;

  /**
   * ClientId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityClientId?: string;

  /**
   * PrincipalId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityPrincipalId?: string;

  /**
   * Full arm scope for the Id. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityResourceId?: string;

  /**
   * TenantId for the UAMI. For ManagedIdentityType = SystemManaged, this field is null.
   */
  userManagedIdentityTenantId?: string;
}

/**
 * Defines an early termination policy based on running averages of the primary metric of all runs
 */
model MedianStoppingPolicy extends EarlyTerminationPolicy {
  /**
   * Name of policy configuration
   */
  policyType: "MedianStopping";
}

/**
 * MPI distribution configuration.
 */
model Mpi extends DistributionConfiguration {
  /**
   * Number of processes per MPI node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  processCountPerInstance?: int32;

  /**
   * Specifies the type of distribution framework.
   */
  distributionType: "Mpi";
}

/**
 * Empty/none datastore credentials.
 */
model NoneDatastoreCredentials extends DatastoreCredentials {
  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: "None";
}

/**
 * Optimization objective.
 */
model Objective {
  /**
   * Defines supported metric goals for hyperparameter tuning
   */
  goal: Goal;

  /**
   * Name of the metric to optimize.
   */
  @pattern("[a-zA-Z0-9_]")
  primaryMetric: string;
}

/**
 * Reference to an asset via its path in a job output.
 */
model OutputPathAssetReference extends AssetReferenceBase {
  /**
   * ARM resource ID of the job.
   */
  jobId?: string;

  /**
   * The path of the file/directory in the job output.
   */
  path?: string;

  /**
   * Specifies the type of asset reference.
   */
  referenceType: "OutputPath";
}

/**
 * Package input path specified with a resource id.
 */
model PackageInputPathId extends PackageInputPathBase {
  /**
   * Input resource id.
   */
  resourceId?: string;

  /**
   * Input path type for package inputs.
   */
  inputPathType: "PathId";
}

/**
 * Package input path specified as an url.
 */
model PackageInputPathUrl extends PackageInputPathBase {
  /**
   * Input path url.
   */
  url?: string;

  /**
   * Input path type for package inputs.
   */
  inputPathType: "Url";
}

/**
 * Package input path specified with name and version.
 */
model PackageInputPathVersion extends PackageInputPathBase {
  /**
   * Input resource name.
   */
  resourceName?: string;

  /**
   * Input resource version.
   */
  resourceVersion?: string;

  /**
   * Input path type for package inputs.
   */
  inputPathType: "PathVersion";
}

/**
 * Pipeline Job definition: defines generic to MFE attributes.
 */
model PipelineJob extends JobBase {
  /**
   * Binding to represent relation between inputs, outputs and parameters
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bindings?: Binding[];

  /**
   * JobDefinition set for PipelineStepJobs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  componentJobs?: Record<ComponentJob>;

  /**
   * Data input set for jobs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Data output set for jobs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Pipeline settings, for things like ContinueRunOnStepFailure etc.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  settings?: unknown;

  /**
   * Specifies the type of job.
   */
  jobType: "Pipeline";
}

/**
 * PyTorch distribution configuration.
 */
model PyTorch extends DistributionConfiguration {
  /**
   * Number of processes per node.
   */
  processCountPerInstance?: int32;

  /**
   * Specifies the type of distribution framework.
   */
  distributionType: "PyTorch";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SASCredentialDto {
  /**
   * Full SAS Uri, including the storage, container/blob path and SAS token
   */
  sasUri?: url;
}

/**
 * SAS datastore credentials configuration.
 */
model SasDatastoreCredentials extends DatastoreCredentials {
  /**
   * Storage container secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: SasDatastoreSecrets;

  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: "Sas";
}

/**
 * Datastore SAS secrets.
 */
model SasDatastoreSecrets extends DatastoreSecrets {
  /**
   * Storage container SAS token.
   */
  sasToken?: string;

  /**
   * Credential type used to authentication with storage.
   */
  secretsType: "Sas";
}

/**
 * Service Principal datastore credentials configuration.
 */
model ServicePrincipalDatastoreCredentials extends DatastoreCredentials {
  /**
   * Authority URL used for authentication.
   */
  authorityUrl?: string;

  /**
   * Service principal client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  clientId: string;

  /**
   * Resource the service principal has access to.
   */
  resourceUrl?: string;

  /**
   * Service principal secrets.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets: ServicePrincipalDatastoreSecrets;

  /**
   * ID of the tenant to which the service principal belongs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  tenantId: string;

  /**
   * Credential type used to authentication with storage.
   */
  credentialsType: "ServicePrincipal";
}

/**
 * Datastore Service Principal secrets.
 */
model ServicePrincipalDatastoreSecrets extends DatastoreSecrets {
  /**
   * Service principal secret.
   */
  clientSecret?: string;

  /**
   * Credential type used to authentication with storage.
   */
  secretsType: "ServicePrincipal";
}

/**
 * Sweep job definition.
 */
model SweepJob extends JobBase {
  /**
   * Early termination policies enable canceling poor-performing runs before they complete
   */
  earlyTermination?: EarlyTerminationPolicy;

  /**
   * Identity configuration. If set, this should be one of AmlToken, ManagedIdentity or null.
   * Defaults to AmlToken if null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: IdentityConfiguration;

  /**
   * Mapping of input data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inputs?: Record<JobInput>;

  /**
   * Sweep Job limit.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  limits?: SweepJobLimits;

  /**
   * Optimization objective.
   */
  objective: Objective;

  /**
   * Mapping of output data bindings used in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outputs?: Record<JobOutput>;

  /**
   * Type of the hyperparameter sampling algorithms
   */
  samplingAlgorithm: SamplingAlgorithm;

  /**
   * A dictionary containing each parameter and its distribution. The dictionary key is the name of the parameter
   */
  searchSpace: unknown;

  /**
   * Trial component definition.
   */
  trial: TrialComponent;

  /**
   * Specifies the type of job.
   */
  jobType: "Sweep";
}

/**
 * Sweep Job limit class.
 */
model SweepJobLimits extends JobLimits {
  /**
   * Sweep Job max concurrent trials.
   */
  maxConcurrentTrials?: int32;

  /**
   * Sweep Job max total trials.
   */
  maxTotalTrials?: int32;

  /**
   * Sweep Job Trial timeout value.
   */
  trialTimeout?: duration;

  /**
   * JobLimit type.
   */
  jobLimitsType: "Sweep";
}

/**
 * Trial component definition.
 */
model TrialComponent {
  /**
   * ARM resource ID of the code asset.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  codeId?: string;

  /**
   * The command to execute on startup of the job. eg. "python train.py"
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @pattern("[a-zA-Z0-9_]")
  command: string;

  /**
   * Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  distribution?: DistributionConfiguration;

  /**
   * The ARM resource ID of the Environment specification for the job.
   */
  @pattern("[a-zA-Z0-9_]")
  environmentId: string;

  /**
   * Environment variables included in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentVariables?: Record<string>;

  /**
   * Compute Resource configuration for the job.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resources?: ResourceConfiguration;
}

/**
 * TensorFlow distribution configuration.
 */
model TensorFlow extends DistributionConfiguration {
  /**
   * Number of parameter server tasks.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  parameterServerCount?: int32;

  /**
   * Number of workers. If not specified, will default to the instance count.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workerCount?: int32;

  /**
   * Specifies the type of distribution framework.
   */
  distributionType: "TensorFlow";
}

/**
 * Triton inferencing server configurations.
 */
model TritonInferencingServer extends InferencingServer {
  /**
   * Inference configuration for Triton.
   */
  inferenceConfiguration?: OnlineInferenceConfiguration;

  /**
   * Inferencing server type for various targets.
   */
  serverType: "Triton";
}

/**
 * Defines an early termination policy that cancels a given percentage of runs at each evaluation interval.
 */
model TruncationSelectionPolicy extends EarlyTerminationPolicy {
  /**
   * The percentage of runs to cancel at each evaluation interval.
   */
  truncationPercentage?: int32;

  /**
   * Name of policy configuration
   */
  policyType: "TruncationSelection";
}

/**
 * uri-file data version entity
 */
model UriFileDataVersion extends DataVersionBaseDetails {
  /**
   * Specifies the type of data.
   */
  dataType: "uri_file";
}

/**
 * uri-folder data version entity
 */
model UriFolderDataVersion extends DataVersionBaseDetails {
  /**
   * Specifies the type of data.
   */
  dataType: "uri_folder";
}
