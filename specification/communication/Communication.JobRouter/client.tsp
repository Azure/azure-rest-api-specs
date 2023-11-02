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
    @internal("csharp")
    @internal("java")
    upsertDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertDistributionPolicy;
    
    getDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getDistributionPolicy;
    
    listDistributionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listDistributionPolicies;
    
    deleteDistributionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteDistributionPolicy;
    
    @internal("csharp")
    @internal("java")
    upsertClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertClassificationPolicy;
    
    getClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getClassificationPolicy;
    
    listClassificationPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listClassificationPolicies;
    
    deleteClassificationPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteClassificationPolicy;
    
    @internal("csharp")
    @internal("java")
    upsertExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertExceptionPolicy;
    
    getExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getExceptionPolicy;
    
    listExceptionPolicies is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listExceptionPolicies;
    
    deleteExceptionPolicy is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteExceptionPolicy;
    
    @internal("csharp")
    @internal("java")
    upsertQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.upsertQueue;
    
    getQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.getQueue;
    
    listQueues is AzureCommunicationRoutingService.JobRouterAdministrationOperations.listQueues;
    
    deleteQueue is AzureCommunicationRoutingService.JobRouterAdministrationOperations.deleteQueue;
}

@client({
    name: "JobRouterClient",
    service: AzureCommunicationRoutingService
})
interface JobRouterRestClient {
    @internal("csharp")
    @internal("java")
    upsertJob is AzureCommunicationRoutingService.JobRouterOperations.upsertJob;
    
    getJob is AzureCommunicationRoutingService.JobRouterOperations.getJob;
    
    deleteJob is AzureCommunicationRoutingService.JobRouterOperations.deleteJob;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    @internal("csharp")
    @internal("python")
    @internal("java")
    reclassifyJob is AzureCommunicationRoutingService.JobRouterOperations.reclassifyJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    cancelJob is AzureCommunicationRoutingService.JobRouterOperations.cancelJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    completeJob is AzureCommunicationRoutingService.JobRouterOperations.completeJobAction;
    
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
    closeJob is AzureCommunicationRoutingService.JobRouterOperations.closeJobAction;
    
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
    
    @internal("csharp")
    @internal("java")
    upsertWorker is AzureCommunicationRoutingService.JobRouterOperations.upsertWorker;
    
    getWorker is AzureCommunicationRoutingService.JobRouterOperations.getWorker;
    
    deleteWorker is AzureCommunicationRoutingService.JobRouterOperations.deleteWorker;
    
    listWorkers is AzureCommunicationRoutingService.JobRouterOperations.listWorkers;
}