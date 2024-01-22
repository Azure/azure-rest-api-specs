import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ExtendedLocation;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The identity type.
 */
enum ResourceIdentityType {
  SystemAssigned,
  None,
}

/**
 * Type of host the Custom Locations is referencing (Kubernetes, etc...).
 */
enum HostType {
  Kubernetes,
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;
}

/**
 * Properties for a custom location.
 */
model CustomLocationProperties {
  /**
   * This is optional input that contains the authentication that should be used to generate the namespace.
   */
  authentication?: CustomLocationPropertiesAuthentication;

  /**
   * Contains the reference to the add-on that contains charts to deploy CRDs and operators.
   */
  clusterExtensionIds?: string[];

  /**
   * Display name for the Custom Locations location.
   */
  displayName?: string;

  /**
   * Connected Cluster or AKS Cluster. The Custom Locations RP will perform a checkAccess API for listAdminCredentials permissions.
   */
  hostResourceId?: string;

  /**
   * Type of host the Custom Locations is referencing (Kubernetes, etc...).
   */
  hostType?: HostType;

  /**
   * Kubernetes namespace that will be created on the specified cluster.
   */
  `namespace`?: string;

  /**
   * Provisioning State for the Custom Location.
   */
  provisioningState?: string;
}

/**
 * This is optional input that contains the authentication that should be used to generate the namespace.
 */
model CustomLocationPropertiesAuthentication {
  /**
   * The type of the Custom Locations authentication
   */
  type?: string;

  /**
   * The kubeconfig value.
   */
  @visibility("create", "update")
  value?: string;
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
}

/**
 * The Custom Locations patchable resource definition.
 */
model PatchableCustomLocations {
  /**
   * Identity for the resource.
   */
  identity?: Identity;

  /**
   * The Custom Locations patchable properties.
   */
  properties?: CustomLocationProperties;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * List of EnabledResourceTypes definition.
 */
model EnabledResourceTypesListResult is Azure.Core.Page<EnabledResourceType>;

/**
 * EnabledResourceType definition.
 */
model EnabledResourceType extends ProxyResource {
  /**
   * The set of properties for EnabledResourceType specific to a Custom Location
   */
  properties?: EnabledResourceTypeProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Properties for EnabledResourceType of a custom location.
 */
model EnabledResourceTypeProperties {
  /**
   * Cluster Extension ID
   */
  clusterExtensionId?: string;

  /**
   * Cluster Extension Type
   */
  extensionType?: string;

  /**
   * Metadata of the Resource Type
   */
  typesMetadata?: EnabledResourceTypePropertiesTypesMetadataItem[];
}

/**
 * Metadata of the Resource Type.
 */
model EnabledResourceTypePropertiesTypesMetadataItem {
  /**
   * Api Version of Resource Type
   */
  apiVersion?: string;

  /**
   * Resource Provider Namespace of Resource Type
   */
  resourceProviderNamespace?: string;

  /**
   * Resource Type
   */
  resourceType?: string;
}

/**
 * Custom Locations operation.
 */
model CustomLocationOperation {
  /**
   * Describes the properties of a Custom Locations Operation Value Display.
   */
  display?: CustomLocationOperationValueDisplay;

  /**
   * Is this Operation a data plane operation
   */
  @visibility("read")
  isDataAction?: boolean;

  /**
   * The name of the compute operation.
   */
  @visibility("read")
  name?: string;

  /**
   * The origin of the compute operation.
   */
  @visibility("read")
  origin?: string;
}

/**
 * Describes the properties of a Custom Locations Operation Value Display.
 */
model CustomLocationOperationValueDisplay {
  /**
   * The description of the operation.
   */
  @visibility("read")
  description?: string;

  /**
   * The display name of the compute operation.
   */
  @visibility("read")
  operation?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility("read")
  provider?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility("read")
  resource?: string;
}

/**
 * Lists of Custom Locations operations.
 */
model CustomLocationOperationsList {
  /**
   * Next page of operations.
   */
  nextLink?: string;

  /**
   * Array of customLocationOperation
   */
  value: CustomLocationOperation[];
}
