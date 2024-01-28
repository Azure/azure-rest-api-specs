import "@azure-tools/typespec-client-generator-core";
import "./route.patienttimeline.tsp";

import "@typespec/rest";
import "@typespec/http";
import "../service.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  AzureHealthInsights.ApiVersion.v2023_09_01_Preview
)
namespace ClientForAzureHealthInsights;

@client({
  name: "PatientTimelineClient",
  service: AzureHealthInsights,
})
interface PatientTimelineClient {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Polling through operation-location"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "https://github.com/microsoft/typespec/issues/2037"
  inferPatientTimeline is AzureHealthInsights.PatientTimeline.createJob;
}
