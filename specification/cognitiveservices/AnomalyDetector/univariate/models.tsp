import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace AnomalyDetector.Univariate;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
union ImputeMode {
  string,
  Auto: "auto",
  Previous: "previous",
  Linear: "linear",
  Fixed: "fixed",
  Zero: "zero",
  NotFill: "notFill",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
union AnomalyDetectorErrorCodes {
  string,
  "InvalidCustomInterval",
  "BadArgument",
  "InvalidGranularity",
  "InvalidPeriod",
  "InvalidModelArgument",
  "InvalidSeries",
  "InvalidJsonFormat",
  "RequiredGranularity",
  "RequiredSeries",
  "InvalidImputeMode",
  "InvalidImputeFixedValue",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
union TimeGranularity {
  string,
  Yearly: "yearly",
  Monthly: "monthly",
  Weekly: "weekly",
  Daily: "daily",
  Hourly: "hourly",
  PerMinute: "minutely",
  PerSecond: "secondly",
  Microsecond: "microsecond",
  None: "none",
}

@doc("Request of the entire or last anomaly detection.")
model UnivariateDetectionOptions {
  @doc("""
    Time series data points. Points should be sorted by time stamp in ascending
    order to match the anomaly detection result. If the data is not sorted
    correctly or there's a duplicated time stamp, the API won't work. In such
    a case, an error message is returned.
    """)
  series: TimeSeriesPoint[];

  @doc("""
    Argument that indicates time granularity. If granularity is not present, the value
    is none by default. If granularity is none, the time stamp property in the time
    series point can be absent.
    """)
  granularity?: TimeGranularity;

  @doc("""
    A custom interval is used to set a nonstandard time interval. For example, if the
    series is 5 minutes, the request can be set as {"granularity":"minutely",
    "customInterval":5}.
    """)
  customInterval?: int32;

  @doc("""
    Argument that indicates the periodic value of a time series. If the value is null or
    is not present, the API determines the period automatically.
    """)
  period?: int32;

  @doc("Argument that indicates an advanced model parameter. It's the maximum anomaly ratio in a time series.")
  maxAnomalyRatio?: float32;

  @doc("""
    Argument that indicates an advanced model parameter between 0 and 99. The lower the value
    is, the larger the margin value is, which means fewer anomalies will be
    accepted.
    """)
  sensitivity?: int32;

  @doc("""
    Specifies how to deal with missing values in the input series. It's used
    when granularity is not \"none\".
    """)
  imputeMode?: ImputeMode;

  @doc("""
    Specifies the value to fill. It's used when granularity is not \"none\"
    and imputeMode is \"fixed\".
    """)
  imputeFixedValue?: float32;
}

@doc("Definition of input time series points.")
model TimeSeriesPoint {
  @doc("Argument that indicates the time stamp of a data point (ISO8601 format).")
  timestamp?: utcDateTime;

  @doc("Measurement of that point.")
  value: float32;
}

@doc("Response of the entire anomaly detection.")
model UnivariateEntireDetectionResult {
  @doc("""
    Frequency extracted from the series. Zero means no recurrent pattern has been
    found.
    """)
  period: int32;

  @doc("""
    Expected value for each input point. The index of the
    array is consistent with the input series.
    """)
  expectedValues: float32[];

  @doc("""
    Upper margin of each input point. UpperMargin is used to
    calculate upperBoundary, which is equal to expectedValue + (100 -
    marginScale)*upperMargin. Anomalies in the response can be filtered by
    upperBoundary and lowerBoundary. Adjusting the marginScale value can help filter less
    significant anomalies on the client side. The index of the array is
    consistent with the input series.
    """)
  upperMargins: float32[];

  @doc("""
    Lower margin of each input point. LowerMargin is used to
    calculate lowerBoundary, which is equal to expectedValue - (100 -
    marginScale)*lowerMargin. Points between the boundary can be marked as normal
    ones on the client side. The index of the array is consistent with the input
    series.
    """)
  lowerMargins: float32[];

  @doc("""
    Anomaly properties for each input point. True means an
    anomaly (either negative or positive) has been detected. The index of the array
    is consistent with the input series.
    """)
  isAnomaly: boolean[];

  @doc("""
    Anomaly status in a negative direction for each input
    point. True means a negative anomaly has been detected. A negative anomaly
    means the point is detected as an anomaly and its real value is smaller than
    the expected one. The index of the array is consistent with the input series.
    """)
  isNegativeAnomaly: boolean[];

  @doc("""
    Anomaly status in a positive direction for each input
    point. True means a positive anomaly has been detected. A positive anomaly
    means the point is detected as an anomaly and its real value is larger than the
    expected one. The index of the array is consistent with the input series.
    """)
  isPositiveAnomaly: boolean[];

  @doc("""
    Severity score for each input point. The larger the value is, the more
    severe the anomaly is. For normal points, the severity is always 0.
    """)
  severity?: float32[];
}

@doc("Error information that the API returned.")
@error
model AnomalyDetectorError {
  @header("x-ms-error-code")
  @doc("Error code.")
  msErrorCode: string;

  @doc("Error code.")
  code: AnomalyDetectorErrorCodes;

  @doc("Message that explains the error that the service reported.")
  message: string;
}

@doc("Response of the last anomaly detection.")
model UnivariateLastDetectionResult {
  @doc("""
    Frequency extracted from the series. Zero means no recurrent pattern has been
    found.
    """)
  period: int32;

  @doc("Suggested input series points needed for detecting the latest point.")
  suggestedWindow: int32;

  @doc("Expected value of the latest point.")
  expectedValue: float32;

  @doc("""
    Upper margin of the latest point. UpperMargin is used to calculate
    upperBoundary, which is equal to expectedValue + (100 - marginScale)*upperMargin.
    If the value of latest point is between upperBoundary and lowerBoundary, it
    should be treated as a normal value. Adjusting the marginScale value enables the anomaly
    status of the latest point to be changed.
    """)
  upperMargin: float32;

  @doc("""
    Lower margin of the latest point. LowerMargin is used to calculate
    lowerBoundary, which is equal to expectedValue - (100 - marginScale)*lowerMargin.
    """)
  lowerMargin: float32;

  @doc("""
    Anomaly status of the latest point. True means the latest point is an anomaly,
    either in the negative direction or in the positive direction.
    """)
  isAnomaly: boolean;

  @doc("""
    Anomaly status of the latest point in a negative direction. True means the latest
    point is an anomaly and its real value is smaller than the expected one.
    """)
  isNegativeAnomaly: boolean;

  @doc("""
    Anomaly status of the latest point in a positive direction. True means the latest
    point is an anomaly and its real value is larger than the expected one.
    """)
  isPositiveAnomaly: boolean;

  @doc("""
    Severity score for the last input point. The larger the value is, the more
    severe the anomaly is. For normal points, the severity is always 0.
    """)
  severity?: float32;
}

@doc("Request of change point detection.")
model UnivariateChangePointDetectionOptions {
  @doc("""
    Time series data points. Points should be sorted by time stamp in ascending
    order to match the change point detection result.
    """)
  series: TimeSeriesPoint[];

  @doc("""
    Granularity is used to verify whether the input series is valid.
    """)
  granularity: TimeGranularity;

  @doc("""
    A custom interval is used to set a nonstandard time interval. For example, if the
    series is 5 minutes, the request can be set as {"granularity":"minutely",
    "customInterval":5}.
    """)
  customInterval?: int32;

  @doc("""
    Argument that indicates the periodic value of a time series. If the value is null or
    not present, the API will determine the period automatically.
    """)
  period?: int32;

  @doc("""
    Argument that indicates an advanced model parameter. A default stableTrendWindow value will
    be used in detection.
    """)
  stableTrendWindow?: int32;

  @doc("""
    Argument that indicates an advanced model parameter between 0.0 and 1.0. The lower the
    value is, the larger the trend error is, which means less change point will
    be accepted.
    """)
  threshold?: float32;
}

@doc("Response of change point detection.")
model UnivariateChangePointDetectionResult {
  @doc("""
    Frequency extracted from the series. Zero means no recurrent pattern has been
    found.
    """)
  @visibility(Lifecycle.Read)
  period?: int32;

  @doc("""
    Change point properties for each input point. True means
    an anomaly (either negative or positive) has been detected. The index of the
    array is consistent with the input series.
    """)
  isChangePoint?: boolean[];

  @doc("Change point confidence of each point.")
  confidenceScores?: float32[];
}
