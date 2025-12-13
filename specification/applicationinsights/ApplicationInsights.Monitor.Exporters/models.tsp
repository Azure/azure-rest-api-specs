import "@typespec/http";

using TypeSpec.Http;

namespace AzureMonitorExporter;

/**
 * Type of the metric data.
 */
union DataPointType {
  string,

  /** Single measurement. */
  Measurement: "Measurement",

  /** Aggregated value. */
  Aggregation: "Aggregation",
}

/**
 * Defines the level of severity for the event.
 */
union SeverityLevel {
  string,

  /** Verbose level. */
  Verbose: "Verbose",

  /** Information level. */
  Information: "Information",

  /** Warning level. */
  Warning: "Warning",

  /** Error level. */
  Error: "Error",

  /** Critical level. */
  Critical: "Critical",
}

/**
 * The context tag keys.
 */
union ContextTagKeys {
  string,

  /** Application version. */
  AiApplicationVer: "ai.application.ver",

  /** Device ID. */
  AiDeviceId: "ai.device.id",

  /** Device locale. */
  AiDeviceLocale: "ai.device.locale",

  /** Device model. */
  AiDeviceModel: "ai.device.model",

  /** Device OEM name. */
  AiDeviceOemName: "ai.device.oemName",

  /** Device OS version. */
  AiDeviceOSVersion: "ai.device.osVersion",

  /** Device type. */
  AiDeviceType: "ai.device.type",

  /** Location IP. */
  AiLocationIp: "ai.location.ip",

  /** Location country. */
  AiLocationCountry: "ai.location.country",

  /** Location province. */
  AiLocationProvince: "ai.location.province",

  /** Location city. */
  AiLocationCity: "ai.location.city",

  /** Operation ID. */
  AiOperationId: "ai.operation.id",

  /** Operation name. */
  AiOperationName: "ai.operation.name",

  /** Operation parent ID. */
  AiOperationParentId: "ai.operation.parentId",

  /** Operation synthetic source. */
  AiOperationSyntheticSource: "ai.operation.syntheticSource",

  /** Operation correlation vector. */
  AiOperationCorrelationVector: "ai.operation.correlationVector",

  /** Session ID. */
  AiSessionId: "ai.session.id",

  /** If session is the first one. */
  AiSessionIsFirst: "ai.session.isFirst",

  /** User account ID. */
  AiUserAccountId: "ai.user.accountId",

  /** User ID. */
  AiUserId: "ai.user.id",

  /** Authenticated user ID. */
  AiUserAuthUserId: "ai.user.authUserId",

  /** Cloud role. */
  AiCloudRole: "ai.cloud.role",

  /** Cloud role version. */
  AiCloudRoleVer: "ai.cloud.roleVer",

  /** Cloud role instance. */
  AiCloudRoleInstance: "ai.cloud.roleInstance",

  /** Cloud location. */
  AiCloudLocation: "ai.cloud.location",

  /** Internal SDK version. */
  AiInternalSdkVersion: "ai.internal.sdkVersion",

  /** Internal agent version. */
  AiInternalAgentVersion: "ai.internal.agentVersion",

  /** Internal node name. */
  AiInternalNodeName: "ai.internal.nodeName",
}

/**
 * System variables for a telemetry item.
 */
model TelemetryEnvelope {
  /**
   * Envelope version. For internal use only. By assigning this the default, it will
   * not be serialized within the payload unless changed to a value other than #1.
   */
  ver?: int32 = 1;

  /**
   * Type name of telemetry data item.
   */
  name: string;

  /**
   * Event date time when telemetry item was created. This is the wall clock time on
   * the client when the event was generated. There is no guarantee that the
   * client's time is accurate. This field must be formatted in UTC ISO 8601 format,
   * with a trailing 'Z' character, as described publicly on
   * https://en.wikipedia.org/wiki/ISO_8601#UTC. Note: the number of decimal seconds
   * digits provided are variable (and unspecified). Consumers should handle this,
   * i.e. managed code consumers should not use format 'O' for parsing as it
   * specifies a fixed length. Example: 2009-06-15T13:45:30.0000000Z.
   */
  time: utcDateTime;

  /**
   * Sampling rate used in application. This telemetry item represents 100 /
   * sampleRate actual telemetry items.
   */
  sampleRate?: float32 = 100;

  /**
   * Sequence field used to track absolute order of uploaded events.
   */
  @maxLength(64)
  seq?: string;

  /**
   * The instrumentation key of the Application Insights resource.
   */
  iKey?: string;

  /**
   * Key/value collection of context properties. See ContextTagKeys for information
   * on available properties.
   */
  tags?: Record<string>;

  /**
   * Telemetry data item.
   */
  data?: Base;
}

/**
 * Data struct to contain only C section with custom fields.
 */
model Base {
  /**
   * Name of item (B section) if any. If telemetry data is derived straight from
   * this, this should be null.
   */
  baseType?: string;

  /**
   * The data payload for the telemetry request
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
  baseData?: Domain;
}

/**
 * The abstract common base of all domains.
 */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model Domain {
  ...Record<unknown>;

  /**
   * Schema version
   */
  ver: int32 = 2;
}

/**
 * Response containing the status of each telemetry item.
 */
model TrackResponse {
  /**
   * The number of items received.
   */
  itemsReceived?: int32;

  /**
   * The number of items accepted.
   */
  itemsAccepted?: int32;

  /**
   * An array of error detail objects.
   */
  errors?: ErrorDetails[];
}
/**
 * Error response containing the status of each telemetry item.
 */
@error
model TrackResponseError {
  /** Error status codes. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Allows these specific status codes"
  @statusCode
  statusCode: 400 | 402 | 429 | 500 | 503;

  /**
   * Response containing the status of each telemetry item.
   */
  @body
  body: TrackResponse;
}
/**
 * The error details
 */
model ErrorDetails {
  /**
   * The index in the original payload of the item.
   */
  index?: int32;

  /**
   * The item specific [HTTP Response status code](#Response Status Codes).
   */
  statusCode?: int32;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Instances of AvailabilityData represent the result of executing an availability
 * test.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model AvailabilityData extends Domain {
  /**
   * Identifier of a test run. Use it to correlate steps of test run and telemetry
   * generated by the service.
   */
  @maxLength(512)
  id: string;

  /**
   * Name of the test that these availability results represent.
   */
  @maxLength(1024)
  name: string;

  /**
   * Duration in format: DD.HH:MM:SS.MMMMMM. Must be less than 1000 days.
   */
  duration: string;

  /**
   * Success flag.
   */
  success: boolean;

  /**
   * Name of the location where the test was run from.
   */
  @maxLength(1024)
  runLocation?: string;

  /**
   * Diagnostic message for the result.
   */
  @maxLength(8192)
  message?: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * Metric data single measurement.
 */
model DataPoint {
  /**
   * Namespace of the metric.
   */
  @maxLength(256)
  ns?: string;

  /**
   * Name of the metric.
   */
  @maxLength(1024)
  name: string;

  /**
   * Metric type. Single measurement or the aggregated value.
   */
  kind?: DataPointType;

  /**
   * Single value for measurement. Sum of individual measurements for the
   * aggregation.
   */
  value: float64;

  /**
   * Metric weight of the aggregated metric. Should not be set for a measurement.
   */
  count?: int32;

  /**
   * Minimum value of the aggregated metric. Should not be set for a measurement.
   */
  min?: float64;

  /**
   * Maximum value of the aggregated metric. Should not be set for a measurement.
   */
  max?: float64;

  /**
   * Standard deviation of the aggregated metric. Should not be set for a
   * measurement.
   */
  stdDev?: float64;
}

/**
 * Instances of Event represent structured event records that can be grouped and
 * searched by their properties. Event data item also creates a metric of event
 * count by name.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model EventData extends Domain {
  /**
   * Event name. Keep it low cardinality to allow proper grouping and useful metrics.
   */
  @maxLength(512)
  name: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * An instance of Exception represents a handled or unhandled exception that
 * occurred during execution of the monitored application.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model ExceptionData extends Domain {
  /**
   * Exception chain - list of inner exceptions.
   */
  exceptions: ExceptionDetails[];

  /**
   * Severity level. Mostly used to indicate exception severity level when it is
   * reported by logging library.
   */
  severityLevel?: SeverityLevel;

  /**
   * Identifier of where the exception was thrown in code. Used for exceptions
   * grouping. Typically a combination of exception type and a function from the
   * call stack.
   */
  @maxLength(1024)
  problemId?: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * Exception details of the exception in a chain.
 */
model ExceptionDetails {
  /**
   * In case exception is nested (outer exception contains inner one), the id and
   * outerId properties are used to represent the nesting.
   */
  id?: int32;

  /**
   * The value of outerId is a reference to an element in ExceptionDetails that
   * represents the outer exception
   */
  outerId?: int32;

  /**
   * Exception type name.
   */
  @maxLength(1024)
  typeName?: string;

  /**
   * Exception message.
   */
  @maxLength(32768)
  message: string;

  /**
   * Indicates if full exception stack is provided in the exception. The stack may
   * be trimmed, such as in the case of a StackOverflow exception.
   */
  hasFullStack?: boolean = true;

  /**
   * Text describing the stack. Either stack or parsedStack should have a value.
   */
  @maxLength(32768)
  stack?: string;

  /**
   * List of stack frames. Either stack or parsedStack should have a value.
   */
  parsedStack?: StackFrame[];
}

/**
 * Stack frame information.
 */
model StackFrame {
  /** Level in the stack. */
  level: int32;

  /**
   * Method name.
   */
  @maxLength(1024)
  method: string;

  /**
   * Name of the assembly (dll, jar, etc.) containing this function.
   */
  @maxLength(1024)
  assembly?: string;

  /**
   * File name or URL of the method implementation.
   */
  @maxLength(1024)
  fileName?: string;

  /**
   * Line number of the code implementation.
   */
  line?: int32;
}

/**
 * Instances of Message represent printf-like trace statements that are
 * text-searched. Log4Net, NLog and other text-based log file entries are
 * translated into instances of this type. The message does not have measurements.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model MessageData extends Domain {
  /**
   * Trace message
   */
  @maxLength(32768)
  message: string;

  /**
   * Trace severity level.
   */
  severityLevel?: SeverityLevel;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * An instance of the Metric item is a list of measurements (single data points)
 * and/or aggregations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model MetricsData extends Domain {
  /**
   * List of metrics. Only one metric in the list is currently supported by
   * Application Insights storage. If multiple data points were sent only the first
   * one will be used.
   */
  metrics: DataPoint[];

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;
}

/**
 * An instance of PageView represents a generic action on a page like a button
 * click. It is also the base type for PageView.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model PageViewData extends Domain {
  /**
   * Identifier of a page view instance. Used for correlation between page view and
   * other telemetry items.
   */
  @maxLength(512)
  id: string;

  /**
   * Event name. Keep it low cardinality to allow proper grouping and useful metrics.
   */
  @maxLength(512)
  name: string;

  /**
   * Request URL with all query string parameters
   */
  @maxLength(2048)
  url?: string;

  /**
   * Request duration in format: DD.HH:MM:SS.MMMMMM. For a page view (PageViewData),
   * this is the duration. For a page view with performance information
   * (PageViewPerfData), this is the page load time. Must be less than 1000 days.
   */
  duration?: string;

  /**
   * Fully qualified page URI or URL of the referring page; if unknown, leave blank
   */
  @maxLength(2048)
  referredUri?: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * An instance of PageViewPerf represents: a page view with no performance data, a
 * page view with performance data, or just the performance data of an earlier
 * page request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model PageViewPerfData extends Domain {
  /**
   * Identifier of a page view instance. Used for correlation between page view and
   * other telemetry items.
   */
  @maxLength(512)
  id: string;

  /**
   * Event name. Keep it low cardinality to allow proper grouping and useful metrics.
   */
  @maxLength(512)
  name: string;

  /**
   * Request URL with all query string parameters
   */
  @maxLength(2048)
  url?: string;

  /**
   * Request duration in format: DD.HH:MM:SS.MMMMMM. For a page view (PageViewData),
   * this is the duration. For a page view with performance information
   * (PageViewPerfData), this is the page load time. Must be less than 1000 days.
   */
  duration?: string;

  /**
   * Performance total in TimeSpan 'G' (general long) format: d:hh:mm:ss.fffffff
   */
  perfTotal?: string;

  /**
   * Network connection time in TimeSpan 'G' (general long) format:
   * d:hh:mm:ss.fffffff
   */
  networkConnect?: string;

  /**
   * Sent request time in TimeSpan 'G' (general long) format: d:hh:mm:ss.fffffff
   */
  sentRequest?: string;

  /**
   * Received response time in TimeSpan 'G' (general long) format: d:hh:mm:ss.fffffff
   */
  receivedResponse?: string;

  /**
   * DOM processing time in TimeSpan 'G' (general long) format: d:hh:mm:ss.fffffff
   */
  domProcessing?: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * An instance of Remote Dependency represents an interaction of the monitored
 * component with a remote component/service like SQL or an HTTP endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model RemoteDependencyData extends Domain {
  /**
   * Identifier of a dependency call instance. Used for correlation with the request
   * telemetry item corresponding to this dependency call.
   */
  @maxLength(512)
  id?: string;

  /**
   * Name of the command initiated with this dependency call. Low cardinality value.
   * Examples are stored procedure name and URL path template.
   */
  @maxLength(1024)
  name: string;

  /**
   * Result code of a dependency call. Examples are SQL error code and HTTP status
   * code.
   */
  @maxLength(1024)
  resultCode?: string;

  /**
   * Command initiated by this dependency call. Examples are SQL statement and HTTP
   * URL with all query parameters.
   */
  @maxLength(8192)
  data?: string;

  /**
   * Dependency type name. Very low cardinality value for logical grouping of
   * dependencies and interpretation of other fields like commandName and
   * resultCode. Examples are SQL, Azure table, and HTTP.
   */
  @maxLength(1024)
  type?: string;

  /**
   * Target site of a dependency call. Examples are server name, host address.
   */
  @maxLength(1024)
  target?: string;

  /**
   * Request duration in format: DD.HH:MM:SS.MMMMMM. Must be less than 1000 days.
   */
  duration: string;

  /**
   * Indication of successful or unsuccessful call.
   */
  success?: boolean = true;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}

/**
 * An instance of Request represents completion of an external request to the
 * application to do work and contains a summary of that request execution and the
 * results.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "For backward compatibility"
model RequestData extends Domain {
  /**
   * Identifier of a request call instance. Used for correlation between request and
   * other telemetry items.
   */
  @maxLength(512)
  id: string;

  /**
   * Name of the request. Represents code path taken to process request. Low
   * cardinality value to allow better grouping of requests. For HTTP requests it
   * represents the HTTP method and URL path template like 'GET /values/{id}'.
   */
  @maxLength(1024)
  name?: string;

  /**
   * Request duration in format: DD.HH:MM:SS.MMMMMM. Must be less than 1000 days.
   */
  duration: string;

  /**
   * Indication of successful or unsuccessful call.
   */
  success: boolean = true;

  /**
   * Result of a request execution. HTTP status code for HTTP requests.
   */
  @maxLength(1024)
  responseCode: string;

  /**
   * Source of the request. Examples are the instrumentation key of the caller or
   * the ip address of the caller.
   */
  @maxLength(1024)
  source?: string;

  /**
   * Request URL with all query string parameters.
   */
  @maxLength(2048)
  url?: string;

  /**
   * Collection of custom properties.
   */
  properties?: Record<string>;

  /**
   * Collection of custom measurements.
   */
  measurements?: Record<float64>;
}
