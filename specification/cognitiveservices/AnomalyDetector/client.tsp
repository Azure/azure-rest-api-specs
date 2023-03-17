import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@convenientAPI(AnomalyDetector.Multivariate.GetMultivariateBatchDetectionResult, true)
@@convenientAPI(AnomalyDetector.Multivariate.TrainMultivariateModel, true)
@@convenientAPI(AnomalyDetector.Multivariate.ListMultivariateModels, true)
@@convenientAPI(AnomalyDetector.Multivariate.DeleteMultivariateModel, true)
@@convenientAPI(AnomalyDetector.Multivariate.GetMultivariateModel, true)
@@convenientAPI(AnomalyDetector.Multivariate.DetectMultivariateBatchAnomaly, true)
@@convenientAPI(AnomalyDetector.Multivariate.DetectMultivariateLastAnomaly, true)

@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateEntireSeries, true)
@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateLastPoint, true)
@@convenientAPI(AnomalyDetector.Univariate.DetectUnivariateChangePoint, true)
