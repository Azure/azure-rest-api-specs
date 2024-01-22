import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Quantum;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning status field
 */
enum Status {
  Succeeded,
  Launching,
  Updating,
  Deleting,
  Deleted,
  Failed,
}

/**
 * Whether the current workspace is ready to accept Jobs.
 */
enum UsableStatus {
  Yes,
  No,
  Partial,
}

/**
 * Provisioning status field
 */
enum ProvisioningStatus {
  Succeeded,
  ProviderLaunching,
  ProviderUpdating,
  ProviderDeleting,
  ProviderProvisioning,
  Failed,
}

/**
 * The identity type.
 */
enum ResourceIdentityType {
  SystemAssigned,
  None,
}

/**
 * Properties of a Workspace
 */
model WorkspaceResourceProperties {
  /**
   * List of Providers selected for this Workspace
   */
  providers?: Provider[];

  /**
   * Whether the current workspace is ready to accept Jobs.
   */
  @visibility("read")
  usable?: UsableStatus;

  /**
   * Provisioning status field
   */
  @visibility("read")
  provisioningState?: ProvisioningStatus;

  /**
   * ARM Resource Id of the storage account associated with this workspace.
   */
  storageAccount?: string;

  /**
   * The URI of the workspace endpoint.
   */
  @visibility("read")
  endpointUri?: string;
}

/**
 * Information about a Provider. A Provider is an entity that offers Targets to run Azure Quantum Jobs.
 */
model Provider {
  /**
   * Unique id of this provider.
   */
  providerId?: string;

  /**
   * The sku associated with pricing information for this provider.
   */
  providerSku?: string;

  /**
   * A Uri identifying the specific instance of this provider.
   */
  instanceUri?: string;

  /**
   * The provider's marketplace application display name.
   */
  applicationName?: string;

  /**
   * Provisioning status field
   */
  provisioningState?: Status;

  /**
   * Id to track resource usage for the provider.
   */
  resourceUsageId?: string;
}

/**
 * Managed Identity information.
 */
model QuantumWorkspaceIdentity {
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
 * Tags object for patch operations.
 */
model TagsObject {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * The response of a list Providers operation.
 */
model OfferingsListResult is Azure.Core.Page<ProviderDescription>;

/**
 * Information about an offering. A provider offering is an entity that offers Targets to run Azure Quantum Jobs.
 */
model ProviderDescription {
  /**
   * Unique provider's id.
   */
  id?: string;

  /**
   * Provider's display name.
   */
  @visibility("read")
  name?: string;

  /**
   * A list of provider-specific properties.
   */
  properties?: ProviderProperties;
}

/**
 * Provider properties.
 */
model ProviderProperties {
  /**
   * A description about this provider.
   */
  @visibility("read")
  description?: string;

  /**
   * Provider type.
   */
  @visibility("read")
  providerType?: string;

  /**
   * Company name.
   */
  @visibility("read")
  company?: string;

  /**
   * Provider's default endpoint.
   */
  @visibility("read")
  defaultEndpoint?: string;

  /**
   * Azure Active Directory info.
   */
  aad?: ProviderPropertiesAad;

  /**
   * Provider's Managed-Application info
   */
  managedApplication?: ProviderPropertiesManagedApplication;

  /**
   * The list of targets available from this provider.
   */
  targets?: TargetDescription[];

  /**
   * The list of skus available from this provider.
   */
  skus?: SkuDescription[];

  /**
   * The list of quota dimensions from the provider.
   */
  quotaDimensions?: QuotaDimension[];

  /**
   * The list of pricing dimensions from the provider.
   */
  pricingDimensions?: PricingDimension[];
}

/**
 * Azure Active Directory info.
 */
model ProviderPropertiesAad {
  /**
   * Provider's application id.
   */
  @visibility("read")
  applicationId?: string;

  /**
   * Provider's tenant id.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Provider's Managed-Application info
 */
model ProviderPropertiesManagedApplication {
  /**
   * Provider's publisher id.
   */
  @visibility("read")
  publisherId?: string;

  /**
   * Provider's offer id.
   */
  @visibility("read")
  offerId?: string;
}

/**
 * Information about a Target. A target is the component that can process a specific type of Job.
 */
model TargetDescription {
  /**
   * Unique target id.
   */
  id?: string;

  /**
   * Display name of this target.
   */
  name?: string;

  /**
   * A description about this target.
   */
  description?: string;

  /**
   * List of data formats accepted by this target.
   */
  acceptedDataFormats?: string[];

  /**
   * List of content encodings accepted by this target.
   */
  acceptedContentEncodings?: string[];
}

/**
 * Information about a specific sku.
 */
model SkuDescription {
  /**
   * Unique sku id.
   */
  id?: string;

  /**
   * Display name of this sku.
   */
  name?: string;

  /**
   * Display name of this sku.
   */
  version?: string;

  /**
   * Description about this sku.
   */
  description?: string;

  /**
   * Uri to subscribe to the restricted access sku.
   */
  restrictedAccessUri?: string;

  /**
   * Flag to indicate whether the sku should be automatically added during workspace creation.
   */
  autoAdd?: boolean;

  /**
   * The list of targets available for this sku.
   */
  targets?: string[];

  /**
   * The list of quota dimensions for this sku.
   */
  quotaDimensions?: QuotaDimension[];

  /**
   * The list of pricing details for the sku.
   */
  pricingDetails?: PricingDetail[];
}

/**
 * Information about a specific quota dimension.
 */
model QuotaDimension {
  /**
   * Unique id of this dimension.
   */
  id?: string;

  /**
   * The scope of this quota dimension.
   */
  scope?: string;

  /**
   * The reset period of this quota dimension.
   */
  period?: string;

  /**
   * The max limit of this dimension.
   */
  quota?: float32;

  /**
   * The display name of this quota dimension.
   */
  name?: string;

  /**
   * A description about this quota dimension.
   */
  description?: string;

  /**
   * The standard unit of measurement used for this quota dimension.
   */
  unit?: string;

  /**
   * The standard unit of measurement used for this quota dimension in plural form.
   */
  unitPlural?: string;
}

/**
 * Detailed pricing information for an sku.
 */
model PricingDetail {
  /**
   * Unique id for this pricing information.
   */
  id?: string;

  /**
   * The unit cost of this sku.
   */
  value?: string;
}

/**
 * Information about pricing dimension.
 */
model PricingDimension {
  /**
   * Unique id of this pricing dimension.
   */
  id?: string;

  /**
   * The display name of this pricing dimension.
   */
  name?: string;
}

/**
 * Details of check name availability request body.
 */
model CheckNameAvailabilityParameters {
  /**
   * Name for checking availability.
   */
  name?: string;

  /**
   * The resource type of Quantum Workspace.
   */
  type?: string = "Microsoft.Quantum/Workspaces";
}

/**
 * Result of check name availability.
 */
model CheckNameAvailabilityResult {
  /**
   * Indicator of availability of the Quantum Workspace resource name.
   */
  nameAvailable?: boolean;

  /**
   * The reason of unavailability.
   */
  reason?: string;

  /**
   * The detailed info regarding the reason associated with the Namespace.
   */
  @visibility("read")
  message?: string;
}
