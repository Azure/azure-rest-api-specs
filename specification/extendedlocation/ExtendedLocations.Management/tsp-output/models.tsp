import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace customLocations;

enum ResourceIdentityType {
  SystemAssigned,
  None,
}

enum HostType {
  Kubernetes,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Lists of Custom Locations operations.")
model CustomLocationOperationsList is Azure.Core.Page<CustomLocationOperation>;

@doc("Custom Locations operation.")
model CustomLocationOperation {
  @doc("Describes the properties of a Custom Locations Operation Value Display.")
  display?: CustomLocationOperationValueDisplay;

  @doc("Is this Operation a data plane operation")
  @visibility("read")
  isDataAction?: boolean;

  @doc("The name of the compute operation.")
  @visibility("read")
  name?: string;

  @doc("The origin of the compute operation.")
  @visibility("read")
  origin?: string;
}

@doc("Describes the properties of a Custom Locations Operation Value Display.")
model CustomLocationOperationValueDisplay {
  @doc("The description of the operation.")
  @visibility("read")
  description?: string;

  @doc("The display name of the compute operation.")
  @visibility("read")
  operation?: string;

  @doc("The resource provider for the operation.")
  @visibility("read")
  provider?: string;

  @doc("The display name of the resource the operation applies to.")
  @visibility("read")
  resource?: string;
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

@doc("The List Custom Locations operation response.")
model CustomLocationListResult is Azure.Core.Page<CustomLocation>;

@doc("Custom Locations definition.")
model CustomLocation {
  ...TrackedResource;

  @doc("Identity for the resource.")
  identity?: Identity;

  @doc("The set of properties specific to a Custom Location")
  properties?: CustomLocationProperties;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;
}

@doc("Properties for a custom location.")
model CustomLocationProperties {
  @doc("""
This is optional input that contains the authentication that should be used to
generate the namespace.
""")
  authentication?: CustomLocationPropertiesAuthentication;

  @doc("""
Contains the reference to the add-on that contains charts to deploy CRDs and
operators.
""")
  clusterExtensionIds?: string[];

  @doc("Display name for the Custom Locations location.")
  displayName?: string;

  @doc("""
Connected Cluster or AKS Cluster. The Custom Locations RP will perform a
checkAccess API for listAdminCredentials permissions.
""")
  hostResourceId?: string;

  @doc("Type of host the Custom Locations is referencing (Kubernetes, etc...).")
  hostType?: HostType;

  @doc("Kubernetes namespace that will be created on the specified cluster.")
  `namespace`?: string;

  @doc("Provisioning State for the Custom Location.")
  provisioningState?: string;
}

@doc("""
This is optional input that contains the authentication that should be used to
generate the namespace.
""")
model CustomLocationPropertiesAuthentication {
  @doc("The type of the Custom Locations authentication")
  type?: string;

  @doc("The kubeconfig value.")
  value?: string;
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
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
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

@doc("The Custom Locations patchable resource definition.")
model PatchableCustomLocations {
  @doc("Identity for the resource.")
  identity?: Identity;

  @doc("The Custom Locations patchable properties.")
  properties?: CustomLocationProperties;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("List of EnabledResourceTypes definition.")
model EnabledResourceTypesListResult is Azure.Core.Page<EnabledResourceType>;

@doc("EnabledResourceType definition.")
model EnabledResourceType {
  ...ProxyResource;

  @doc("The set of properties for EnabledResourceType specific to a Custom Location")
  properties?: EnabledResourceTypeProperties;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Properties for EnabledResourceType of a custom location.")
model EnabledResourceTypeProperties {
  @doc("Cluster Extension ID")
  clusterExtensionId?: string;

  @doc("Cluster Extension Type")
  extensionType?: string;

  @doc("Metadata of the Resource Type")
  typesMetadata?: EnabledResourceTypePropertiesTypesMetadataItem[];
}

@doc("Metadata of the Resource Type.")
model EnabledResourceTypePropertiesTypesMetadataItem {
  @doc("Api Version of Resource Type")
  apiVersion?: string;

  @doc("Resource Provider Namespace of Resource Type")
  resourceProviderNamespace?: string;

  @doc("Resource Type")
  resourceType?: string;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}
