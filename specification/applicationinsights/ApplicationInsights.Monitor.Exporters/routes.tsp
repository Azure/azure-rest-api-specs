import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace AzureMonitorExporters;

/**
 * This operation sends a sequence of telemetry events that will be monitored by
 * Azure Monitor.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@summary("Track telemetry events")
@route("/track")
@post
op track is Azure.Core.Foundations.Operation<
  {
    /**
     * Body Parameter content-type
     */
    @header("content-type   ")
    contentType: "application/json";

    /**
     * The list of telemetry events to track.
     */
    @bodyRoot
    body: TelemetryEnvelope[];
  },
  TrackResponse
>;
