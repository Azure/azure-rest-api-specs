import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Quantum;

/**
 * Provisioning status field
 */
union ProviderStatus {
  string,

  /** The provider is successfully provisioned. */
  Succeeded: "Succeeded",

  /** The provider is starting provisioning. */
  Launching: "Launching",

  /** The provider is updating. */
  Updating: "Updating",

  /** The provider is deleting. */
  Deleting: "Deleting",

  /** The provider is deleted. */
  Deleted: "Deleted",

  /** The provider is failed. */
  Failed: "Failed",
}

/**
 * Whether the current workspace is ready to accept Jobs.
 */
union UsableStatus {
  string,

  /** The workspace is usable and can accept jobs. */
  Yes: "Yes",

  /** The workspace is not usable and cannot accept jobs. */
  No: "No",

  /** The workspace is partially usable. */
  Partial: "Partial",
}

/**
 * The Workspace provisioning status.
 */
union WorkspaceProvisioningStatus {
  ResourceProvisioningState,

  /** The Workspace provisioning is succeeded. */
  Succeeded: "Succeeded",

  /** The Workspace is currently starting to provision a provider. */
  ProviderLaunching: "ProviderLaunching",

  /** The Workspace is currently updating a provider. */
  ProviderUpdating: "ProviderUpdating",

  /** The Workspace is currently deleting a provider. */
  ProviderDeleting: "ProviderDeleting",

  /** The Workspace is currently provisioning a provider. */
  ProviderProvisioning: "ProviderProvisioning",

  /** The Workspace provisioning failed. */
  Failed: "Failed",
}

/**
 * The API key type.
 */
union KeyType {
  string,

  /** The primary API key. */
  Primary: "Primary",

  /** The secondary API key. */
  Secondary: "Secondary",
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
   * Provider properties.
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
 * Properties of a Workspace
 */
model WorkspaceResourceProperties {
  /**
   * List of Providers selected for this Workspace
   */
  @OpenAPI.extension("x-ms-identifiers", ["providerId"])
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
  provisioningState?: WorkspaceProvisioningStatus;

  /**
   * ARM Resource Id of the storage account associated with this workspace.
   */
  storageAccount?: string;

  /**
   * The URI of the workspace endpoint.
   */
  @visibility("read")
  endpointUri?: string;

  /**
   * Indicator of enablement of the Quantum workspace Api keys.
   */
  apiKeyEnabled?: boolean;
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
  provisioningState?: ProviderStatus;

  /**
   * Id to track resource usage for the provider.
   */
  resourceUsageId?: string;
}

/**
 * Result of list Api keys and connection strings.
 */
model ListKeysResult {
  /**
   * Indicator of enablement of the Quantum workspace Api keys.
   */
  apiKeyEnabled?: boolean;

  /**
   * The quantum workspace primary api key.
   */
  primaryKey?: ApiKey;

  /**
   * The quantum workspace secondary api key.
   */
  secondaryKey?: ApiKey;

  /**
   * The connection string of the primary api key.
   */
  @visibility("read")
  primaryConnectionString?: string;

  /**
   * The connection string of the secondary api key.
   */
  @visibility("read")
  secondaryConnectionString?: string;
}

/**
 * Azure quantum workspace Api key details.
 */
model ApiKey {
  /**
   * The creation time of the api key.
   */
  createdAt?: utcDateTime;

  /**
   * The Api key.
   */
  @visibility("read")
  key?: string;
}

/**
 * List of api keys to be generated.
 */
model ApiKeys {
  /**
   * A list of api key names.
   */
  keys?: KeyType[];
}
