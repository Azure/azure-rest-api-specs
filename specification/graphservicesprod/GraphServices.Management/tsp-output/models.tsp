import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace GraphServices;

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("The list of accounts.")
model AccountResourceList is Azure.Core.Page<AccountResource>;

@doc("Account details")
model AccountResource {
  ...Resource;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: AccountResourceSystemData;

  @doc("Property bag from billing account")
  properties: AccountResourceProperties;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model AccountResourceSystemData {
  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("Property bag from billing account")
model AccountResourceProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Customer owned application ID")
  appId: string;

  @doc("Billing Plan Id")
  @visibility("read")
  billingPlanId?: string;
}

@doc("An Azure resource.")
model Resource {
  @doc("Azure resource ID.")
  @visibility("read")
  id?: string;

  @doc("Azure resource name.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type.")
  @visibility("read")
  type?: string;

  @doc("Location of the resource.")
  location?: string;

  @doc("resource tags.")
  tags?: Record<string>;
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

@doc("Account patch properties")
model AccountPatchResource {
  ...TagUpdate;
}

@doc("Request payload used to update an existing resource's tags.")
model TagUpdate {
  @doc("""
List of key value pairs that describe the resource. This will overwrite the
existing tags.
""")
  tags?: Record<string>;
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
