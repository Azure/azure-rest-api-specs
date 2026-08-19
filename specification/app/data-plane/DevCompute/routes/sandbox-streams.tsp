using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

@tag("DataPlaneSandboxAzureStream")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/exec/stream")
@get
@summary("Starts an interactive exec session via WebSocket in a running sandbox.")
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/exec/stream' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_exec_stream'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_exec_stream(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query containerName?: string,
  @query user?: string,
  ...ApiVersionParameter,
): OkResponse;

@tag("DataPlaneSandboxAzureStream")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/processes/stream")
@get
@summary("""
  Streams the process list from a running sandbox via WebSocket.
  The process list is sent as a continuous stream of JSON objects.
  """)
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/processes/stream' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_processes_stream'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_processes_stream(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,
  @query containerName?: string,
  ...ApiVersionParameter,
): OkResponse;

@tag("DataPlaneSandboxAzureStream")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/logstream")
@get
@summary("""
  Streams logs from a running sandbox via WebSocket.
  The logs are sent as a continuous stream of text or JSON objects, depending on the specified log format.
  """)
// FIXME: Open API operation 'GET /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/sandboxes/{id}/logstream' is missing an operationId. Generated: 'get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_logstream'
op get_subscriptions_subscriptionId_resourceGroups_resourceGroupName_sandboxGroups_sandboxGroupName_sandboxes_id_logstream(
  @path subscriptionId: string,
  @path resourceGroupName: string,
  @path sandboxGroupName: string,
  @path id: string,

  @query
  tailLines?: Int32OrString = 100,

  @query logFormat?: LogFormat,
  @query follow?: boolean = true,
  @query containerName?: string,
  ...ApiVersionParameter,
): OkResponse;
