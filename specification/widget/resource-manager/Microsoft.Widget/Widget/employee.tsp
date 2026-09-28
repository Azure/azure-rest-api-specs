import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
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
}

/** Common options for employee actions. */
model EmployeeActionConfig {
  /** Whether to validate the request without applying the change. */
  dryRun?: boolean;
}

/** Parameters for updating an employee's administrative state. */
model UpdateEmployeeState {
  ...EmployeeActionConfig;

  /** Whether the employee is enabled. */
  enabled?: boolean;

  /** The reason for enabling or disabling the employee. */
  @TypeSpec.Versioning.added(Versions.v2024_10_01_preview)
  reason?: string;
}

/** The employee's administrative state after updating or validating the request. */
model UpdateEmployeeStateResult {
  /** Whether the employee is currently enabled; validation alone does not change this value. */
  @visibility(Lifecycle.Read)
  enabled: boolean;
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

  /** Updates an employee's administrative state, or validates the request without applying it. */
  updateState is ArmResourceActionSync<
    Employee,
    UpdateEmployeeState,
    UpdateEmployeeStateResult
  >;
}
