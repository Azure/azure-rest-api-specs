import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

import "./model.radiologyinsights.tsp";
import "./model.radiologyinsights.valuesets.tsp";
import "../HealthInsights.Common/primitives.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureHealthInsights;

interface RadiologyInsights {
  @summary("Get Radiology Insights Job")
  getJob is HealthInsightsOperations.ResourceRead<RadiologyInsightsResource>;

  @summary("Create Radiology Insights Job")
  @pollingOperation(RadiologyInsights.getJob)
  createJob is HealthInsightsOperations.LongRunningResourceCreateOrReplace<RadiologyInsightsResource>;
}
