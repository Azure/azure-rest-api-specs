import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./likesTea.tsp";
import "./provisioningState.tsp";

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
  /** First name of employee */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  firstName: string;

  /** Middle name of employee */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  middleName?: string;

  /** Last name of employee */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  lastName: string;

  /** Identification number of employee assigned at creation */
  @visibility(Lifecycle.Read)
  identificationNumber?: string;

  /** Group of employee */
  group: string;

  /** Boolean indicating whether the employee likes tea or not */
  likesTea: likesTea;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Employees {
  get is ArmResourceRead<Employee>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Employee>;
  update is ArmResourcePatchSync<Employee, EmployeeProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Employee>;
  listByResourceGroup is ArmResourceListByParent<Employee>;
  listBySubscription is ArmListBySubscription<Employee>;
}
