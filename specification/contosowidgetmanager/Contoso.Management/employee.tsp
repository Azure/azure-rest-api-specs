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
  /** Name of employee */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("employeeName")
  @path
  @segment("employees")
  name: string;
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
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning,

  /** The resource is being updated. */
  Updating,

  /** The resource is being deleted. */
  Deleting,

  /** The resource provisioning request has been accepted. */
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Employees {
  get is ArmResourceRead<Employee>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Employee>;
  update is ArmResourcePatchSync<Employee, EmployeeProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Employee>;
  listByResourceGroup is ArmResourceListByParent<Employee>;
  listBySubscription is ArmListBySubscription<Employee>;
}
