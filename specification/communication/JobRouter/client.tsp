// client.tsp
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureCommunicationRoutingService.Versions.c2023_11_01)
namespace ClientForAcsJobRouter;

// Your customizations here
@@client(AzureCommunicationRoutingService,{
    name: "JobRouterAdministrationClient",
    service: AzureCommunicationRoutingService
})
interface JobRouterAdministrationClient {
    upsertDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertDistributionPolicy;
    getDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getDistributionPolicy;
    listDistributionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listDistributionPolicies;
    deleteDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteDistributionPolicy;
    upsertClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertClassificationPolicy;
    getClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getClassificationPolicy;
    listClassificationPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listClassificationPolicies;
    deleteClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteClassificationPolicy;
    upsertExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertExceptionPolicy;
    getExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getExceptionPolicy;
    listExceptionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listExceptionPolicies;
    deleteExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteExceptionPolicy;
    upsertQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertQueue;
    getQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getQueue;
    listQueues is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listQueues;
    deleteQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteQueue;
}

@@client(AzureCommunicationRoutingService, {
    name: "JobRouterClient",
    service: AzureCommunicationRoutingService
})
interface JobRouterClient {
    upsertJob is AzureCommunicationRoutingService.JobRouterOperations.upsertJob;
    getJob is AzureCommunicationRoutingService.JobRouterOperations.getJob;
    deleteJob is AzureCommunicationRoutingService.JobRouterOperations.deleteJob;
    reclassifyJob is AzureCommunicationRoutingService.JobRouterOperations.reclassifyJobAction;
    cancelJob is AzureCommunicationRoutingService.JobRouterOperations.cancelJobAction;
    completeJob is AzureCommunicationRoutingService.JobRouterOperations.completeJobAction;
    closeJob is AzureCommunicationRoutingService.JobRouterOperations.closeJobAction;
    listJobs is  AzureCommunicationRoutingService.JobRouterOperations.listJobs;
    getQueuePosition is  AzureCommunicationRoutingService.JobRouterOperations.getInQueuePosition;
    unassignJob is  AzureCommunicationRoutingService.JobRouterOperations.unassignJobAction;
    acceptJob is  AzureCommunicationRoutingService.JobRouterOperations.acceptJobAction;
    declineJob is  AzureCommunicationRoutingService.JobRouterOperations.declineJobAction;
    getQueueStatistics is  AzureCommunicationRoutingService.JobRouterOperations.getQueueStatistics;
    upsertWorker is AzureCommunicationRoutingService.JobRouterOperations.upsertWorker;
    getWorker is AzureCommunicationRoutingService.JobRouterOperations.getWorker;
    deleteWorker is AzureCommunicationRoutingService.JobRouterOperations.deleteWorker;
    listWorkers is AzureCommunicationRoutingService.JobRouterOperations.listWorkers;
}