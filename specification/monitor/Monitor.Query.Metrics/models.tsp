import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace MonitorQueryMetrics;

/** The unit of the metric. */
union MetricUnit {
  string,

  /** Unit of raw quantity. */
  Count: "Count",

  /** Unit of memory in bytes. */
  Bytes: "Bytes",

  /** Unit of time in seconds. */
  Seconds: "Seconds",

  /** Rate unit of raw quantity per second. */
  CountPerSecond: "CountPerSecond",

  /** Rate unit of memory in bytes per second. */
  BytesPerSecond: "BytesPerSecond",

  /** Percentage unit. */
  Percent: "Percent",

  /** Unit of time in 1/1000th of a second. */
  MilliSeconds: "MilliSeconds",

  /**
   * Unit of data transfer or storage. It is the size of the data in bytes
   * multiplied by the time it takes to transfer or store the data in seconds.
   */
  ByteSeconds: "ByteSeconds",

  /** No specified unit. */
  Unspecified: "Unspecified",

  /** Unit of processing power. */
  Cores: "Cores",

  /** Unit of processing power in 1/1000th of a CPU core. */
  MilliCores: "MilliCores",

  /** Unit of processing power in one billionth of a CPU core. */
  NanoCores: "NanoCores",

  /** Rate unit of binary digits per second. */
  BitsPerSecond: "BitsPerSecond",
}

/** The comma separated list of resource IDs to query metrics for. */
model ResourceIdList {
  /** The list of resource IDs to query metrics for. */
  resourceids?: Azure.Core.armResourceIdentifier[];
}

/** The metrics result for a resource. */
model MetricResultsResponse {
  /** The collection of metric data responses per resource, per metric. */
  values?: MetricResultsResponseValuesItem[];
}

/** The metric data response for a resource. */
model MetricResultsResponseValuesItem {
  /** The start time, in datetime format, for which the data was retrieved. */
  starttime: string;

  /** The end time, in datetime format, for which the data was retrieved. */
  endtime: string;

  /**
   * The interval (window size) for which the metric data was returned in ISO 8601
   * duration format with a special case for 'FULL' value that returns single
   * datapoint for entire time span requested (*Examples: PT15M, PT1H, P1D, FULL*).
   * This may be adjusted and different from what was originally requested if
   * AutoAdjustTimegrain=true is specified.
   */
  interval?: string;

  /** The namespace of the metrics been queried */
  `namespace`?: string;

  /** The region of the resource been queried for metrics. */
  resourceregion?: string;

  /** The resource that has been queried for metrics. */
  resourceid?: string;

  /** The value of the collection. */
  value: Metric[];
}

/** The result data of a query. */
model Metric {
  /** The metric Id. */
  id: string;

  /** The resource type of the metric resource. */
  type: string;

  /** The name and the display name of the metric, i.e. it is localizable string. */
  name: LocalizableString;

  /** Detailed description of this metric. */
  displayDescription?: string;

  /** 'Success' or the error details on query failures for this metric. */
  errorCode?: string;

  /** Error message encountered querying this specific metric. */
  errorMessage?: string;

  /** The unit of the metric. */
  unit: MetricUnit;

  /** The time series returned when a data query is performed. */
  @identifiers(#[])
  timeseries: TimeSeriesElement[];
}

/** The localizable string class. */
model LocalizableString {
  /** The invariant value. */
  value: string;

  /** The display name. */
  localizedValue?: string;
}

/**
 * A time series result type. The discriminator value is always TimeSeries in this
 * case.
 */
model TimeSeriesElement {
  /** The metadata values returned if $filter was specified in the call. */
  @identifiers(#["name"])
  metadatavalues?: MetadataValue[];

  /**
   * An array of data points representing the metric values.  This is only returned
   * if a result type of data is specified.
   */
  @identifiers(#["timeStamp"])
  data?: MetricValue[];
}

/** Represents a metric metadata value. */
model MetadataValue {
  /** The name of the metadata. */
  name?: LocalizableString;

  /** The value of the metadata. */
  value?: string;
}

/** Represents a metric value. */
model MetricValue {
  /** The timestamp for the metric value in ISO 8601 format. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp: utcDateTime;

  /** The average value in the time range. */
  average?: float64;

  /** The least value in the time range. */
  minimum?: float64;

  /** The greatest value in the time range. */
  maximum?: float64;

  /** The sum of all of the values in the time range. */
  total?: float64;

  /**
   * The number of samples in the time range. Can be used to determine the number of
   * values that contributed to the average value.
   */
  count?: float64;
}
