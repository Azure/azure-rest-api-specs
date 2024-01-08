import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.versioned(Azure.AI.OpenAI.Assistants.ServiceApiVersions)
namespace Azure.AI.OpenAI.Assistants;

// Trivial response value containers should treat these containers as internal details and instead surface a shimmed
// operation that exposes the underlying data directly.
@@access(DeletionStatus, Access.internal);
@@projectedName(DeletionStatus, "csharp", "InternalDeletionStatus");
@@access(AssistantDeletionStatus, Access.internal);
@@projectedName(AssistantDeletionStatus,
  "csharp",
  "InternalAssistantDeletionStatus"
);
@@access(Assistants.deleteAssistant, Access.internal);
@@projectedName(Assistants.deleteAssistant,
  "csharp",
  "InternalDeleteAssistant"
);
@@access(AssistantFileDeletionStatus, Access.internal);
@@projectedName(AssistantFileDeletionStatus,
  "csharp",
  "InternalAssistantFileDeletionStatus"
);
@@access(Assistants.deleteAssistantFile, Access.internal);
@@projectedName(Assistants.deleteAssistantFile,
  "csharp",
  "InternalUnlinkAssistantFile"
);
@@access(ThreadDeletionStatus, Access.internal);
@@access(AssistantThreads.deleteThread, Access.internal);
@@projectedName(AssistantThreads.deleteThread,
  "csharp",
  "InternalDeleteThread"
);
@@access(Assistants.listAssistants, Access.internal);
@@projectedName(Assistants.listAssistants, "csharp", "InternalGetAssistants");
@@access(Assistants.listAssistantFiles, Access.internal);
@@projectedName(Assistants.listAssistantFiles,
  "csharp",
  "InternalGetAssistantFiles"
);
@@access(ThreadMessages.listMessageFiles, Access.internal);
@@projectedName(ThreadMessages.listMessageFiles,
  "csharp",
  "InternalGetMessageFiles"
);
@@access(RunSteps.listRunSteps, Access.internal);
@@projectedName(RunSteps.listRunSteps, "csharp", "InternalGetRunSteps");
@@access(ThreadMessages.listMessages, Access.internal);
@@projectedName(ThreadMessages.listMessages, "csharp", "InternalGetMessages");
@@access(ThreadRuns.listRuns, Access.internal);
@@projectedName(ThreadRuns.listRuns, "csharp", "InternalGetRuns");
@@access(FileListResponse, Access.internal);
@@projectedName(FileListResponse, "csharp", "InternalFileListResponse");
@@access(Files.listFiles, Access.internal);
@@projectedName(Files.listFiles, "csharp", "InternalListFiles");
@@access(FileDeletionStatus, Access.internal);
@@projectedName(FileDeletionStatus, "csharp", "InternalFileDeletionStatus");
@@access(Files.deleteFile, Access.internal);
@@projectedName(Files.deleteFile, "csharp", "InternalDeleteFile");

// In addition to top-level response value containers, trivial intermediate structure -- levels of single-use model
// hierarchy that don't convey explanatory or functional benefit to consumers of the surface -- should also be
// internalized and merged into the more useful top-level type.

// FunctionToolDefinition: merge FunctionDefinition structure to recast e.g. toolDefinition.function.name into
// toolDefinition.name

@@access(FunctionDefinition, Access.internal);
@@projectedName(FunctionDefinition, "csharp", "InternalFunctionDefinition");
@@projectedName(FunctionToolDefinition.function, "csharp", "InternalFunction");

// SubmitToolOutputsAction: include .tool_calls directly rather than via an intermediate .details.

@@access(SubmitToolOutputsDetails, Access.internal);
@@projectedName(SubmitToolOutputsDetails,
  "csharp",
  "InternalSubmitToolOutputsDetails"
);
@@projectedName(SubmitToolOutputsAction.submitToolOutputs,
  "csharp",
  "InternalDetails"
);

// FunctionToolCall: include name/arguments directly

@@access(FunctionToolCallDetails, Access.internal);
@@projectedName(FunctionToolCallDetails,
  "csharp",
  "InternalFunctionToolCallDetails"
);
@@projectedName(FunctionToolCall.function, "csharp", "InternalDetails");

// CodeInterpreterToolCall: include input/outputs directly

@@access(CodeInterpreterToolCallDetails, Access.internal);
@@projectedName(CodeInterpreterToolCallDetails,
  "csharp",
  "InternalCodeInterpreterToolCallDetails"
);
@@projectedName(CodeInterpreterToolCall.codeInterpreter,
  "csharp",
  "InternalDetails"
);

// MessageTextContent: text/annotations can also merge

@@access(MessageTextDetails, Access.internal);
@@projectedName(MessageTextDetails, "csharp", "InternalMessageTextDetails");
@@projectedName(MessageTextContent.text, "csharp", "InternalDetails");

// MessageFileCitationTextAnnotation: file_id/quote don't need another type

@@access(MessageTextFileCitationDetails, Access.internal);
@@projectedName(MessageTextFileCitationDetails,
  "csharp",
  "InternalMessageTextFileCitationDetails"
);
@@projectedName(MessageFileCitationTextAnnotation.fileCitation,
  "csharp",
  "InternalDetails"
);

// MessageFilePathTextAnnotation: file_id doesn't need a separate details client type

@@access(MessageFilePathDetails, Access.internal);
@@projectedName(MessageFilePathDetails,
  "csharp",
  "InternalMessageFilePathDetails"
);
@@projectedName(MessageFilePathTextAnnotation.filePath,
  "csharp",
  "InternalDetails"
);

// MessageImageFileContent: *two* levels of intermediate structure can be squashed to bring file_id to the parent
// type. Per earlier precedent with image generation, even the introduction of more image file representations (e.g.
// base64) are better accomplished via another approach at the client layer.

@@access(MessageImageFileDetails, Access.internal);
@@access(MessageImageFileIdDetails, Access.internal);
@@projectedName(MessageImageFileDetails,
  "csharp",
  "InternalMessageImageFileDetails"
);
@@projectedName(MessageImageFileContent.imageFile, "csharp", "InternalDetails");
@@projectedName(MessageImageFileIdDetails,
  "csharp",
  "InternalMessageImageFileIdDetails"
);
@@projectedName(MessageImageFileDetails.fileId, "csharp", "InternalDetails");

// Several of the content item types are not intended to be used as input

@@usage(MessageTextContent, Usage.output);
@@usage(MessageImageFileContent, Usage.output);
@@usage(MessageTextContent, Usage.output);
@@usage(MessageFileCitationTextAnnotation, Usage.output);
@@usage(MessageFilePathTextAnnotation, Usage.output);

// Ensure some shared types remain public despite interaction with previously internalized details

@@access(MessageFilePathTextAnnotation, Access.public);
@@access(MessageFileCitationTextAnnotation, Access.public);
@@usage(FilePurpose, Usage.input | Usage.output);
@@usage(ListSortOrder, Usage.input | Usage.output);

// Additional, language-specific idiomatic renames

@@projectedName(File, "csharp", "OpenAIFile");
@@projectedName(File.bytes, "csharp", "Size");
@@projectedName(FilePurpose, "csharp", "OpenAIFilePurpose");
@@projectedName(ThreadMessage.content, "csharp", "ContentItems");
@@projectedName(MessageTextDetails.value, "csharp", "Text");
@@projectedName(CreateAndRunThreadOptions.`model`,
  "csharp",
  "OverrideModelName"
);
@@projectedName(CreateAndRunThreadOptions.instructions,
  "csharp",
  "OverrideInstructions"
);
@@projectedName(CreateAndRunThreadOptions.tools, "csharp", "OverrideTools");

// From https://platform.openai.com/docs/assistants/how-it-works
// "Note that deleting an AssistantFile doesn’t delete the original File object, it simply deletes the association
// between that File and the Assistant."
@@projectedName(Assistants.createAssistantFile, "csharp", "LinkAssistantFile");
// 'Unlink' counterpart already renamed for DeletionStatus merge
