import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/**
 * List Extension Types. It contains a list of ExtensionType objects and a URL link to get the next set of results.
 */
model ExtensionTypesList is Azure.Core.Page<ExtensionType>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExtensionTypeProperties {
  /**
   * Is this Extension Type a system extension.
   */
  isSystemExtension?: boolean;

  /**
   * Should an identity for this cluster resource be created
   */
  isManagedIdentityRequired?: boolean;

  /**
   * Description of the extension type
   */
  description?: string;

  /**
   * Name of the publisher for the Extension Type
   */
  publisher?: string;

  /**
   * Plan information only for the Marketplace Extension Type.
   */
  planInfo?: ExtensionTypePropertiesPlanInfo;

  /**
   * Cluster Types supported for this Extension Type.
   */
  supportedClusterTypes?: string[];

  /**
   * Supported Kubernetes Scopes for this Extension Type.
   */
  supportedScopes?: ExtensionTypePropertiesSupportedScopes;
}

/**
 * Plan information only for the Marketplace Extension Type.
 */
model ExtensionTypePropertiesPlanInfo {
  /**
   * Publisher ID of the Marketplace Extension Type.
   */
  publisherId?: string;

  /**
   * Plan ID of the Marketplace Extension Type.
   */
  planId?: string;

  /**
   * Offer or Product ID of the Marketplace Extension Type.
   */
  offerId?: string;
}

/**
 * Supported Kubernetes Scopes for this Extension Type.
 */
model ExtensionTypePropertiesSupportedScopes {
  /**
   * The default scope of the extension type. This scope will be used if the user does not provide a scope while creating an extension.
   */
  defaultScope?: string;

  /**
   * Extension scope settings
   */
  clusterScopeSettings?: ClusterScopeSettings;
}

/**
 * Extension scope settings
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterScopeSettings
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Extension scope settings
   */
  properties?: ClusterScopeSettingsProperties;
}

/**
 * Extension scope settings
 */
model ClusterScopeSettingsProperties {
  /**
   * Describes if multiple instances of the extension are allowed
   */
  allowMultipleInstances?: boolean;

  /**
   * Default extension release namespace
   */
  defaultReleaseNamespace?: string;
}

/**
 * List Extension Type Versions. It contains a list of ExtensionTypeVersionForReleaseTrain objects.
 */
model ExtensionTypeVersionsList
  is Azure.Core.Page<ExtensionTypeVersionForReleaseTrain>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExtensionTypeVersionForReleaseTrainProperties {
  /**
   * The version number for the extension type
   */
  version?: string;

  /**
   * The list of supported Kubernetes cluster versions for this extension type
   */
  unsupportedKubernetesVersions?: ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions;

  /**
   * A list of supported cluster types for this version of the Extension Type
   */
  supportedClusterTypes?: string[];
}

/**
 * The list of supported Kubernetes cluster versions for this extension type
 */
model ExtensionTypeVersionForReleaseTrainPropertiesUnsupportedKubernetesVersions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  connectedCluster?: ExtensionTypeVersionUnsupportedKubernetesMatrixItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  appliances?: ExtensionTypeVersionUnsupportedKubernetesMatrixItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  provisionedCluster?: ExtensionTypeVersionUnsupportedKubernetesMatrixItem[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  managedCluster?: ExtensionTypeVersionUnsupportedKubernetesMatrixItem[];
}

/**
 * The list of Kubernetes Distribution and Versions that are not supported by this version of this Extension Type
 */
model ExtensionTypeVersionUnsupportedKubernetesMatrixItem {
  /**
   * The list of Kubernetes Cluster Distribution Names not supported
   */
  distributions?: string[];

  /**
   * The list of Kubernetes Versions not supported by the list of Kubernetes Cluster Distribution names in this object
   */
  unsupportedVersions?: string[];
}
