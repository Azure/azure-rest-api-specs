import "@azure-tools/typespec-client-generator-core";
import "./route.trialmatcher.tsp";

import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "../healthinsights.openapi/service.tsp";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;
  
@client({
    name: "ClinicalMatchingClient",
    service: AzureHealthInsights
})
  interface ClinicalMatchingClient {
  MatchTrials is AzureHealthInsights.TrialMatcher.CreateJob;
}
