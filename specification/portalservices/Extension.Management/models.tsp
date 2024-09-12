using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The extension source kind
 */
union PortalExtensionSourceKind {
  string,

  @doc("The source code zip uri of the extension.")
  SourceCodeZipUri: "SourceCodeZipUri",
}

/**
 * The provisioning state.
 */
union ProvisioningState {
  string,

  @doc("The operation is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The operation is accepted.")
  Accepted: "Accepted",

  @doc("The operation is running.")
  Running: "Running",

  @doc("The operation is ready.")
  Ready: "Ready",

  @doc("The operation is creating.")
  Creating: "Creating",

  @doc("The operation is created.")
  Created: "Created",

  @doc("The operation is deleting.")
  Deleting: "Deleting",

  @doc("The operation is deleted.")
  Deleted: "Deleted",

  @doc("The operation is canceled.")
  Canceled: "Canceled",

  @doc("The operation is failed.")
  Failed: "Failed",

  @doc("The operation is succeeded.")
  Succeeded: "Succeeded",

  @doc("The operation is updating.")
  Updating: "Updating",
}

/**
 * The extension public status state.
 */
union PublicStatusKind {
  string,

  @doc("The extension is not onboarded.")
  NotOnboarded: "NotOnboarded",

  @doc("The extension is in private preview.")
  PrivatePreview: "PrivatePreview",

  @doc("The extension is in public preview.")
  PublicPreview: "PublicPreview",

  @doc("The extension is in GA.")
  GA: "GA",
}

/**
 * The extension version source kind.
 */
union ExtensionVersionSourceKind {
  string,

  @doc("The build artifact zip uri of the extension version.")
  BuildArtifactZipUri: "BuildArtifactZipUri",
}

/**
 * The deployment source kind
 */
union DeploymentSourceKind {
  string,

  @doc("The deployment source is from extension version.")
  Version: "Version",

  @doc("The deployment source is from copying extension slot.")
  CopySlot: "CopySlot",
}

/**
 * The kind of alteration.
 */
union AlterKind {
  string,

  @doc("The kind of alteration is write")
  Write: "Write",

  @doc("The kind of alteration is delete")
  Delete: "Delete",
}

/**
 * The kind of the source package.
 */
union ExportKind {
  string,

  @doc("The export source is from zip uri.")
  SourceCodeZipUri: "SourceCodeZipUri",

  @doc("The export source is from build artifact zip uri.")
  BuildArtifactZipUri: "BuildArtifactZipUri",
}

/**
 * The portal extension properties.
 */
model PortalExtensionProperties {
  /**
   * The new source code of the extension.
   */
  source?: PortalExtensionPropertiesSource;

  /**
   * Deployment config for the extension.
   */
  deploymentConfig?: DeploymentConfig;

  /**
   * Readonly. The ICM routing details for any live site issues for the extension set in service tree
   */
  @visibility("read")
  icm?: PortalExtensionPropertiesIcm;

  /**
   * Readonly. Email for customer feedback from service tree.
   */
  @visibility("read")
  feedbackEmail?: string;

  /**
   * Readonly. The service tree id.
   */
  @visibility("read")
  serviceTreeId?: string;

  /**
   * Readonly. The oAuthClientId guid from service tree.
   */
  @visibility("read")
  oAuthClientId?: string;

  /**
   * Readonly. The preview stamp from service tree.
   */
  @visibility("read")
  previewStamp?: string;

  /**
   * Readonly. The Azure portal extension name e.g Microsoft_Azure_Storage. Comes in from extension.pdl or extension.dx.json or is generated.
   */
  @visibility("read")
  portalName?: string;

  /**
   * The ARM API definition used to generate extension content.
   */
  apiDefinition?: ExtensionApiDefinition;

  /**
   * The current registration or provisioning state which only appears in the response
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The visibility of the extension. By default status will be NotOnboarded. Microsoft owned extensions can promote using service tree. External extensions can promote your application use partner center.
   */
  @visibility("read")
  publicStatus?: PublicStatusKind;

  /**
   * Once provisioningState is in the terminal state of Succeeded this is the portal runtime uri for portal extensions with status of private
   */
  @visibility("read")
  runtimeUri?: string;
}

/**
 * The new source code of the extension.
 */
model PortalExtensionPropertiesSource {
  /**
   * The kind of the source package.
   */
  kind?: PortalExtensionSourceKind;

  /**
   * The uri of the source package.
   */
  uri?: string;
}

/**
 * Deployment config for the extension.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
model DeploymentConfig {
  /**
   * Defines the deployment stages, regions to deploy to for each stage and sequence to rollout to individual stages.
   */
  @extension("x-ms-identifiers", [])
  stageDefinition?: Record<Array<string>>;
}

/**
 * Readonly. The ICM routing details for any live site issues for the extension set in service tree
 */
model PortalExtensionPropertiesIcm {
  /**
   * Readonly. The ICM service route e.g Azure Portal (IbizaFx) from ICM for the service tree icm teamId.
   */
  @visibility("read")
  service?: string;

  /**
   * Readonly. The team under the ICM service e.g Portal from ICM for the service tree icm teamId.
   */
  @visibility("read")
  team?: string;

  /**
   * Readonly. The ICM team Id from service tree.
   */
  @visibility("read")
  teamId?: int32;
}

/**
 * The ARM API definition used to generate extension content.
 */
model ExtensionApiDefinition {
  /**
   * The uri of the ARM API swagger.
   */
  uri?: string;

  /**
   * The api version of the ARM APIs.
   */
  apiVersion?: string;
}

/**
 * Common resource properties
 */
model ArmCommonProperties {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;

  /**
   * Location of extension
   */
  location?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * The portal extension resource definition.
 */
model PatchablePortalExtension {
  /**
   * The portal extension properties.
   */
  properties?: PortalExtensionProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;
}

/**
 * The extension alter request.
 */
model PortalExtensionAlter {
  /**
   * The list of alterations to perform on the source code.
   */
  @extension("x-ms-identifiers", [])
  alterations?: Array<PortalExtensionAlterAlterationsItem>;
}

/**
 * The alterations item to perform on the source code.
 */
model PortalExtensionAlterAlterationsItem {
  /**
   * The kind of alteration.
   */
  kind: AlterKind;

  /**
   * The file path to alter.
   */
  path: string;

  /**
   * The content of the file.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  content?: Record<unknown>;

  /**
   * The base 64 encoded content of the file.
   */
  base64Content?: string;
}

/**
 * The contents of the file to compile.
 */
model PortalExtensionCompileFile {
  /**
   * The file path.
   */
  path?: string;

  /**
   * The contents of the file.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  contents?: Record<unknown>;

  /**
   * The contents of the string source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  stringSource?: Record<unknown>;
}

/**
 * The result of contents of the file to compile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
model PortalExtensionCompileFileResult is Record<unknown>;

/**
 * The export extension request
 */
model PortalExtensionExport {
  /**
   * The kind of the source package.
   */
  kind?: ExportKind;
}

/**
 * The result of the export extension request
 */
model PortalExtensionExportResult {
  /**
   * The kind of the source package.
   */
  kind?: ExportKind;

  /**
   * The uri of the source package.
   */
  uri?: string;
}

/**
 * The list of sources in the extension
 */
model PortalExtensionListSourcesResult is PortalExtensionListSourcesFolder;

/**
 * The content metadata of a folder
 */
model PortalExtensionListSourcesFolder {
  /**
   * The list of child folders
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  folders?: Record<PortalExtensionListSourcesFolder>;

  /**
   * The list of child files
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  files?: Record<PortalExtensionListSourcesFile>;
}

/**
 * The content metadata of a file
 */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
@discriminator("kind")
model PortalExtensionListSourcesFile {
  /**
   * The last time stamp the file was modified.
   */
  lastModifiedAt: string;
}

/**
 * The properties of an extension version.
 */
model ExtensionVersionProperties {
  /**
   * The path to the ingested extension build artifact zip for the version.
   */
  buildOutputArtifactUri?: string;

  /**
   * Indicates if the version has ever been deployed
   */
  @visibility("read")
  hasBeenDeployed?: boolean;

  /**
   * Indicates if duplicate zip error should be ignored.
   */
  ignoreDuplicateZipError?: boolean;

  /**
   * Readonly. The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The build output artifact zip to create a version from
   */
  source?: ExtensionVersionPropertiesSource;

  /**
   * The extension page version of the zip
   */
  version?: string;
}

/**
 * The build output artifact zip to create a version from
 */
model ExtensionVersionPropertiesSource {
  /**
   * The kind of source content for the version. If omitted uses latest exported version from extension.
   */
  kind?: ExtensionVersionSourceKind;

  /**
   * The instance id of the source kind.
   */
  value?: string;
}

/**
 * The patchable fields of extension version.
 */
model PatchableExtensionVersion {
  /**
   * The patchable extension version properties.
   */
  properties?: PatchableExtensionVersionProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;
}

/**
 * Patchable properties of an extension version.
 */
model PatchableExtensionVersionProperties {
  /**
   * Set by RP to indicate if the version has ever been deployed
   */
  hasBeenDeployed?: boolean;
}

/**
 * Properties of an extension deployment
 */
model ExtensionDeploymentProperties {
  /**
   * Default PT24H. The wait duration after each stage of the deployment. If a only single stage is being deployed waitDuration is ignored.
   */
  waitDuration?: duration;

  /**
   * The build output artifact zip to deploy.
   */
  source?: ExtensionDeploymentPropertiesSource;

  /**
   * Readonly. The current registration or provisioning state which only appears in the response
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Readonly. The next stage of deployment from the deployment sequence e.g stage2
   */
  @visibility("read")
  nextStage?: string;

  /**
   * Optional. The name of a a single stage to deploy. If omitted the Extensions stageDefinition is used for deployment.
   */
  stage?: string;
}

/**
 * The build output artifact zip to deploy.
 */
model ExtensionDeploymentPropertiesSource {
  /**
   * The kind of source content for deployment
   */
  kind?: DeploymentSourceKind = DeploymentSourceKind.Version;

  /**
   * The instance id of the source kind.
   */
  value?: string;
}

/**
 * The patchable fields of extension deployment.
 */
model PatchableExtensionDeployment {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;
}

/**
 * Properties of a extension slot
 */
model ExtensionSlotProperties {
  /**
   * The source content for deployment to the slot.
   */
  source?: ExtensionSlotPropertiesSource;

  /**
   * Readonly. The current registration or provisioning state which only appears in the response
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Readonly. The slot that will be deployed to.
   */
  @visibility("read")
  nextStage?: string;
}

/**
 * The source content for deployment to the slot.
 */
model ExtensionSlotPropertiesSource {
  /**
   * The source content kind for deployment to the slot.
   */
  kind?: DeploymentSourceKind;

  /**
   * The instance id of the source kind.
   */
  value?: string;
}

/**
 * The patchable fields of extension slot.
 */
model PatchableExtensionSlot {
  /**
   * The patchable extension slot properties.
   */
  properties?: ExtensionSlotProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  tags?: Record<string>;
}

/**
 * The contents of the file to compile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Model properties or operation parameters should not be of type Record. ARM requires Resource provider teams to define types explicitly."
model PortalTenantCompileFileProperties {
  /**
   * The contents of the file.
   */
  contents: Record<unknown>;

  /**
   * The contents of the string source.
   */
  stringSource?: Record<unknown>;

  /**
   * The contents of referenced files. The property name is the relative file path and the value is its contents.
   */
  files?: Record<unknown>;

  /**
   * The current registration or provisioning state which only appears in the response.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The contents of the file to compile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
model PortalTenantCompileFileResult is Record<unknown>;

/**
 * The extension list source SVG.
 */
model PortalExtensionListSourcesSvgFile extends PortalExtensionListSourcesFile {
  /**
   * The SVG image content.
   */
  image?: string;

  /**
   * The content kind
   */
  kind: "Svg";
}

/**
 * The extension list source asset type file.
 */
model PortalExtensionListSourcesAssetTypeFile
  extends PortalExtensionListSourcesFile {
  /**
   * The name of the asset type.
   */
  name: string;

  /**
   * The content kind
   */
  kind: "AssetType";
}

/**
 * The extension list source view file.
 */
model PortalExtensionListSourcesViewFile
  extends PortalExtensionListSourcesFile {
  /**
   * The name of the view.
   */
  name: string;

  /**
   * The kind of view.
   */
  viewKind: string;

  /**
   * The content kind
   */
  kind: "View";
}

/**
 * The extension list source other file.
 */
model PortalExtensionListSourcesOtherFile
  extends PortalExtensionListSourcesFile {
  /**
   * The content kind
   */
  kind: "Other";
}
