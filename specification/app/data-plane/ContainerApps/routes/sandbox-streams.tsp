using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** The HTTP 200 response for the getSandboxExecStream operation. */
model GetSandboxExecStreamResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;
}

/** The HTTP 200 response for the getSandboxLogStream operation. */
model GetSandboxLogStreamResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;
}

/** The HTTP 200 response for the getSandboxProcessesStream operation. */
model GetSandboxProcessesStreamResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
@tag("sandboxes")
interface SandboxStreamsOperations {
  /** Starts an interactive exec session via WebSocket in a running sandbox. */
  @summary("Starts an interactive exec session via WebSocket in a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/exec/stream")
  @get
  getSandboxExecStream is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The container where the interactive session runs. */
      @query containerName?: string;

      /** The user for the interactive session. */
      @query user?: string;
    },
    GetSandboxExecStreamResult,
    DataPlaneStandardTraits,
    never
  >;

  /** Streams logs from a running sandbox via WebSocket. The logs are sent as a continuous stream of text or JSON objects, depending on the specified log format. */
  @summary("Streams logs from a running sandbox via WebSocket.\nThe logs are sent as a continuous stream of text or JSON objects, depending on the specified log format.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/logstream")
  @get
  getSandboxLogStream is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The number of recent log lines to return. */
      @query tailLines?: int32;

      /** The format of streamed log records. */
      @query logFormat?: LogFormat;

      /** Whether to continue streaming new log records. */
      @query follow?: boolean;

      /** The container whose logs are streamed. */
      @query containerName?: string;
    },
    GetSandboxLogStreamResult,
    DataPlaneStandardTraits,
    never
  >;

  /** Streams the process list from a running sandbox via WebSocket. The process list is sent as a continuous stream of JSON objects. */
  @summary("Streams the process list from a running sandbox via WebSocket.\nThe process list is sent as a continuous stream of JSON objects.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/processes/stream")
  @get
  getSandboxProcessesStream is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** The sandbox identifier. */
      @path id: SandboxId;

      /** The container whose processes are streamed. */
      @query containerName?: string;
    },
    GetSandboxProcessesStreamResult,
    DataPlaneStandardTraits,
    never
  >;
}
