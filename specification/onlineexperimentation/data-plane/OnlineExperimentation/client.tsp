import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// @typespec/http-client-csharp: Convenience method is not supported for PATCH method.
@@convenientAPI(Azure.Analytics.OnlineExperimentation.createOrUpdateMetric,
  false,
  "csharp"
);

// @azure-tools/typespec-python@0.45.0 generates an "e_tag" property, should be "etag".
@@clientName(Azure.Analytics.OnlineExperimentation.ExperimentMetric.eTag,
  "etag",
  "python"
);
