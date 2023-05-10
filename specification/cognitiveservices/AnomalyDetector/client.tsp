import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateEntireSeries, false)

@@projectedName(AnomalyDetector.Multivariate.ModelDetails.dataSource, "java", "dataSourceUri");  // Prefer a different name for java only
@@projectedName(AnomalyDetector.Multivariate.ModelDetails.dataSource, "csharp", "dataSourceUri"); // Prefer a different name for C# only