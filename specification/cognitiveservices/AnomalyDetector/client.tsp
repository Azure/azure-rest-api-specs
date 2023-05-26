import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateEntireSeries, false)

@@projectedName(AnomalyDetector.Multivariate.MultivariateModelDetails.dataSource, "java", "dataSourceUrl");  // Prefer a different name for java only
@@projectedName(AnomalyDetector.Multivariate.MultivariateModelDetails.dataSource, "csharp", "dataSourceUri"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.MultivariateModelDetails.endTime, "csharp", "endsOn"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.MultivariateModelDetails.startTime, "csharp", "startsOn"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.DataPointDetails.interpretation, "csharp", "interpretations"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.DataPointDetails.interpretation, "java", "interpretations"); // Prefer a different name for java only
@@projectedName(AnomalyDetector.Multivariate.MultivariateBatchDetectionResultSummary.setupInfo, "java", "batchDetectionSettings"); // Prefer a different name for java only
@@projectedName(AnomalyDetector.Univariate.DetectUnivariateLastPoint, "client", "detectUnivariateLastAnomaly"); // Use detectUnivariateLastAnomaly in all clients
@@projectedName(AnomalyDetector.Univariate.UnivariateEntireDetectionResult.isAnomaly, "client", "isAnomalyList"); // Use isAnomalyList in all clients
@@projectedName(AnomalyDetector.Univariate.UnivariateEntireDetectionResult.isNegativeAnomaly, "client", "isNegativeAnomalyList"); // Use isNegativeAnomalyList in all clients
@@projectedName(AnomalyDetector.Univariate.UnivariateEntireDetectionResult.isPositiveAnomaly, "client", "isPositiveAnomalyList"); // Use isPositiveAnomalyList in all clients
@@projectedName(AnomalyDetector.Univariate.UnivariateEntireDetectionResult.severity, "client", "severities"); // Use severities in all clients