// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureCommunicationRoutingService.Versions.c2023_11_01)
namespace ClientForAcsJobRouter;

// Your customizations here
@client({
  name: "JobRouterAdministrationClient",
  service: AzureCommunicationRoutingService,
})
interface JobRouterAdministrationRestClient {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertDistributionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getDistributionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listDistributionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listDistributionPolicies;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteDistributionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertClassificationPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getClassificationPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listClassificationPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listClassificationPolicies;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteClassificationPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertExceptionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getExceptionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listExceptionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listExceptionPolicies;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteExceptionPolicy;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertQueue;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getQueue;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listQueues is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listQueues;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteQueue;
}

@client({
  name: "JobRouterClient",
  service: AzureCommunicationRoutingService,
})
interface JobRouterRestClient {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertJob is AzureCommunicationRoutingService.JobRouterOperations.upsertJob;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getJob is AzureCommunicationRoutingService.JobRouterOperations.getJob;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteJob is AzureCommunicationRoutingService.JobRouterOperations.deleteJob;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  @internal("python")
  @internal("java")
  reclassifyJob is AzureCommunicationRoutingService.JobRouterOperations.reclassify;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  @internal("python")
  @internal("java")
  cancel is AzureCommunicationRoutingService.JobRouterOperations.cancel;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  @internal("python")
  @internal("java")
  completeJob is AzureCommunicationRoutingService.JobRouterOperations.complete;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  @internal("python")
  @internal("java")
  closeJob is AzureCommunicationRoutingService.JobRouterOperations.close;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listJobs is AzureCommunicationRoutingService.JobRouterOperations.listJobs;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getQueuePosition is AzureCommunicationRoutingService.JobRouterOperations.getInQueuePosition;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  unassignJob is AzureCommunicationRoutingService.JobRouterOperations.unassign;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  acceptJobOffer is AzureCommunicationRoutingService.JobRouterOperations.accept;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @internal("csharp")
  @internal("python")
  @internal("java")
  declineJobOffer is AzureCommunicationRoutingService.JobRouterOperations.decline;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  getQueueStatistics is AzureCommunicationRoutingService.JobRouterOperations.getQueueStatistics;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @internal("csharp")
  @internal("java")
  upsertWorker is AzureCommunicationRoutingService.JobRouterOperations.upsertWorker;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  getWorker is AzureCommunicationRoutingService.JobRouterOperations.getWorker;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  deleteWorker is AzureCommunicationRoutingService.JobRouterOperations.deleteWorker;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  listWorkers is AzureCommunicationRoutingService.JobRouterOperations.listWorkers;
}
