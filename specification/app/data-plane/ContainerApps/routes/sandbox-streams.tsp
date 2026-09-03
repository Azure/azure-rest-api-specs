using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** OK. */
model GetSandboxExecStreamResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

/** OK. */
model GetSandboxLogStreamResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

/** OK. */
model GetSandboxProcessesStreamResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("sandboxes")
interface SandboxStreamsOperations {
  /** Starts an interactive exec session via WebSocket in a running sandbox. */
  @summary("Starts an interactive exec session via WebSocket in a running sandbox.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/exec/stream")
  @get
  getSandboxExecStream is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;

      /** user parameter. */
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

      /** id parameter. */
      @path id: string;

      /** tailLines parameter. */
      @query tailLines?: int32;

      /** logFormat parameter. */
      @query logFormat?: LogFormat;

      /** follow parameter. */
      @query follow?: boolean;

      /** containerName parameter. */
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

      /** id parameter. */
      @path id: string;

      /** containerName parameter. */
      @query containerName?: string;
    },
    GetSandboxProcessesStreamResult,
    DataPlaneStandardTraits,
    never
  >;
}
