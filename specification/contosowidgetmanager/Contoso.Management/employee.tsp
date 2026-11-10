import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** Employee resource */
model Employee is TrackedResource<EmployeeProperties> {
  ...ResourceNameParameter<Employee>;
}

/** Employee properties */
model EmployeeProperties {
  /** Age of employee */
  age?: int32;

  /** The city where the employee is located. */
  city?: string;

  /** Profile of employee */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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
  /** Gets an employee by name within a resource group. */
  get is ArmResourceRead<Employee>;
  /** Creates an employee or replaces an existing employee within a resource group. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Employee>;
  /** Updates the specified properties of an employee within a resource group. */
  update is ArmResourcePatchSync<Employee, EmployeeProperties>;
  /** Deletes an employee within a resource group. */
  delete is ArmResourceDeleteWithoutOkAsync<Employee>;
  /** Lists the employees within a resource group. */
  listByResourceGroup is ArmResourceListByParent<Employee>;
  /** Lists the employees across all resource groups in a subscription. */
  listBySubscription is ArmListBySubscription<Employee>;
}
