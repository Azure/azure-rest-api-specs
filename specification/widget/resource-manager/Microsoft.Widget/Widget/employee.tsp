import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Widget;

/** Employee resource */
model Employee is TrackedResource<EmployeeProperties> {
  ...ResourceNameParameter<Employee>;
}

/** Employee properties */
model EmployeeProperties {
  /** Age of employee */
  age?: int32;

  /** City of employee */
  city?: string;

  /** Profile of employee */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Employee department. Added in version 2022-01-01-preview. */
  @added(Versions.v2022_01_01_preview)
  department?: string;

  /** Employee role. Added in version 2022-02-01. */
  @added(Versions.v2022_02_01)
  role?: EmployeeRole;

  /** Employee email. Added in version 2022-02-01. */
  @added(Versions.v2022_02_01)
  email?: string;
}

/** Employee role. */
@added(Versions.v2022_02_01)
union EmployeeRole {
  string,

  /** Manager role */
  Manager: "Manager",

  /** Developer role */
  Developer: "Developer",

  /** Designer role */
  Designer: "Designer",

  /** Analyst role */
  Analyst: "Analyst",
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

@armResourceOperations
interface Employees {
  get is ArmResourceRead<Employee>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Employee>;
  update is ArmResourcePatchSync<Employee, EmployeeProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Employee>;
  listByResourceGroup is ArmResourceListByParent<Employee>;
  listBySubscription is ArmListBySubscription<Employee>;

  /** Get employee statistics. Added in version 2022-01-01-preview. */
  @added(Versions.v2022_01_01_preview)
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Widget/employees/{employeeName}/statistics")
  @get
  op getStatistics(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The employee name.")
    @path
    employeeName: string,
  ): EmployeeStatistics;
}

/** Employee statistics. */
@added(Versions.v2022_01_01_preview)
model EmployeeStatistics {
  /** Employee name */
  employeeName: string;

  /** Total projects */
  totalProjects: int32;

  /** Years of service */
  yearsOfService: int32;

  /** Last activity date */
  lastActivityDate: utcDateTime;
}
