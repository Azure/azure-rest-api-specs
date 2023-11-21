import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace TrafficController;

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ProvisioningState {
  Provisioning,
  Updating,
  Deleting,
  Accepted,
  Succeeded,
  Failed,
  Canceled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AssociationType {
  subnets,
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
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

@doc("The response of a TrafficController list operation.")
model TrafficControllerListResult is Azure.Core.Page<TrafficController>;

@doc("""
Concrete tracked resource types can be created by aliasing this type using a
specific property type.
""")
model TrafficController {
  ...TrackedResource;

  @doc("The resource-specific properties for this resource.")
  properties?: TrafficControllerProperties;
}

@doc("Traffic Controller Properties.")
model TrafficControllerProperties {
  @doc("Configuration Endpoints.")
  @visibility("read")
  configurationEndpoints?: string[];

  @doc("Frontends References List")
  @visibility("read")
  frontends?: ResourceId[];

  @doc("Associations References List")
  @visibility("read")
  associations?: ResourceId[];

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Resource ID definition used by parent to reference child resources.")
model ResourceId {
  @doc("Resource ID of child resource.")
  id: string;
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

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
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

@doc("The type used for update operations of the TrafficController.")
model TrafficControllerUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("The response of a Association list operation.")
model AssociationListResult is Azure.Core.Page<Association>;

@doc("Association Subresource of Traffic Controller")
model Association {
  ...TrackedResource;

  @doc("The resource-specific properties for this resource.")
  properties?: AssociationProperties;
}

@doc("Association Properties.")
model AssociationProperties {
  @doc("Association Type")
  associationType: AssociationType;

  @doc("Association Subnet")
  subnet?: AssociationSubnet;

  @doc("Provisioning State of Traffic Controller Association Resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Association Subnet.")
model AssociationSubnet {
  @doc("Association ID.")
  id: string;
}

@doc("The type used for update operations of the Association.")
model AssociationUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The updatable properties of the Association.")
  properties?: AssociationUpdateProperties;
}

@doc("The updatable properties of the Association.")
model AssociationUpdateProperties {
  @doc("Association Type")
  associationType?: AssociationType;

  @doc("Association Subnet")
  subnet?: AssociationSubnetUpdate;
}

@doc("Association Subnet.")
model AssociationSubnetUpdate {
  @doc("Association ID.")
  id?: string;
}

@doc("The response of a Frontend list operation.")
model FrontendListResult is Azure.Core.Page<Frontend>;

@doc("Frontend Subresource of Traffic Controller.")
model Frontend {
  ...TrackedResource;

  @doc("The resource-specific properties for this resource.")
  properties?: FrontendProperties;
}

@doc("Frontend Properties.")
model FrontendProperties {
  @doc("""
The Fully Qualified Domain Name of the DNS record associated to a Traffic
Controller frontend.
""")
  @visibility("read")
  fqdn?: string;

  @doc("Provisioning State of Traffic Controller Frontend Resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The type used for update operations of the Frontend.")
model FrontendUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}
