import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Agents;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents, "AgentsClient", "python, javascript");
@@clientName(Azure.AI.Agents, "PersistentAgentsClient", "csharp, java");

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Agents, "agents", "python");
@@clientName(Azure.AI.Agents.Agents.createAgent, "create", "python");
@@clientName(Azure.AI.Agents.Agents.updateAgent, "update", "python");
@@clientName(Azure.AI.Agents.Agents.listAgents, "list", "python");
@@clientName(Azure.AI.Agents.Agents.getAgent, "get", "python");
@@clientName(Azure.AI.Agents.Agents.deleteAgent, "delete", "python");

@@clientName(Azure.AI.Agents.Agents, "AdministrationClient", "csharp");
@@clientName(Azure.AI.Agents.Agents.createAgent, "CreateAgent", "csharp");
@@clientName(Azure.AI.Agents.Agents.updateAgent, "UpdateAgent", "csharp");
@@clientName(Azure.AI.Agents.Agents.getAgent, "GetAgent", "csharp");
@@access(Azure.AI.Agents.Agents.listAgents, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Agents.listAgents, "InternalGetAgents", "csharp");
@@access(Azure.AI.Agents.Agents.deleteAgent, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Agents.deleteAgent,
  "InternalDeleteAgent",
  "csharp"
);

// --------------------------------------------------------------------------------
// Files sub‐client (agent file operations)
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Files, "files", "python");
@@clientName(Azure.AI.Agents.Files.listFiles, "list", "python");
@@access(Azure.AI.Agents.Files.uploadFile,
  Access.internal,
  "python, java, javascript"
);
@@clientName(Azure.AI.Agents.Files.deleteFile, "delete", "python");
@@clientName(Azure.AI.Agents.Files.getFile, "get", "python");
@@access(Azure.AI.Agents.Files.getFileContent, Access.internal, "python");

@@clientName(Azure.AI.Agents.Files, "FilesClient", "csharp");
@@access(Azure.AI.Agents.Files.listFiles, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Files.listFiles, "InternalListFiles", "csharp");
@@clientName(Azure.AI.Agents.Files.uploadFile, "UploadFile", "csharp");
@@access(Azure.AI.Agents.Files.deleteFile, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Files.deleteFile, "InternalDeleteFile", "csharp");
@@clientName(Azure.AI.Agents.Files.getFile, "GetFile", "csharp");
@@clientName(Azure.AI.Agents.Files.getFileContent, "GetFileContent", "csharp");

// --------------------------------------------------------------------------------
// Messages sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Messages, "messages", "python");
@@clientName(Azure.AI.Agents.Messages.createMessage, "create", "python");
@@clientName(Azure.AI.Agents.Messages.listMessages, "list", "python");
@@clientName(Azure.AI.Agents.Messages.getMessage, "get", "python");
@@clientName(Azure.AI.Agents.Messages.updateMessage, "update", "python");

@@clientName(Azure.AI.Agents.Messages, "MessagesClient", "csharp");
@@clientName(Azure.AI.Agents.Messages.createMessage, "CreateMessage", "csharp");
@@access(Azure.AI.Agents.Messages.listMessages, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Messages.listMessages,
  "InternalGetMessages",
  "csharp"
);
@@clientName(Azure.AI.Agents.Messages.getMessage, "GetMessage", "csharp");
@@clientName(Azure.AI.Agents.Messages.updateMessage, "UpdateMessage", "csharp");

// --------------------------------------------------------------------------------
// Threads sub-client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Threads, "threads", "python");
@@clientName(Azure.AI.Agents.Threads.createThread, "create", "python");
@@clientName(Azure.AI.Agents.Threads.listThreads, "list", "python");
@@clientName(Azure.AI.Agents.Threads.getThread, "get", "python");
@@clientName(Azure.AI.Agents.Threads.updateThread, "update", "python");
@@clientName(Azure.AI.Agents.Threads.deleteThread, "delete", "python");

@@clientName(Azure.AI.Agents.Threads, "ThreadsClient", "csharp");
@@clientName(Azure.AI.Agents.Threads.createThread, "CreateThread", "csharp");
@@access(Azure.AI.Agents.Threads.listThreads, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Threads.listThreads,
  "InternalGetThreads",
  "csharp"
);
@@clientName(Azure.AI.Agents.Threads.getThread, "Thread", "csharp");
@@clientName(Azure.AI.Agents.Threads.updateThread, "UpdateThread", "csharp");
@@access(Azure.AI.Agents.Threads.deleteThread, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Threads.deleteThread,
  "InternalDeleteThread",
  "csharp"
);

// --------------------------------------------------------------------------------
// Runs sub‐client & createThreadAndRun
// --------------------------------------------------------------------------------
// top‐level op
@@clientName(Azure.AI.Agents.createThreadAndRun,
  "create_thread_and_run",
  "python"
);
@@clientName(Azure.AI.Agents.createThreadAndRun,
  "CreateThreadAndRun",
  "csharp"
);

// nested Runs interface
@@clientName(Azure.AI.Agents.Runs, "runs", "python");
@@clientName(Azure.AI.Agents.Runs.createRun, "create", "python");
@@clientName(Azure.AI.Agents.Runs.listRuns, "list", "python");
@@clientName(Azure.AI.Agents.Runs.getRun, "get", "python");
@@clientName(Azure.AI.Agents.Runs.updateRun, "update", "python");
@@clientName(Azure.AI.Agents.Runs.submitToolOutputsToRun,
  "submit_tool_outputs",
  "python"
);
@@clientName(Azure.AI.Agents.Runs.cancelRun, "cancel", "python");

@@clientName(Azure.AI.Agents.Runs, "RunsClient", "csharp");
@@clientName(Azure.AI.Agents.Runs.createRun, "CreateRun", "csharp");
@@access(Azure.AI.Agents.Runs.listRuns, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Runs.listRuns, "InternalGetRuns", "csharp");
@@clientName(Azure.AI.Agents.Runs.getRun, "GetRun", "csharp");
@@clientName(Azure.AI.Agents.Runs.updateRun, "UpdateRun", "csharp");
@@clientName(Azure.AI.Agents.Runs.submitToolOutputsToRun,
  "SubmitToolOutputs",
  "csharp"
);
@@clientName(Azure.AI.Agents.Runs.cancelRun, "CancelRun", "csharp");

// --------------------------------------------------------------------------------
// RunSteps sub‐client (/threads/{threadId}/runs/{runId}/steps)
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.RunSteps, "steps", "python");
@@clientName(Azure.AI.Agents.RunSteps.getRunStep, "get", "python");
@@clientName(Azure.AI.Agents.RunSteps.listRunSteps, "list", "python");

@@clientName(Azure.AI.Agents.RunSteps, "RunStepsClient", "csharp");
@@clientName(Azure.AI.Agents.RunSteps.getRunStep, "GetRunStep", "csharp");
@@access(Azure.AI.Agents.RunSteps.listRunSteps, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.RunSteps.listRunSteps,
  "InternalGetRunSteps",
  "csharp"
);

// --------------------------------------------------------------------------------
// VectorStores sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.VectorStores, "vector_stores", "python");
@@clientName(Azure.AI.Agents.VectorStores.listVectorStores, "list", "python");
@@clientName(Azure.AI.Agents.VectorStores.createVectorStore,
  "create",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStores.getVectorStore, "get", "python");
@@clientName(Azure.AI.Agents.VectorStores.modifyVectorStore,
  "modify",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStores.deleteVectorStore,
  "delete",
  "python"
);

@@clientName(Azure.AI.Agents.VectorStores, "VectorStoresClient", "csharp");
@@clientName(Azure.AI.Agents.VectorStores.listVectorStores,
  "ListVectorStores",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStores.createVectorStore,
  "CreateVectorStore",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStores.getVectorStore,
  "GetVectorStore",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStores.modifyVectorStore,
  "ModifyVectorStore",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStores.deleteVectorStore,
  "DeleteVectorStore",
  "csharp"
);

// --------------------------------------------------------------------------------
// FileBatches sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.FileBatches, "file_batches", "python");
@@clientName(Azure.AI.Agents.FileBatches.createVectorStoreFileBatch,
  "create",
  "python"
);
@@clientName(Azure.AI.Agents.FileBatches.getVectorStoreFileBatch,
  "get",
  "python"
);
@@clientName(Azure.AI.Agents.FileBatches.cancelVectorStoreFileBatch,
  "cancel",
  "python"
);
@@clientName(Azure.AI.Agents.FileBatches.listVectorStoreFileBatchFiles,
  "list_files",
  "python"
);

@@clientName(Azure.AI.Agents.FileBatches, "FileBatchesClient", "csharp");
@@clientName(Azure.AI.Agents.FileBatches.createVectorStoreFileBatch,
  "CreateVectorStoreFileBatch",
  "csharp"
);
@@clientName(Azure.AI.Agents.FileBatches.getVectorStoreFileBatch,
  "GetVectorStoreFileBatch",
  "csharp"
);
@@clientName(Azure.AI.Agents.FileBatches.cancelVectorStoreFileBatch,
  "CancelVectorStoreFileBatch",
  "csharp"
);
@@clientName(Azure.AI.Agents.FileBatches.listVectorStoreFileBatchFiles,
  "ListVectorStoreFileBatchFiles",
  "csharp"
);

// --------------------------------------------------------------------------------
// VectorStoreFiles sub‐client (under /vector_stores/{vectorStoreId}/files)
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.VectorStoreFiles, "vector_store_files", "python");
@@clientName(Azure.AI.Agents.VectorStoreFiles.listVectorStoreFiles,
  "list",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.createVectorStoreFile,
  "create",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.getVectorStoreFile,
  "get",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.deleteVectorStoreFile,
  "delete",
  "python"
);

@@clientName(Azure.AI.Agents.VectorStoreFiles,
  "VectorStoreFilesClient",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.listVectorStoreFiles,
  "ListVectorStoreFiles",
  "csharp"
);
@@access(Azure.AI.Agents.VectorStoreFiles.listVectorStoreFiles,
  Access.internal,
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.listVectorStoreFiles,
  "InternalListFiles",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.createVectorStoreFile,
  "CreateVectorStoreFile",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.getVectorStoreFile,
  "GetVectorStoreFile",
  "csharp"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.deleteVectorStoreFile,
  "DeleteVectorStoreFile",
  "csharp"
);

// --------------------------------------------------------------------------------
// Persistent & Model‐level renames (csharp, java)
// --------------------------------------------------------------------------------
@@clientName(Agent, "PersistentAgent", "csharp,java");
@@clientName(AgentsApiResponseFormat,
  "PersistentAgentsApiResponseFormat",
  "csharp,java"
);
@@clientName(AgentsApiResponseFormatMode,
  "PersistentAgentsApiResponseFormatMode",
  "csharp,java"
);
@@clientName(AgentsApiToolChoiceOptionMode,
  "PersistentAgentsApiToolChoiceOptionMode",
  "csharp,java"
);
@@clientName(AgentsNamedToolChoice,
  "PersistentAgentsNamedToolChoice",
  "csharp,java"
);
@@clientName(AgentsNamedToolChoiceType,
  "PersistentAgentsNamedToolChoiceType",
  "csharp,java"
);
@@clientName(AgentStreamEvent, "PersistentAgentStreamEvent", "csharp,java");
@@clientName(AgentThread, "PersistentAgentThread", "csharp,java");
@@clientName(AgentThreadCreationOptions,
  "PersistentAgentThreadCreationOptions",
  "csharp,java"
);

// --------------------------------------------------------------------------------
// Internal C# overrides for operations & models
// --------------------------------------------------------------------------------
@@clientName(AgentDeletionStatus, "InternalAgentDeletionStatus", "csharp");
@@access(FileListResponse, Access.internal, "csharp");
@@clientName(FileListResponse, "InternalFileListResponse", "csharp");
@@access(FileDeletionStatus, Access.internal, "csharp");
@@clientName(FileDeletionStatus, "InternalFileDeletionStatus", "csharp");

@@access(FunctionDefinition, Access.internal);
@@clientName(FunctionDefinition, "InternalFunctionDefinition", "csharp");
@@clientName(FunctionToolDefinition.function, "InternalFunction", "csharp");

@@access(AzureFunctionDefinition, Access.internal);
@@clientName(AzureFunctionDefinition,
  "InternalAzureFunctionDefinition",
  "csharp"
);
@@clientName(AzureFunctionToolDefinition.azureFunction,
  "InternalAzureFunction",
  "csharp"
);
@@access(AzureFunctionBinding, Access.public);

@@access(SubmitToolOutputsDetails, Access.internal);
@@clientName(SubmitToolOutputsDetails,
  "InternalSubmitToolOutputsDetails",
  "csharp"
);
@@clientName(SubmitToolOutputsAction.submitToolOutputs,
  "InternalDetails",
  "csharp"
);

@@access(RunStepFunctionToolCallDetails, Access.internal);
@@clientName(RunStepFunctionToolCallDetails,
  "InternalRunStepFunctionToolCallDetails",
  "csharp"
);
@@access(RequiredFunctionToolCallDetails, Access.internal);
@@clientName(RequiredFunctionToolCallDetails,
  "InternalRequiredFunctionToolCallDetails",
  "csharp"
);
@@clientName(RequiredFunctionToolCall.function, "InternalDetails", "csharp");
@@clientName(RunStepFunctionToolCall.function, "InternalDetails", "csharp");

@@access(RunStepCodeInterpreterToolCallDetails, Access.internal);
@@clientName(RunStepCodeInterpreterToolCallDetails,
  "InternalCodeInterpreterToolCallDetails",
  "csharp"
);
@@clientName(RunStepCodeInterpreterToolCall.codeInterpreter,
  "InternalDetails",
  "csharp"
);

@@access(MessageTextDetails, Access.internal);
@@clientName(MessageTextDetails, "InternalMessageTextDetails", "csharp");
@@clientName(MessageTextContent.text, "InternalDetails", "csharp");

@@access(MessageTextFileCitationDetails, Access.internal);
@@clientName(MessageTextFileCitationDetails,
  "InternalMessageTextFileCitationDetails",
  "csharp"
);
@@clientName(MessageTextFileCitationAnnotation.fileCitation,
  "InternalDetails",
  "csharp"
);

@@access(MessageTextFilePathDetails, Access.internal);
@@clientName(MessageTextFilePathDetails,
  "InternalMessageTextFilePathDetails",
  "csharp"
);
@@clientName(MessageTextFilePathAnnotation.filePath,
  "InternalDetails",
  "csharp"
);

@@access(MessageImageFileDetails, Access.internal);
@@clientName(MessageImageFileDetails,
  "InternalMessageImageFileDetails",
  "csharp"
);
@@clientName(MessageImageFileContent.imageFile, "InternalDetails", "csharp");
@@clientName(MessageImageFileDetails.fileId, "InternalDetails", "csharp");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------
@@usage(MessageTextContent, Usage.output);
@@usage(MessageImageFileContent, Usage.output);
@@usage(MessageTextFileCitationAnnotation, Usage.output);
@@usage(MessageTextFilePathAnnotation, Usage.output);

@@usage(MessageDeltaTextFileCitationAnnotation, Usage.output);
@@access(MessageDeltaTextFileCitationAnnotation, Access.public);
@@usage(MessageDeltaTextFileCitationAnnotationObject, Usage.output);
@@access(MessageDeltaTextFileCitationAnnotationObject, Access.public);

@@usage(MessageDeltaTextFilePathAnnotation, Usage.output);
@@access(MessageDeltaTextFilePathAnnotation, Access.public);
@@usage(MessageDeltaTextFilePathAnnotationObject, Usage.output);
@@access(MessageDeltaTextFilePathAnnotationObject, Access.public);

@@usage(MessageDeltaImageFileContent, Usage.output);
@@access(MessageDeltaImageFileContent, Access.public);
@@usage(MessageDeltaImageFileContentObject, Usage.output);
@@access(MessageDeltaImageFileContentObject, Access.public);

@@usage(MessageDeltaTextContent, Usage.output);
@@access(MessageDeltaTextContent, Access.public);
@@usage(MessageDeltaTextContentObject, Usage.output);
@@access(MessageDeltaTextContentObject, Access.public);

@@usage(RunStepDeltaMessageCreationObject, Usage.output);
@@access(RunStepDeltaMessageCreationObject, Access.public);
@@usage(RunStepDeltaFunction, Usage.output);
@@access(RunStepDeltaFunction, Access.public);
@@usage(RunStepDeltaCodeInterpreterLogOutput, Usage.output);
@@access(RunStepDeltaCodeInterpreterLogOutput, Access.public);
@@usage(RunStepDeltaCodeInterpreterImageOutputObject, Usage.output);
@@access(RunStepDeltaCodeInterpreterImageOutputObject, Access.public);
@@usage(RunStepDeltaChunk, Usage.output);
@@access(RunStepDeltaChunk, Access.public);
@@usage(MessageDeltaChunk, Usage.output);
@@access(MessageDeltaChunk, Access.public);

@@usage(MessageDelta, Usage.output);
@@access(MessageDelta, Access.public);
@@usage(MessageDeltaContent, Usage.output);
@@access(MessageDeltaContent, Access.public);

@@usage(RunStepStreamEvent, Usage.output);
@@access(RunStepStreamEvent, Access.public);
@@usage(MessageStreamEvent, Usage.output);
@@access(MessageStreamEvent, Access.public);
@@usage(RunStreamEvent, Usage.output);
@@access(RunStreamEvent, Access.public);
@@usage(ThreadStreamEvent, Usage.output);
@@access(ThreadStreamEvent, Access.public);
@@usage(AgentStreamEvent, Usage.output);
@@access(AgentStreamEvent, Access.public);
@@usage(ErrorEvent, Usage.output);
@@access(ErrorEvent, Access.public);
@@usage(DoneEvent, Usage.output);
@@access(DoneEvent, Access.public);

// Tool resources
@@usage(ToolResources, Usage.output);
@@access(ToolResources, Access.public);
@@usage(CodeInterpreterToolResource, Usage.output);
@@access(CodeInterpreterToolResource, Access.public);
@@usage(FileSearchToolResource, Usage.output);
@@access(FileSearchToolResource, Access.public);

@@access(MessageTextFilePathAnnotation, Access.public);
@@access(MessageTextFileCitationAnnotation, Access.public);
@@access(ListSortOrder, Access.public);
@@access(RequiredToolCall, Access.public);
@@usage(FilePurpose, Usage.input | Usage.output);
@@usage(ListSortOrder, Usage.input | Usage.output);

// --------------------------------------------------------------------------------
// Additional C#-idiomatic renames
// --------------------------------------------------------------------------------
@@clientName(OpenAIFile, "OpenAIFile", "csharp");
@@clientName(OpenAIFile.bytes, "Size", "csharp");
@@clientName(FilePurpose, "OpenAIFilePurpose", "csharp");
@@clientName(ThreadMessage.content, "ContentItems", "csharp");
@@clientName(MessageTextDetails.value, "Text", "csharp");
@@clientName(CreateRunOptions.`model`, "OverrideModelName", "csharp");
@@clientName(CreateRunOptions.instructions, "OverrideInstructions", "csharp");
@@clientName(CreateRunOptions.tools, "OverrideTools", "csharp");
@@clientName(CreateAndRunThreadOptions.`model`, "OverrideModelName", "csharp");
@@clientName(CreateAndRunThreadOptions.instructions,
  "OverrideInstructions",
  "csharp"
);
@@clientName(CreateAndRunThreadOptions.tools, "OverrideTools", "csharp");

// Python assistant vs agent renames
@@clientName(ThreadMessage.assistantId, "agentId", "python");
@@clientName(GetAgentOptions.assistantId, "agentId", "python");
@@clientName(UpdateAgentOptions.assistantId, "agentId", "python");
@@clientName(DeleteAgentOptions.assistantId, "agentId", "python");
@@clientName(RunStep.assistantId, "agentId", "python");
@@clientName(ThreadRun.assistantId, "agentId", "python");
@@clientName(CreateRunOptions.assistantId, "agentId", "python");
@@clientName(CreateAndRunThreadOptions.assistantId, "agentId", "python");
