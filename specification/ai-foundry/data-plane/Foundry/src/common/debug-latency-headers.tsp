import "@typespec/http";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * Optional request header controlling hosted-agent diagnostic latency reporting.
 * Applies to supported invoke, endpoint-response, and session operations.
 */
alias DebugLatencyRequestHeader = {
  /**
   * When omitted, live latency headers and persistence for later retrieval are
   * enabled. `true` additionally requests the best-effort `x-ms-debug-latency-final`
   * HTTP response trailer on supported HTTP/2+ transports. `false` disables live
   * reporting and persistence, or suppresses an existing snapshot on a GET.
   * Empty, malformed, or multi-valued values also disable reporting.
   *
   * The final trailer is not an ordinary response header. Its semicolon-delimited
   * fields are `v=1`, `start`, `platform_pre_ms`, `infra_ms`, `ready_ms`,
   * `container_response_ms`, `response_begin_ms`, optional `first_byte_ms`, and
   * `total_last_byte_ms`. Provisioning fields are omitted on warm requests.
   * `post_upstream_finalize_ms` is reserved and is not currently emitted.
   * The trailer may be absent on errors, cancellation, disconnect, WebSocket
   * upgrade, or transports that do not preserve trailers. Clients must not require it.
   */
  @header("x-ms-debug-latency-enabled")
  debugLatencyEnabled?: boolean;
};

/**
 * Platform-side latency headers shared by hosted-agent requests and session provisioning.
 * Durations are whole milliseconds and are diagnostic signals, not SLA or billing metrics.
 * Headers are optional: unavailable measurements are omitted rather than reported as zero.
 * The `x-ms-debug-latency-*` namespace is service-owned; container values are not trusted.
 */
alias DebugLatencyPlatformResponseHeaders = {
  /**
   * The session start type: `cold`, `warm`, or `resume`.
   */
  @header("x-ms-debug-latency-session-start-type")
  debugLatencySessionStartType?: string;

  /**
   * Residual platform service time not attributed to infrastructure setup or container
   * readiness. For session provisioning, this starts at session-provisioning start
   * and excludes the triggering request's admission, authentication, and routing.
   */
  @minValue(0)
  @header("x-ms-debug-latency-platform-preprocessing-ms")
  debugLatencyPlatformPreprocessingMs?: int64;

  /**
   * Infrastructure session-resource provisioning time. Omitted on warm requests.
   * If ordered provisioning boundaries were not captured, this measurement is
   * omitted and its time is included in platform preprocessing.
   */
  @minValue(0)
  @header("x-ms-debug-latency-infra-setup-ms")
  debugLatencyInfraSetupMs?: int64;

  /**
   * Time from sandbox creation to successful container readiness. Omitted on warm
   * requests or when provisioning boundaries were not captured.
   */
  @minValue(0)
  @header("x-ms-debug-latency-container-readiness-ms")
  debugLatencyContainerReadinessMs?: int64;
};

/**
 * Live latency response headers for successful hosted-agent invoke and endpoint-response calls.
 * Platform preprocessing, infrastructure setup, container readiness, and container
 * response sum to response-begin time. During recovery, resumed provisioning is
 * excluded from container-response time to avoid double counting.
 */
alias DebugLatencyResponseHeaders = {
  ...DebugLatencyPlatformResponseHeaders;

  /**
   * Time from proxy forwarding start to client response-header commit, including
   * request transfer, connection setup, agent handling, retries, and output-policy
   * buffering, but excluding separately attributed resumed provisioning.
   */
  @minValue(0)
  @header("x-ms-debug-latency-container-response-ms")
  debugLatencyContainerResponseMs?: int64;

  /**
   * Time from request acceptance to client response-header commit. This is not
   * time to the first response-body byte or first server-sent event.
   */
  @minValue(0)
  @header("x-ms-debug-latency-response-begin-ms")
  debugLatencyResponseBeginMs?: int64;
};

/**
 * Persisted latency response headers on GET responses and invocations.
 * Values describe the original create call, not the GET. Persistence is eventually
 * consistent, so a GET immediately after creation may return no measurements.
 * For asynchronous creates, only platform-side measurements are available;
 * container-response, response-begin, and body-completion measurements are omitted.
 * These are ordinary response headers; GET does not emit the final trailer.
 */
alias PersistedDebugLatencyResponseHeaders = {
  ...DebugLatencyResponseHeaders;

  /**
   * Time from request acceptance to the first response-body byte. Omitted when
   * no first byte was captured, including an empty-body response.
   * On live create calls this measurement is available only in the final trailer.
   */
  @minValue(0)
  @header("x-ms-debug-latency-first-byte-ms")
  debugLatencyFirstByteMs?: int64;

  /**
   * Time from upstream response-body completion to forwarding completion.
   * Best-effort and currently not emitted.
   */
  @minValue(0)
  @header("x-ms-debug-latency-post-upstream-finalize-ms")
  debugLatencyPostUpstreamFinalizeMs?: int64;

  /**
   * Time from request acceptance to response-body forwarding completion.
   * On live create calls this measurement is available only in the final trailer.
   */
  @minValue(0)
  @header("x-ms-debug-latency-total-last-byte-ms")
  debugLatencyTotalLastByteMs?: int64;
};

/**
 * Session-provisioning response headers on explicit session creation and on GET
 * retrieval of a persisted session snapshot, including implicit or WebSocket creates.
 * Warm requests have no session-provisioning breakdown. No container-response,
 * response-begin, or body-completion measurements are included.
 */
alias SessionDebugLatencyResponseHeaders = {
  ...DebugLatencyPlatformResponseHeaders;

  /**
   * Time from session-provisioning start to successful container readiness, excluding
   * the triggering request's admission, authentication, and routing.
   * Platform preprocessing, infrastructure setup, and container readiness sum to
   * this total. GET values describe the original provisioning, not the GET.
   */
  @minValue(0)
  @header("x-ms-debug-latency-session-total-ms")
  debugLatencySessionTotalMs?: int64;
};
