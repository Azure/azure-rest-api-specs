import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace AzureMonitorExporter;

/**
 * This operation sends a sequence of telemetry events that will be monitored by
 * Azure Monitor.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
@summary("Track telemetry events")
@route("/track")
@post
op track(
  /**
   * The list of telemetry events to track.
   */
  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Raw array type used for backward compatibility"
  @bodyRoot
  body: TelemetryEnvelope[],

  /**
   * Body Parameter content-type
   */
  @header("content-type")
  contentType: "application/json",
): {
  /** All of the telemetry items were accepted and processed. */
  @statusCode statusCode: 200;

  @body body: TrackResponse;
} | {
  /** Partial success. Some of the telemetry items were accepted and processed. */
  @statusCode statusCode: 206;

  @body body: TrackResponse;
} | TrackResponseError;
