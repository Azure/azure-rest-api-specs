import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;

@doc("The provisioning state of a resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("Ring status enum.")
union RingStatus {
  string,

  @doc("Ring/Stage is waiting for its dependency.")
  Waiting: "Waiting",

  @doc("Ring/Stage started and it is in progress.")
  Active: "Active",

  @doc("Ring/Stage reached completion.")
  Completed: "Completed",

  @doc("Ring/Stage is cancelled.")
  Cancelled: "Cancelled",

  @doc("Ring/Stage is failed.")
  Failed: "Failed",

  @doc("Ring/Stage is passed for business reasons.")
  AutoPassed: "AutoPassed",

  @doc("Ring/Stage is skipped for business reasons.")
  Omitted: "Omitted",
}
