import "../healthinsights.openapi/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace ClientForAzureHealthInsights;
  
@client({
    name: "ClinicalMatchingClient",
    service: AzureHealthInsights
})
interface ClinicalMatchingClient {
  MatchTrials is AzureHealthInsights.TrialMatcher.CreateJob;
}
