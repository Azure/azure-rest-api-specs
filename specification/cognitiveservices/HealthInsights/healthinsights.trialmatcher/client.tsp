import "@azure-tools/typespec-client-generator-core";
import "../healthinsights.openapi/service.tsp";
import "./route.trialmatcher.tsp";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;
  
@client({
    name: "ClinicalMatchingClient",
    service: AzureHealthInsights
})
  interface ClinicalMatchingClient {
  MatchTrials is AzureHealthInsights.TrialMatcher.CreateJob;
}
