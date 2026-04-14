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

/** A Widget Employee resource */
model Employee is TrackedResource<EmployeeProperties> {
  ...ResourceNameParameter<Employee>;
}

/** Employee properties */
model EmployeeProperties {
  /** Age of employee (before 2025-11-01) */
  @removed(Versions.v2024_10_01_preview)
  @renamedFrom(Versions.v2024_10_01_preview, "age")
  oldAge?: int32;

  /** Age of employee (from 2025-11-01 onward, default is 21) */
  @added(Versions.v2024_10_01_preview)
  age?: int32 = 21;

  /** City of employee */
  city?: string;

  /** Work location of employee */
  @added(Versions.v2024_10_01_preview)
  workLocation?: WorkLocation;

  /** Profile of employee */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
  
  /** The assets belong to the employee. */
  @typeChangedFrom(Versions.v2024_10_01_preview, string[])
  assets: AssetItem[];
}

/** Constrained asset item. */
@added(Versions.v2024_10_01_preview)
@minLength(3)
@maxLength(10)
scalar AssetItem extends string;

/** Work location details */
@added(Versions.v2024_10_01_preview)
model WorkLocation {
  /** Country */
  country?: string;

  /** Company */
  company?: string;

  /** Seat number */
  seatNumber?: string;
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
  update is ArmCustomPatchSync<
    Employee,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Employee,
      EmployeeProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Employee>;
  listByResourceGroup is ArmResourceListByParent<Employee>;
  listBySubscription is ArmListBySubscription<Employee>;
}
