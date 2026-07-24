import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;

namespace MdsCommon;

@doc("Represents a generic response.")
model GenericOkResponse<T> {
  @statusCode
  statusCode: 200;

  @doc("The response data.")
  @body
  data: T;
}

@doc("Represents the status of a long-running operation.")
@lroStatus
union JobStatus {
  @doc("Enabled")
  Enabled: "Enabled",

  @doc("Disabled")
  Disabled: "Disabled",

  @doc("Deleted")
  Deleted: "Deleted",

  @doc("Completed")
  Succeeded: "Completed",

  @doc("Failed")
  Failed: "Faulted",

  @doc("Suspended")
  Suspended: "Suspended",

  string,
}
