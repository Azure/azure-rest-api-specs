// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureCommunicationRoutingService.Versions.c2024_01_18_Preview)
namespace ClientForAcsJobRouter;

// Your customizations here
@client({
  name: "JobRouterAdministrationClient",
  service: AzureCommunicationRoutingService,
})
interface JobRouterAdministrationRestClient {
  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertDistributionPolicy;

  getDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getDistributionPolicy;

  @access(Access.internal, "csharp")
  listDistributionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listDistributionPolicies;

  deleteDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteDistributionPolicy;

  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertClassificationPolicy;

  getClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getClassificationPolicy;

  @access(Access.internal, "csharp")
  listClassificationPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listClassificationPolicies;

  deleteClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteClassificationPolicy;

  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertExceptionPolicy;

  @access(Access.internal, "java")
  getExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getExceptionPolicy;

  @access(Access.internal, "java")
  @access(Access.internal, "csharp")
  listExceptionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listExceptionPolicies;

  deleteExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteExceptionPolicy;

  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertQueue;

  getQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getQueue;

  @access(Access.internal, "csharp")
  listQueues is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listQueues;

  deleteQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteQueue;
}

@client({
  name: "JobRouterClient",
  service: AzureCommunicationRoutingService,
})
interface JobRouterRestClient {
  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertJob is AzureCommunicationRoutingService.JobRouterOperations.upsertJob;

  getJob is AzureCommunicationRoutingService.JobRouterOperations.getJob;

  deleteJob is AzureCommunicationRoutingService.JobRouterOperations.deleteJob;

  @access(Access.internal, "csharp")
  @access(Access.internal, "python")
  @access(Access.internal, "java")
  @clientName("reclassifyJob")
  reclassify is AzureCommunicationRoutingService.JobRouterOperations.reclassify;

  @access(Access.internal, "csharp")
  @access(Access.internal, "python")
  @access(Access.internal, "java")
  @clientName("cancelJob")
  cancel is AzureCommunicationRoutingService.JobRouterOperations.cancel;

  @access(Access.internal, "csharp")
  @access(Access.internal, "python")
  @access(Access.internal, "java")
  @clientName("completeJob")
  complete is AzureCommunicationRoutingService.JobRouterOperations.complete;

  @access(Access.internal, "csharp")
  @access(Access.internal, "python")
  @access(Access.internal, "java")
  @clientName("closeJob")
  close is AzureCommunicationRoutingService.JobRouterOperations.close;

  @access(Access.internal, "csharp")
  listJobs is AzureCommunicationRoutingService.JobRouterOperations.listJobs;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
  getQueuePosition is AzureCommunicationRoutingService.JobRouterOperations.getInQueuePosition;

  @access(Access.internal, "csharp")
  @clientName("unassignJob")
  unassign is AzureCommunicationRoutingService.JobRouterOperations.unassign;

  @clientName("acceptJobOffer")
  accept is AzureCommunicationRoutingService.JobRouterOperations.accept;

  @access(Access.internal, "csharp")
  @access(Access.internal, "python")
  @access(Access.internal, "java")
  @clientName("declineJobOffer")
  decline is AzureCommunicationRoutingService.JobRouterOperations.decline;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
  getQueueStatistics is AzureCommunicationRoutingService.JobRouterOperations.getQueueStatistics;

  @access(Access.internal, "csharp")
  @access(Access.internal, "java")
  upsertWorker is AzureCommunicationRoutingService.JobRouterOperations.upsertWorker;

  getWorker is AzureCommunicationRoutingService.JobRouterOperations.getWorker;

  deleteWorker is AzureCommunicationRoutingService.JobRouterOperations.deleteWorker;

  @access(Access.internal, "csharp")
  listWorkers is AzureCommunicationRoutingService.JobRouterOperations.listWorkers;
}
