import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// @typespec/http-client-csharp: Convenience method is not supported for PATCH method.
@@convenientAPI(Azure.Analytics.OnlineExperimentation.createOrUpdateMetric,
  false,
  "csharp"
);
