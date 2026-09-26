import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using FoundryLocal.AgenticRAG;

// ──── Client locations ────

@@clientLocation(ThreadsOperationGroup.createThread, "Threads");
@@clientLocation(ThreadsOperationGroup.listThreads, "Threads");
@@clientLocation(ThreadsOperationGroup.getThread, "Threads");
@@clientLocation(ThreadsOperationGroup.modifyThread, "Threads");
@@clientLocation(ThreadsOperationGroup.deleteThread, "Threads");

@@clientLocation(MessagesOperationGroup.createMessage, "Messages");
@@clientLocation(MessagesOperationGroup.listMessages, "Messages");
@@clientLocation(MessagesOperationGroup.getMessage, "Messages");
@@clientLocation(MessagesOperationGroup.deleteMessage, "Messages");

@@clientLocation(RunsOperationGroup.createRun, "Runs");
@@clientLocation(RunsOperationGroup.getRun, "Runs");
@@clientLocation(RunsOperationGroup.cancelRun, "Runs");

@@clientLocation(RunStepsOperationGroup.listRunSteps, "RunSteps");
@@clientLocation(RunStepsOperationGroup.getRunStep, "RunSteps");

@@clientLocation(CollectionsOperationGroup.createCollection, "Collections");
@@clientLocation(CollectionsOperationGroup.listCollections, "Collections");
@@clientLocation(CollectionsOperationGroup.getCollection, "Collections");
@@clientLocation(CollectionsOperationGroup.updateCollection, "Collections");
@@clientLocation(CollectionsOperationGroup.deleteCollection, "Collections");

@@clientLocation(ChatCompletionsOperationGroup.ragChatCompletion, "ChatCompletions");
@@clientLocation(ChatCompletionsOperationGroup.modelOnlyChatCompletion, "ChatCompletions");

@@clientLocation(IngestionJobsOperationGroup.createIngestionJob, "IngestionJobs");
@@clientLocation(IngestionJobsOperationGroup.listIngestionJobs, "IngestionJobs");

@@clientLocation(IngestionRunsOperationGroup.getIngestionRun, "IngestionRuns");
@@clientLocation(IngestionRunsOperationGroup.deleteIngestionRuns, "IngestionRuns");

@@clientLocation(KnowledgeBasesOperationGroup.listKnowledgeBases, "KnowledgeBases");
@@clientLocation(KnowledgeBasesOperationGroup.getKnowledgeBase, "KnowledgeBases");
@@clientLocation(KnowledgeBasesOperationGroup.updateKnowledgeBase, "KnowledgeBases");
@@clientLocation(KnowledgeBasesOperationGroup.replaceKnowledgeBase, "KnowledgeBases");

@@clientLocation(KnowledgeSourcesOperationGroup.createKnowledgeSource, "KnowledgeSources");
@@clientLocation(KnowledgeSourcesOperationGroup.listKnowledgeSources, "KnowledgeSources");
@@clientLocation(KnowledgeSourcesOperationGroup.getKnowledgeSource, "KnowledgeSources");
@@clientLocation(KnowledgeSourcesOperationGroup.updateKnowledgeSource, "KnowledgeSources");
@@clientLocation(KnowledgeSourcesOperationGroup.deleteKnowledgeSource, "KnowledgeSources");
@@clientLocation(
  KnowledgeSourcesOperationGroup.batchDeleteKnowledgeSources,
  "KnowledgeSources"
);

@@clientLocation(McpOperationGroup.mcpRequest, "Mcp");
