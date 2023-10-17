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
    service: AzureCommunicationRoutingService
})
interface JobRouterAdministrationRestClient {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertDistributionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getDistributionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listDistributionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listDistributionPolicies;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteDistributionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertClassificationPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getClassificationPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listClassificationPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listClassificationPolicies;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteClassificationPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertExceptionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getExceptionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listExceptionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listExceptionPolicies;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteExceptionPolicy;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertQueue;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getQueue;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listQueues is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listQueues;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteQueue;
}

@client({
    name: "JobRouterClient",
    service: AzureCommunicationRoutingService
})
interface JobRouterRestClient {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertJob is AzureCommunicationRoutingService.JobRouterOperations.upsertJob;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getJob is AzureCommunicationRoutingService.JobRouterOperations.getJob;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteJob is AzureCommunicationRoutingService.JobRouterOperations.deleteJob;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    reclassifyJob is AzureCommunicationRoutingService.JobRouterOperations.reclassifyJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    cancelJob is AzureCommunicationRoutingService.JobRouterOperations.cancelJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    completeJob is AzureCommunicationRoutingService.JobRouterOperations.completeJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    closeJob is AzureCommunicationRoutingService.JobRouterOperations.closeJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listJobs is  AzureCommunicationRoutingService.JobRouterOperations.listJobs;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getQueuePosition is  AzureCommunicationRoutingService.JobRouterOperations.getInQueuePosition;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    unassignJob is  AzureCommunicationRoutingService.JobRouterOperations.unassignJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    acceptJobOffer is  AzureCommunicationRoutingService.JobRouterOperations.acceptJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    declineJobOffer is  AzureCommunicationRoutingService.JobRouterOperations.declineJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getQueueStatistics is  AzureCommunicationRoutingService.JobRouterOperations.getQueueStatistics;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal
    upsertWorker is AzureCommunicationRoutingService.JobRouterOperations.upsertWorker;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    getWorker is AzureCommunicationRoutingService.JobRouterOperations.getWorker;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    deleteWorker is AzureCommunicationRoutingService.JobRouterOperations.deleteWorker;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    listWorkers is AzureCommunicationRoutingService.JobRouterOperations.listWorkers;
}