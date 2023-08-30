import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using OpenAPI;

@doc("Job REST Resource.")
model JobProperties {
  @doc("Gets operation status.")
  @visibility("read")
  status?: string;

  @doc("Gets operation start time.")
  @visibility("read")
  startTime?: string;

  @doc("Gets operation end time.")
  @visibility("read")
  endTime?: string;

  @doc("Gets or sets the display name of the Job.")
  @visibility("read")
  displayName?: string;

  @doc("Gets the client request Id used in the operation execution context.")
  @visibility("read")
  clientRequestId?: string;

  @doc("Gets the activity Id used in the operation execution context.")
  @visibility("read")
  activityId?: string;

  
  @doc("Gets the errors.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  errors?: ErrorDetails[];

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
