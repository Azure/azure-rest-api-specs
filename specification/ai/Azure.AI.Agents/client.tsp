import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
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
  "python, javascript"
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

@@access(Azure.AI.Agents.Messages.delete, Access.internal, "csharp, python");
@@clientName(Azure.AI.Agents.Messages.delete,
  "InternalDeleteMessage",
  "csharp"
);

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

@@clientName(RunStepOpenAPIToolCall, "RunStepOpenApiToolCall", "java");
@@clientName(RunStepOpenAPIToolCall.openAPI, "openApi", "java");

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
@@usage(MessageDeltaTextUrlCitationDetails, Usage.json);
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

@client({ name: "PersistentAgentsClient", service: Azure.AI.Agents}, "java")
@useDependency(Azure.AI.Agents.Versions.v2025_05_01)
namespace Agents.Persistent {

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
  op createThreadAndRun is Azure.AI.Agents.createThreadAndRun;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-client-generator-core/client-service" "TCGC bug"
  @operationGroup("java")
  interface PersistentAgentsAdministration {
    getAgent is Azure.AI.Agents.getAgent;
    createAgent is Azure.AI.Agents.createAgent;
    updateAgent is Azure.AI.Agents.updateAgent;
    @access(Access.internal)
    deleteAgentInternal is Azure.AI.Agents.deleteAgent;
    listAgents is Azure.AI.Agents.listAgents;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-client-generator-core/client-service" "TCGC bug"
  @operationGroup("java")
  @route("/files")
  interface PersistentAgentsFiles {
    @access(Access.internal)
    listFilesInternal is Azure.AI.Agents.Files.listFiles;
    #suppress "@azure-tools/typespec-azure-core/byos" "mirrored API"
    uploadFile is Azure.AI.Agents.Files.uploadFile;
    getFile is Azure.AI.Agents.Files.getFile;
    getFileContent is Azure.AI.Agents.Files.getFileContent;
    @access(Access.internal)
    deleteFileInternal is Azure.AI.Agents.Files.deleteFile;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-client-generator-core/client-service" "TCGC bug"
  @operationGroup("java")
  @route("/threads/{threadId}/messages")
  interface ThreadMessages {
    createMessage is Azure.AI.Agents.Messages.createMessage;
    listMessages is Azure.AI.Agents.Messages.listMessages;
    getMessage is Azure.AI.Agents.Messages.getMessage;
    updateMessage is Azure.AI.Agents.Messages.updateMessage;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-client-generator-core/client-service" "TCGC bug"
  @operationGroup("java")
  @route("/threads/{threadId}/runs")
  interface ThreadRuns {
    createRun is Azure.AI.Agents.Runs.createRun;
    listRuns is Azure.AI.Agents.Runs.listRuns;
    getRun is Azure.AI.Agents.Runs.getRun;
    updateRun is Azure.AI.Agents.Runs.updateRun;
    submitToolOutputsToRun is Azure.AI.Agents.Runs.submitToolOutputsToRun;
    cancelRun is Azure.AI.Agents.Runs.cancelRun;
    
    listRunSteps is Azure.AI.Agents.RunSteps.listRunSteps;  
    @route("/{runId}/steps/{stepId}")
    getRunStep is Azure.AI.Agents.RunSteps.getRunStep;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @operationGroup("java")
  @route("/threads")
  interface Threads {
    createThread is Azure.AI.Agents.Threads.createThread;
    listThreads is Azure.AI.Agents.Threads.listThreads;
    getThread is Azure.AI.Agents.Threads.getThread;
    updateThread is Azure.AI.Agents.Threads.updateThread;
    @access(Access.internal)
    deleteThreadInternal is Azure.AI.Agents.Threads.deleteThread;
  }

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @operationGroup("java")
  interface VectorStores {
    @route("/vector_stores")
    createVectorStore is Azure.AI.Agents.VectorStores.createVectorStore;
    @route("/vector_stores/{vectorStoreId}")
    getVectorStore is Azure.AI.Agents.VectorStores.getVectorStore;
    @route("/vector_stores/{vectorStoreId}")
    modifyVectorStore is Azure.AI.Agents.VectorStores.modifyVectorStore;
    @route("/vector_stores")
    listVectorStores is Azure.AI.Agents.VectorStores.listVectorStores;
    @route("/vector_stores/{vectorStoreId}")
    @access(Access.internal)
    deleteVectorStoreInternal is Azure.AI.Agents.VectorStores.deleteVectorStore;

    @route("/vector_stores/{vectorStoreId}/files")
    createVectorStoreFile is Azure.AI.Agents.VectorStoreFiles.createVectorStoreFile;
    @route("/vector_stores/{vectorStoreId}/files/{fileId}")
    getVectorStoreFile is Azure.AI.Agents.VectorStoreFiles.getVectorStoreFile;
    @route("/vector_stores/{vectorStoreId}/files/{fileId}")
    @access(Access.internal)
    deleteVectorStoreFileInternal is Azure.AI.Agents.VectorStoreFiles.deleteVectorStoreFile;
    @route("/vector_stores/{vectorStoreId}/files")
    listVectorStoreFiles is Azure.AI.Agents.VectorStoreFiles.listVectorStoreFiles;

    @route("/vector_stores/{vectorStoreId}/file_batches")
    createVectorStoreFileBatch is Azure.AI.Agents.VectorStoreFileBatches.createVectorStoreFileBatch;
    @route("/vector_stores/{vectorStoreId}/file_batches/{batchId}")
    getVectorStoreFileBatch is Azure.AI.Agents.VectorStoreFileBatches.getVectorStoreFileBatch;
    @route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/cancel")
    cancelVectorStoreFileBatch is Azure.AI.Agents.VectorStoreFileBatches.cancelVectorStoreFileBatch;
    @route("/vector_stores/{vectorStoreId}/file_batches/{batchId}/files")
    listVectorStoreFileBatchFiles is Azure.AI.Agents.VectorStoreFileBatches.listVectorStoreFileBatchFiles;
  }
}

@@clientName(Azure.AI.Agents.BingCustomSearchConfiguration.setLang , "Language", "java");