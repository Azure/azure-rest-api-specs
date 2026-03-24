import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/**
 * The provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * Resource is being created.
   */
  Creating: "Creating",

  /**
   * Resource is being updated.
   */
  Updating: "Updating",

  /**
   * Resource is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * Level of the status.
 */
union LevelType {
  string,

  /**
   * Indicates an error status from the extension.
   */
  Error: "Error",

  /**
   * Indicates a warning status from the extension.
   */
  Warning: "Warning",

  /**
   * Indicates an informational status from the extension.
   */
  Information: "Information",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * Created through an interactive sign-in by a person.
   */
  User: "User",

  /**
   * Created by an app registration or service principal acting as a client.
   */
  Application: "Application",

  /**
   * Created via an Azure managed identity (system- or user-assigned).
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Created using a key-based credential flow supported by some services.
   */
  Key: "Key",
}

/**
 * The identity type.
 */
union AKSIdentityType {
  /**
   * SystemAssigned identity
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned identity
   */
  UserAssigned: "UserAssigned",

  /**
   * Workload identity
   */
  @added(Versions.v2025_03_01)
  Workload: "Workload",

  string,
}

/**
 * Properties of an Extension resource
 */
model ExtensionProperties {
  /**
   * Type of the Extension, of which this resource is an instance of.  It must be one of the Extension Types registered with Microsoft.KubernetesConfiguration by the Extension publisher.
   */
  extensionType?: string;

  /**
   * Flag to note if this extension participates in auto upgrade of minor version, or not.
   */
  autoUpgradeMinorVersion?: boolean = true;

  /**
   * ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.
   */
  releaseTrain?: string = "Stable";

  /**
   * User-specified version of the extension for this extension to 'pin'. To use 'version', autoUpgradeMinorVersion must be 'false'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;

  /**
   * Scope at which the extension is installed.
   */
  scope?: Scope;

  /**
   * Configuration settings, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationSettings?: Record<string> | null;

  /**
   * Configuration settings that are sensitive, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationProtectedSettings?: Record<string> | null;

  /**
   * Currently installed version of the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  currentVersion?: string | null;

  /**
   * Status of installation of this extension.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Status from this extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  statuses?: ExtensionStatus[] | null;

  /**
   * Error information from the Agent - e.g. errors during installation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorInfo?: Azure.ResourceManager.CommonTypes.ErrorDetail | null;

  /**
   * Custom Location settings properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  customLocationSettings?: Record<string> | null;

  /**
   * Uri of the Helm package
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  packageUri?: string | null;

  /**
   * Identity of the Extension resource in an AKS cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aksAssignedIdentity?: ExtensionPropertiesAksAssignedIdentity | null;

  /**
   * Flag to note if this extension is a system extension
   */
  @visibility(Lifecycle.Read)
  isSystemExtension?: boolean = false;

  /**
   * The upgrade mode for auto upgrade.
   * The default is "compatible".
   */
  @added(Versions.v2025_03_01)
  autoUpgradeMode?: AutoUpgradeMode = AutoUpgradeMode.compatible;

  /**
   *  Management details of the extension
   */
  @added(Versions.v2025_03_01)
  managementDetails?: ManagementDetails;

  /**
   *  Additional details provided by the publisher of the extension.
   */
  @added(Versions.v2025_03_01)
  additionalDetails?: AdditionalDetails;

  /**
   * State of the extension on the cluster.
   */
  @added(Versions.v2025_03_01)
  @visibility(Lifecycle.Read)
  extensionState?: string;
}

/**
 * Scope of the extension. It can be either Cluster or Namespace; but not both.
 */
model Scope {
  /**
   * Specifies that the scope of the extension is Cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  cluster?: ScopeCluster | null;

  /**
   * Specifies that the scope of the extension is Namespace
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `namespace`?: ScopeNamespace | null;
}

/**
 * Specifies that the scope of the extension is Cluster
 */
model ScopeCluster {
  /**
   * Namespace where the extension Release must be placed, for a Cluster scoped extension.  If this namespace does not exist, it will be created
   */
  releaseNamespace?: string;
}

/**
 * Specifies that the scope of the extension is Namespace
 */
model ScopeNamespace {
  /**
   * Namespace where the extension will be created for an Namespace scoped extension.  If this namespace does not exist, it will be created
   */
  targetNamespace?: string;
}

/**
 * Status from the extension.
 */
model ExtensionStatus {
  /**
   * Status code provided by the Extension
   */
  code?: string;

  /**
   * Short description of status of the extension.
   */
  displayStatus?: string;

  /**
   * Level of the status.
   */
  level?: LevelType = LevelType.Information;

  /**
   * Detailed message of the status from the Extension.
   */
  message?: string;

  /**
   * DateLiteral (per ISO8601) noting the time of installation status.
   */
  time?: string;
}

/**
 * Identity of the Extension resource in an AKS cluster
 */
model ExtensionPropertiesAksAssignedIdentity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: AKSIdentityType;

  /**
   * The object ID of resource identity.
   */
  @added(Versions.v2025_03_01)
  objectId?: string;

  /**
   * The client ID of resource identity.
   */
  @added(Versions.v2025_03_01)
  clientId?: string;

  /**
   * The ID of the resource identity.
   */
  @added(Versions.v2025_03_01)
  resourceId?: armResourceIdentifier;
}

/**
 * The Extension Patch Request object.
 */
model PatchExtension {
  /**
   * Updatable properties of an Extension Patch Request
   */
  properties?: PatchExtensionProperties;
}

/**
 * Updatable properties of an Extension Patch Request
 */
model PatchExtensionProperties {
  /**
   * Flag to note if this extension participates in auto upgrade of minor version, or not.
   */
  autoUpgradeMinorVersion?: boolean = true;

  /**
   * The upgrade mode for auto upgrade.
   * The default is "compatible".
   */
  @added(Versions.v2025_03_01)
  autoUpgradeMode?: AutoUpgradeMode = AutoUpgradeMode.compatible;

  /**
   * ReleaseTrain this extension participates in for auto-upgrade (e.g. Stable, Preview, etc.) - only if autoUpgradeMinorVersion is 'true'.
   */
  releaseTrain?: string = "Stable";

  /**
   * Version of the extension for this extension, if it is 'pinned' to a specific version. autoUpgradeMinorVersion must be 'false'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  version?: string | null;

  /**
   * Configuration settings, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  configurationSettings?: Record<string> | null;

  /**
   * Configuration settings that are sensitive, as name-value pairs for configuring this extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  configurationProtectedSettings?: Record<string> | null;
}

/**
 * Result of the request to list Extensions.  It contains a list of Extension objects and a URL link to get the next set of results.
 */
model ExtensionsList is Azure.Core.Page<Extension>;

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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<string> | null;

  /**
   * If present, details of the operation error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail | null;
}

/**
 * The upgrade mode for auto upgrade.
 * The default is "compatible".
 */
@added(Versions.v2025_03_01)
union AutoUpgradeMode {
  /**
   * The extension will not be automatically upgraded.
   */
  none: "none",

  /**
   * The extension will be automatically upgraded to the latest patch version within the minor version.
   */
  patch: "patch",

  /**
   * The extension will be automatically upgraded to compatible versions as determined by the user.
   */
  compatible: "compatible",

  string,
}

/**
 *  Metadata about the managing entity of the extension and the permitted operations.
 */
@added(Versions.v2025_03_01)
model ManagementDetails {
  /**
   *  The category of the managing entity
   */
  category?: string;

  /**
   *  The list of access details of the managing entity
   */
  @identifiers(#[])
  accessDetails?: AccessDetail[];
}

/**
 *  Metadata about the access details of the managing entity of the extension
 */
@added(Versions.v2025_03_01)
model AccessDetail {
  /**
   * The entity to which the access details apply
   */
  entity?: string;

  /**
   * The list of allowed actions for the entity
   */
  allowedActions?: string[];

  /**
   * The description of the entity
   */
  description?: string;
}

/**
 *  Additional details provided by the publisher of the extension.
 */
@added(Versions.v2025_03_01)
model AdditionalDetails {
  /** Documentation for the extension. */
  docs?: string;

  /** Release Notes of the extension. */
  releaseNotes?: string;

  /** Troubleshooting guide for the extension. */
  troubleshootingGuide?: string;
}
