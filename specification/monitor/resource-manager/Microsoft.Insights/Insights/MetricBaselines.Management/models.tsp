import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * the sensitivity of the baseline.
 */
union BaselineSensitivity {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResultType {
  /**
   * Data
   */
  Data,

  /**
   * Metadata
   */
  Metadata,
}

/**
 * A list of metric baselines.
 */
model MetricBaselinesResponse {
  /**
   * The list of metric baselines.
   */
  @pageItems
  value?: SingleMetricBaseline[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The baseline results of a single metric.
 */
model SingleMetricBaseline {
  /**
   * The metric baseline Id.
   */
  id: string;

  /**
   * The resource type of the metric baseline resource.
   */
  type: string;

  /**
   * The name of the metric for which the baselines were retrieved.
   */
  name: string;

  /**
   * The metric baseline properties of the metric.
   */
  properties: MetricBaselinesProperties;
}

/**
 * The response to a metric baselines query.
 */
model MetricBaselinesProperties {
  /**
   * The timespan for which the data was retrieved. Its value consists of two datetimes concatenated, separated by '/'.  This may be adjusted in the future and returned back from what was originally requested.
   */
  timespan: string;

  /**
   * The interval (window size) for which the metric data was returned in.  This may be adjusted in the future and returned back from what was originally requested.  This is not present if a metadata request was made.
   */
  interval: duration;

  /**
   * The namespace of the metrics been queried.
   */
  `namespace`?: string;

  /**
   * The baseline for each time series that was queried.
   */
  @identifiers(#[])
  baselines: TimeSeriesBaseline[];
}

/**
 * The baseline values for a single time series.
 */
model TimeSeriesBaseline {
  /**
   * The aggregation type of the metric.
   */
  aggregation: string;

  /**
   * The dimensions of this time series.
   */
  @identifiers(#["name"])
  dimensions?: MetricSingleDimension[];

  /**
   * The list of timestamps of the baselines.
   */
  timestamps: utcDateTime[];

  /**
   * The baseline values for each sensitivity.
   */
  @identifiers(#[])
  data: SingleBaseline[];

  /**
   * The baseline metadata values.
   */
  @identifiers(#["name"])
  metadataValues?: BaselineMetadata[];
}

/**
 * The metric dimension name and value.
 */
model MetricSingleDimension {
  /**
   * Name of the dimension.
   */
  name: string;

  /**
   * Value of the dimension.
   */
  value: string;
}

/**
 * The baseline values for a single sensitivity value.
 */
model SingleBaseline {
  /**
   * the sensitivity of the baseline.
   */
  sensitivity: BaselineSensitivity;

  /**
   * The low thresholds of the baseline.
   */
  lowThresholds: float64[];

  /**
   * The high thresholds of the baseline.
   */
  highThresholds: float64[];
}

/**
 * Represents a baseline metadata value.
 */
model BaselineMetadata {
  /**
   * Name of the baseline metadata.
   */
  name: string;

  /**
   * Value of the baseline metadata.
   */
  value: string;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  error?: ErrorResponseError;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ErrorResponseError {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information. If Accept-Language is set in the request, it must be localized to that language.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of additional nested error response info objects, as described by this contract.
   */
  details?: ErrorDetail[];

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  additionalInfo?: ErrorResponseErrorAdditionalInfoItem[];
}

/**
 * Describes details of an error response.
 */
model ErrorDetail {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  additionalInfo?: ErrorDetailAdditionalInfoItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ErrorDetailAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  info?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ErrorResponseErrorAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  info?: Record<unknown>;
}
