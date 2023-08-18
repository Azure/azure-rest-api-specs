import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.Quantum;

@doc("doc")
enum Status {
  @doc("doc")
  Succeeded,
  @doc("doc")
  Launching,
  @doc("doc")
  Updating,
  @doc("doc")
  Deleting,
  @doc("doc")
  Deleted,
  @doc("doc")
  Failed,
}

@doc("doc")
enum UsableStatus {
  @doc("doc")
  Yes,
  @doc("doc")
  No,
  @doc("doc")
  Partial,
}

@doc("doc")
enum ProvisioningStatus {
  @doc("doc")
  Succeeded,
  @doc("doc")
  ProviderLaunching,
  @doc("doc")
  ProviderUpdating,
  @doc("doc")
  ProviderDeleting,
  @doc("doc")
  ProviderProvisioning,
  @doc("doc")
  Failed,
}

@doc("doc")
enum ResourceIdentityType {
  @doc("doc")
  SystemAssigned,
  @doc("doc")
  None,
}

@doc("doc")
enum CreatedByType {
  @doc("doc")
  User,
  @doc("doc")
  Application,
  @doc("doc")
  ManagedIdentity,
  @doc("doc")
  Key,
}

@doc("The resource proxy definition object for quantum workspace.")
model QuantumWorkspace is TrackedResource<WorkspaceResourceProperties> {
  @doc("doc")
  @key
  @segment("workspaces")
  @visibility("read")
  @path
  name: string;
}

@doc("Properties of a Workspace")
model WorkspaceResourceProperties {
  @doc("List of Providers selected for this Workspace")
  providers?: Provider[];

  @doc("Whether the current workspace is ready to accept Jobs.")
  @visibility("read")
  usable?: UsableStatus;

  @doc("Provisioning status field")
  @visibility("read")
  provisioningState?: ProvisioningStatus;

  @doc("ARM Resource Id of the storage account associated with this workspace.")
  storageAccount?: string;

  @doc("The URI of the workspace endpoint.")
  @visibility("read")
  endpointUri?: string;
}

@doc("""
Information about a Provider. A Provider is an entity that offers Targets to
run Azure Quantum Jobs.
""")
model Provider {
  @doc("Unique id of this provider.")
  providerId?: string;

  @doc("The sku associated with pricing information for this provider.")
  providerSku?: string;

  @doc("A Uri identifying the specific instance of this provider.")
  instanceUri?: string;

  @doc("The provider's marketplace application display name.")
  applicationName?: string;

  @doc("Provisioning status field")
  provisioningState?: Status;

  @doc("Id to track resource usage for the provider.")
  resourceUsageId?: string;
}

@doc("Managed Identity information.")
model QuantumWorkspaceIdentity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Tags object for patch operations.")
model TagsObject {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("The response of a list Workspaces operation.")
model WorkspaceListResult is Azure.Core.Page<QuantumWorkspace>;

@doc("The response of a list Providers operation.")
model OfferingsListResult is Azure.Core.Page<ProviderDescription>;

@doc("""
Information about an offering. A provider offering is an entity that offers
Targets to run Azure Quantum Jobs.
""")
model ProviderDescription {
  @doc("Unique provider's id.")
  id?: string;

  @doc("Provider's display name.")
  @visibility("read")
  name?: string;

  @doc("A list of provider-specific properties.")
  properties?: ProviderProperties;
}

@doc("Provider properties.")
model ProviderProperties {
  @doc("A description about this provider.")
  @visibility("read")
  description?: string;

  @doc("Provider type.")
  @visibility("read")
  providerType?: string;

  @doc("Company name.")
  @visibility("read")
  company?: string;

  @doc("Provider's default endpoint.")
  @visibility("read")
  defaultEndpoint?: string;

  @doc("Azure Active Directory info.")
  aad?: ProviderPropertiesAad;

  @doc("Provider's Managed-Application info")
  managedApplication?: ProviderPropertiesManagedApplication;

  @doc("The list of targets available from this provider.")
  targets?: TargetDescription[];

  @doc("The list of skus available from this provider.")
  skus?: SkuDescription[];

  @doc("The list of quota dimensions from the provider.")
  quotaDimensions?: QuotaDimension[];

  @doc("The list of pricing dimensions from the provider.")
  pricingDimensions?: PricingDimension[];
}

@doc("Azure Active Directory info.")
model ProviderPropertiesAad {
  @doc("Provider's application id.")
  @visibility("read")
  applicationId?: string;

  @doc("Provider's tenant id.")
  @visibility("read")
  tenantId?: string;
}

@doc("Provider's Managed-Application info")
model ProviderPropertiesManagedApplication {
  @doc("Provider's publisher id.")
  @visibility("read")
  publisherId?: string;

  @doc("Provider's offer id.")
  @visibility("read")
  offerId?: string;
}

@doc("""
Information about a Target. A target is the component that can process a
specific type of Job.
""")
model TargetDescription {
  @doc("Unique target id.")
  id?: string;

  @doc("Display name of this target.")
  name?: string;

  @doc("A description about this target.")
  description?: string;

  @doc("List of data formats accepted by this target.")
  acceptedDataFormats?: string[];

  @doc("List of content encodings accepted by this target.")
  acceptedContentEncodings?: string[];
}

@doc("Information about a specific sku.")
model SkuDescription {
  @doc("Unique sku id.")
  id?: string;

  @doc("Display name of this sku.")
  name?: string;

  @doc("Display name of this sku.")
  version?: string;

  @doc("Description about this sku.")
  description?: string;

  @doc("Uri to subscribe to the restricted access sku.")
  restrictedAccessUri?: string;

  @doc("""
Flag to indicate whether the sku should be automatically added during workspace
creation.
""")
  autoAdd?: boolean;

  @doc("The list of targets available for this sku.")
  targets?: string[];

  @doc("The list of quota dimensions for this sku.")
  quotaDimensions?: QuotaDimension[];

  @doc("The list of pricing details for the sku.")
  pricingDetails?: PricingDetail[];
}

@doc("Information about a specific quota dimension.")
model QuotaDimension {
  @doc("Unique id of this dimension.")
  id?: string;

  @doc("The scope of this quota dimension.")
  scope?: string;

  @doc("The reset period of this quota dimension.")
  period?: string;

  @doc("The max limit of this dimension.")
  quota?: float32;

  @doc("The display name of this quota dimension.")
  name?: string;

  @doc("A description about this quota dimension.")
  description?: string;

  @doc("The standard unit of measurement used for this quota dimension.")
  unit?: string;

  @doc("The standard unit of measurement used for this quota dimension in plural form.")
  unitPlural?: string;
}

@doc("Detailed pricing information for an sku.")
model PricingDetail {
  @doc("Unique id for this pricing information.")
  id?: string;

  @doc("The unit cost of this sku.")
  value?: string;
}

@doc("Information about pricing dimension.")
model PricingDimension {
  @doc("Unique id of this pricing dimension.")
  id?: string;

  @doc("The display name of this pricing dimension.")
  name?: string;
}

@doc("Lists the operations available.")
model OperationsList is Azure.Core.Page<Operation>;

@doc("Operation provided by provider")
model Operation {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Properties of the operation")
  display?: OperationDisplay;
}

@doc("Properties of the operation")
model OperationDisplay {
  @doc("Provider name")
  provider?: string;

  @doc("Resource name")
  resource?: string;

  @doc("Operation name")
  operation?: string;

  @doc("Description of the operation")
  description?: string;
}

@doc("Details of check name availability request body.")
model CheckNameAvailabilityParameters {
  @doc("Name for checking availability.")
  name?: string;

  @doc("The resource type of Quantum Workspace.")
  type?: string;
}

@doc("Result of check name availability.")
model CheckNameAvailabilityResult {
  @doc("Indicator of availability of the Quantum Workspace resource name.")
  nameAvailable?: boolean;

  @doc("The reason of unavailability.")
  reason?: string;

  @doc("The detailed info regarding the reason associated with the Namespace.")
  @visibility("read")
  message?: string;
}
