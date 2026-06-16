import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.MachineLearningServices;

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility(Lifecycle.Read)
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility(Lifecycle.Read)
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility(Lifecycle.Read)
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}

@doc("Settings for online request configuration.")
model OnlineRequestSettings {
  @doc("The timeout duration for requests.")
  requestTimeout: duration;

  @doc("The maximum number of concurrent requests per instance.")
  maxConcurrentRequestsPerInstance: int32;
}

@doc("LongRunningNullResponse")
model LongRunningNullResponse {
  @doc("Polling Uri.")
  @pollingLocation
  location: ResourceLocation<ResourceOperationStatus<PutAssetLROResponse>>;
}

@doc("PutAssetLROResponse")
model PutAssetLROResponse {
  @doc("Response of completed put asset lro.")
  assetId: string;
}

@doc("Settings for probe configuration.")
model ProbeSettings {
  @doc("The initial delay before starting probes.")
  initialDelay?: duration;

  @doc("The period between probe executions.")
  period: duration;

  @doc("The timeout duration for each probe.")
  timeout: duration;

  @doc("The number of consecutive failures required to consider the probe as failed.")
  failureThreshold: int32;

  @doc("The number of consecutive successes required to consider the probe as successful.")
  successThreshold: int32;

  @doc("The path for the probe request.")
  path: string;

  @doc("The port number for the probe.")
  port: int32;

  @doc("The scheme for the probe (e.g., HTTP, HTTPS).")
  scheme: string;

  @doc("The HTTP method for the probe request.")
  httpMethod: string;
}
