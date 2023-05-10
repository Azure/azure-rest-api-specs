import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateEntireSeries, false)

@@projectedName(AnomalyDetector.Multivariate.ModelDetails.dataSource, "java", "dataSourceUri");  // Prefer a different name for java only
@@projectedName(AnomalyDetector.Multivariate.ModelDetails.dataSource, "csharp", "dataSourceUri"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.ModelDetails.endTime, "csharp", "endsOn"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.ModelDetails.startTime, "csharp", "starsOn"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Multivariate.AnomalyValue.interpretation, "csharp", "interpretations"); // Prefer a different name for C# only
@@projectedName(AnomalyDetector.Univariate.DetectUnivariateLastPoint, "java", "detectUnivariateLastAnomaly"); // Prefer a different name for java only