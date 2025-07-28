import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Agents;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents, "AgentsClient", "python, javascript");

// --------------------------------------------------------------------------------
// Agents sub‐client
// --------------------------------------------------------------------------------

@@clientName(Azure.AI.Agents,
  "PersistentAgentsAdministrationClient",
  "csharp, java"
);
@@access(Azure.AI.Agents.deleteAgent, Access.internal, "csharp, python");
@@clientName(Azure.AI.Agents.deleteAgent, "InternalDeleteAgent", "csharp");

@@access(Azure.AI.Agents.createThreadAndRun, Access.internal, "csharp");

// --------------------------------------------------------------------------------
// Files sub‐client (agent file operations)
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Files.listFiles, "list", "python");
@@access(Azure.AI.Agents.Files.uploadFile,
  Access.internal,
  "python, java, javascript"
);
@@clientName(Azure.AI.Agents.Files.getFile, "get", "python");
@@access(Azure.AI.Agents.Files.getFileContent, Access.internal, "python");

@@access(Azure.AI.Agents.Files.listFiles, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Files.listFiles, "InternalListFiles", "csharp");
@@access(Azure.AI.Agents.Files.deleteFile, Access.internal, "csharp, python");
@@clientName(Azure.AI.Agents.Files.deleteFile, "InternalDeleteFile", "csharp");

// --------------------------------------------------------------------------------
// Messages sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Messages.createMessage, "create", "python");
@@clientName(Azure.AI.Agents.Messages.listMessages, "list", "python");
@@clientName(Azure.AI.Agents.Messages.getMessage, "get", "python");
@@clientName(Azure.AI.Agents.Messages.updateMessage, "update", "python");

// --------------------------------------------------------------------------------
// Threads sub-client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.Threads.createThread, "create", "python");
@@clientName(Azure.AI.Agents.Threads.listThreads, "list", "python");
@@clientName(Azure.AI.Agents.Threads.getThread, "get", "python");
@@clientName(Azure.AI.Agents.Threads.updateThread, "update", "python");

@@access(Azure.AI.Agents.Threads.deleteThread,
  Access.internal,
  "csharp, python"
);
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

// nested Runs interface
@@access(Azure.AI.Agents.Runs.createRun, Access.internal, "csharp");
@@clientName(Azure.AI.Agents.Runs.createRun, "InternalCreateRun", "csharp");
@@clientName(Azure.AI.Agents.Runs.createRun, "create", "python");
@@clientName(Azure.AI.Agents.Runs.listRuns, "list", "python");
@@clientName(Azure.AI.Agents.Runs.getRun, "get", "python");
@@clientName(Azure.AI.Agents.Runs.updateRun, "update", "python");
@@clientName(Azure.AI.Agents.Runs.submitToolOutputsToRun,
  "submit_tool_outputs",
  "python"
);
@@clientName(Azure.AI.Agents.Runs.cancelRun, "cancel", "python");

// --------------------------------------------------------------------------------
// RunSteps sub‐client (/threads/{threadId}/runs/{runId}/steps)
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.RunSteps.getRunStep, "get", "python");
@@clientName(Azure.AI.Agents.RunSteps.listRunSteps, "list", "python");

// --------------------------------------------------------------------------------
// VectorStores sub‐client
// --------------------------------------------------------------------------------
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

@@access(Azure.AI.Agents.VectorStores.deleteVectorStore,
  Access.internal,
  "csharp, python"
);
@@clientName(Azure.AI.Agents.VectorStores.deleteVectorStore,
  "InternalDeleteVectorStore",
  "csharp"
);

// --------------------------------------------------------------------------------
// VectorStoreFileBatches sub‐client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Agents.VectorStoreFileBatches.createVectorStoreFileBatch,
  "create",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFileBatches.getVectorStoreFileBatch,
  "get",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFileBatches.cancelVectorStoreFileBatch,
  "cancel",
  "python"
);
@@clientName(Azure.AI.Agents.VectorStoreFileBatches.listVectorStoreFileBatchFiles,
  "list_files",
  "python"
);

// --------------------------------------------------------------------------------
// VectorStoreFiles sub‐client (under /vector_stores/{vectorStoreId}/files)
// --------------------------------------------------------------------------------
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

@@access(Azure.AI.Agents.VectorStoreFiles.deleteVectorStoreFile,
  Access.internal,
  "csharp, python"
);
@@clientName(Azure.AI.Agents.VectorStoreFiles.deleteVectorStoreFile,
  "InternalDeleteVectorStoreFile",
  "csharp"
);
// --------------------------------------------------------------------------------
// Persistent & Model‐level renames (csharp, java)
// --------------------------------------------------------------------------------
@@clientName(Agent, "PersistentAgent", "csharp,java");

@@access(AgentsResponseFormat, Access.internal, "csharp");
@@clientName(AgentsResponseFormat,
  "InternalPersistentAgentsResponseFormat",
  "csharp,java"
);
@@clientName(AgentsResponseFormatMode,
  "PersistentAgentsResponseFormatMode",
  "csharp,java"
);
@@clientName(AgentsToolChoiceOptionMode,
  "PersistentAgentsToolChoiceOptionMode",
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
@@access(VectorStoreFileDeletionStatus, Access.internal, "csharp");
@@clientName(VectorStoreFileDeletionStatus,
  "InternalVectorStoreFileDeletionStatus",
  "csharp"
);
@@access(VectorStoreDeletionStatus, Access.internal, "csharp");
@@clientName(VectorStoreDeletionStatus,
  "InternalVectorStoreDeletionStatus",
  "csharp"
);

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
@@clientName(FileInfo, "PersistentAgentFileInfo", "csharp");
@@clientName(FileInfo.bytes, "Size", "csharp");
@@clientName(FilePurpose, "PersistentAgentFilePurpose", "csharp");
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
@@clientName(FunctionName, "PersistentAgentsFunctionName", "csharp");
@@clientName(VectorStore, "PersistentAgentsVectorStore", "csharp");
@@clientName(ThreadMessage, "PersistentThreadMessage", "csharp");
@@clientName(MessageDeltaTextUrlCitationAnnotation,
  "MessageDeltaTextUriCitationAnnotation",
  "csharp"
);
@@clientName(MessageDeltaTextUrlCitationAnnotation.urlCitation,
  "UriCitation",
  "csharp"
);
@@clientName(MessageDeltaTextUrlCitationDetails,
  "MessageDeltaTextUriCitationDetails",
  "csharp"
);
@@clientName(MessageDeltaTextUrlCitationDetails.url, "Uri", "csharp");

@@clientName(MessageImageUrlParam, "MessageImageUriParam", "csharp");
@@clientName(MessageImageUrlParam.url, "Uri", "csharp");
@@clientName(MessageInputImageUrlBlock, "MessageInputImageUriBlock", "csharp");
@@clientName(MessageInputImageUrlBlock.imageUrl, "ImageUrl", "csharp");
@@clientName(MessageTextUrlCitationDetails,
  "MessageTextUriCitationDetails",
  "csharp"
);
@@clientName(MessageTextUrlCitationDetails.url, "Uri", "csharp");
@@clientName(MessageTextUrlCitationAnnotation,
  "MessageTextUriCitationAnnotation",
  "csharp"
);
@@clientName(MessageTextUrlCitationAnnotation.urlCitation,
  "UriCitation",
  "csharp"
);
// Run stream events
@@clientName(RunStepStreamEvent.ThreadRunStepCompleted,
  "RunStepCompleted",
  "csharp"
);
@@clientName(RunStepStreamEvent.ThreadRunStepCreated,
  "RunStepCreated",
  "csharp"
);
@@clientName(RunStepStreamEvent.ThreadRunStepDelta, "RunStepDelta", "csharp");
@@clientName(RunStepStreamEvent.ThreadRunStepExpired,
  "RunStepExpired",
  "csharp"
);
@@clientName(RunStepStreamEvent.ThreadRunStepFailed, "RunStepFailed", "csharp");
@@clientName(RunStepStreamEvent.ThreadRunStepInProgress,
  "RunStepInProgress",
  "csharp"
);
@@clientName(RunStepStreamEvent.ThreadRunStepCancelled,
  "RunStepCancelled",
  "csharp"
);
// Message stream events
@@clientName(MessageStreamEvent.ThreadMessageCompleted,
  "MessageCompleted",
  "csharp"
);
@@clientName(MessageStreamEvent.ThreadMessageCreated,
  "MessageCreated",
  "csharp"
);
@@clientName(MessageStreamEvent.ThreadMessageDelta, "MessageDelta", "csharp");
@@clientName(MessageStreamEvent.ThreadMessageIncomplete,
  "MessageIncomplete",
  "csharp"
);
@@clientName(MessageStreamEvent.ThreadMessageInProgress,
  "MessageInProgress",
  "csharp"
);

@@clientName(TruncationObject, "Truncation", "csharp");
@@clientName(VectorStoreAutoChunkingStrategyRequest,
  "VectorStoreAutoChunkingStrategy",
  "csharp"
);
@@clientName(VectorStoreChunkingStrategyRequest,
  "VectorStoreChunkingStrategy",
  "csharp"
);
@@clientName(OpenApiFunctionDefinition.auth, "OpenApiAuthentication", "csharp");
// Python assistant vs agent renames
@@clientName(ThreadMessage.assistantId, "agentId", "python");
@@clientName(GetAgentOptions.assistantId, "agentId", "python");
@@clientName(UpdateAgentOptions.assistantId, "agentId", "python");
@@clientName(DeleteAgentOptions.assistantId, "agentId", "python");
@@clientName(RunStep.assistantId, "agentId", "python");
@@clientName(ThreadRun.assistantId, "agentId", "python");
@@clientName(CreateRunOptions.assistantId, "agentId", "python");
@@clientName(CreateAndRunThreadOptions.assistantId, "agentId", "python");
