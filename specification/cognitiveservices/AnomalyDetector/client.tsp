import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@convenientAPI(AnomalyDetector.Univariate.detectUnivariateEntireSeries, false);
