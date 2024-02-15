import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.versioned(Azure.AI.OpenAI.Assistants.ServiceApiVersions)
namespace Azure.AI.OpenAI.Assistants;

// Trivial response value containers should treat these containers as internal details and instead surface a shimmed
// operation that exposes the underlying data directly.
@@projectedName(AssistantDeletionStatus,
  "csharp",
  "InternalAssistantDeletionStatus"
);
@@access(deleteAssistant, Access.internal, "csharp");
@@clientName(deleteAssistant, "InternalDeleteAssistant", "csharp");
@@access(AssistantFileDeletionStatus, Access.internal, "csharp");
@@projectedName(AssistantFileDeletionStatus,
  "csharp",
  "InternalAssistantFileDeletionStatus"
);
@@access(deleteAssistantFile, Access.internal, "csharp");
@@clientName(deleteAssistantFile, "InternalUnlinkAssistantFile", "csharp");
@@access(deleteThread, Access.internal, "csharp");
@@clientName(deleteThread, "InternalDeleteThread", "csharp");
@@access(listAssistants, Access.internal, "csharp");
@@clientName(listAssistants, "InternalGetAssistants", "csharp");
@@access(listAssistantFiles, Access.internal, "csharp");
@@clientName(listAssistantFiles, "InternalGetAssistantFiles", "csharp");
@@access(listMessageFiles, Access.internal, "csharp");
@@clientName(listMessageFiles, "InternalGetMessageFiles", "csharp");
@@access(listRunSteps, Access.internal, "csharp");
@@clientName(listRunSteps, "InternalGetRunSteps", "csharp");
@@access(listMessages, Access.internal, "csharp");
@@clientName(listMessages, "InternalGetMessages", "csharp");
@@access(listRuns, Access.internal, "csharp");
@@clientName(listRuns, "InternalGetRuns", "csharp");
@@access(FileListResponse, Access.internal, "csharp");
@@clientName(FileListResponse, "InternalFileListResponse", "csharp");
@@access(listFiles, Access.internal, "csharp");
@@clientName(listFiles, "InternalListFiles", "csharp");
@@access(FileDeletionStatus, Access.internal, "csharp");
@@clientName(FileDeletionStatus, "InternalFileDeletionStatus", "csharp");
@@access(deleteFile, Access.internal, "csharp");
@@clientName(deleteFile, "InternalDeleteFile", "csharp");

// In addition to top-level response value containers, trivial intermediate structure -- levels of single-use model
// hierarchy that don't convey explanatory or functional benefit to consumers of the surface -- should also be
// internalized and merged into the more useful top-level type.

// FunctionToolDefinition: merge FunctionDefinition structure to recast e.g. toolDefinition.function.name into
// toolDefinition.name

@@access(FunctionDefinition, Access.internal);
@@clientName(FunctionDefinition, "InternalFunctionDefinition", "csharp");
@@clientName(FunctionToolDefinition.function, "InternalFunction", "csharp");

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

// RequiredFunctionToolCall, RunStepFunctionToolCall: include name/arguments/output directly

@@access(RunStepFunctionToolCallDetails, Access.internal);
@@projectedName(RunStepFunctionToolCallDetails,
  "csharp",
  "InternalRunStepFunctionToolCallDetails"
);
@@clientName(RequiredFunctionToolCall.function, "InternalDetails", "csharp");
@@access(RequiredFunctionToolCallDetails, Access.internal);
@@projectedName(RequiredFunctionToolCallDetails,
  "csharp",
  "InternalRequiredFunctionToolCallDetails"
);
@@clientName(RunStepFunctionToolCall.function, "InternalDetails", "csharp");

// RunStepCodeInterpreterToolCall: include input/outputs directly

@@access(RunStepCodeInterpreterToolCallDetails, Access.internal);
@@projectedName(RunStepCodeInterpreterToolCallDetails,
  "csharp",
  "InternalCodeInterpreterToolCallDetails"
);
@@projectedName(RunStepCodeInterpreterToolCall.codeInterpreter,
  "csharp",
  "InternalDetails"
);

// MessageTextContent: text/annotations can also merge

@@access(MessageTextDetails, Access.internal);
@@clientName(MessageTextDetails, "InternalMessageTextDetails", "csharp");
@@clientName(MessageTextContent.text, "InternalDetails", "csharp");

// MessageTextFileCitationAnnotation: file_id/quote don't need another type

@@access(MessageTextFileCitationDetails, Access.internal);
@@projectedName(MessageTextFileCitationDetails,
  "csharp",
  "InternalMessageTextFileCitationDetails"
);
@@projectedName(MessageTextFileCitationAnnotation.fileCitation,
  "csharp",
  "InternalDetails"
);

// MessageTextFilePathAnnotation: file_id doesn't need a separate details client type

@@access(MessageTextFilePathDetails, Access.internal);
@@projectedName(MessageTextFilePathDetails,
  "csharp",
  "InternalMessageTextFilePathDetails"
);
@@projectedName(MessageTextFilePathAnnotation.filePath,
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
@@clientName(MessageImageFileContent.imageFile, "InternalDetails", "csharp");
@@projectedName(MessageImageFileIdDetails,
  "csharp",
  "InternalMessageImageFileIdDetails"
);
@@clientName(MessageImageFileDetails.fileId, "InternalDetails", "csharp");

// Several of the content item types are not intended to be used as input

@@usage(MessageTextContent, Usage.output);
@@usage(MessageImageFileContent, Usage.output);
@@usage(MessageTextContent, Usage.output);
@@usage(MessageTextFileCitationAnnotation, Usage.output);
@@usage(MessageTextFilePathAnnotation, Usage.output);

// Ensure some shared types remain public despite interaction with previously internalized details

@@access(MessageTextFilePathAnnotation, Access.public);
@@access(MessageTextFileCitationAnnotation, Access.public);
@@access(ListSortOrder, Access.public);
@@access(RequiredToolCall, Access.public);
@@usage(FilePurpose, Usage.input | Usage.output);
@@usage(ListSortOrder, Usage.input | Usage.output);

// Additional, language-specific idiomatic renames

@@clientName(OpenAIFile, "OpenAIFile", "csharp");
@@clientName(OpenAIFile.bytes, "Size", "csharp");
@@clientName(FilePurpose, "OpenAIFilePurpose", "csharp");
@@clientName(ThreadMessage.content, "ContentItems", "csharp");
@@clientName(MessageTextDetails.value, "Text", "csharp");
@@clientName(CreateRunOptions.`model`, "OverrideModelName", "csharp");
@@projectedName(CreateRunOptions.instructions,
  "csharp",
  "OverrideInstructions"
);
@@clientName(CreateRunOptions.tools, "OverrideTools", "csharp");
@@projectedName(CreateAndRunThreadOptions.`model`,
  "csharp",
  "OverrideModelName"
);
@@projectedName(CreateAndRunThreadOptions.instructions,
  "csharp",
  "OverrideInstructions"
);
@@clientName(CreateAndRunThreadOptions.tools, "OverrideTools", "csharp");
// From https://platform.openai.com/docs/assistants/how-it-works
// "Note that deleting an AssistantFile doesn’t delete the original File object, it simply deletes the association
// between that File and the Assistant."
@@clientName(createAssistantFile, "LinkAssistantFile", "csharp");
// 'Unlink' counterpart already renamed for DeletionStatus merge
