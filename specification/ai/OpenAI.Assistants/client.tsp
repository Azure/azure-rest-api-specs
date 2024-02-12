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
@@projectedName(deleteAssistant, "csharp", "InternalDeleteAssistant");
@@access(AssistantFileDeletionStatus, Access.internal, "csharp");
@@projectedName(AssistantFileDeletionStatus,
  "csharp",
  "InternalAssistantFileDeletionStatus"
);
@@access(deleteAssistantFile, Access.internal, "csharp");
@@projectedName(deleteAssistantFile, "csharp", "InternalUnlinkAssistantFile");
@@access(deleteThread, Access.internal, "csharp");
@@projectedName(deleteThread, "csharp", "InternalDeleteThread");
@@access(listAssistants, Access.internal, "csharp");
@@projectedName(listAssistants, "csharp", "InternalGetAssistants");
@@access(listAssistantFiles, Access.internal, "csharp");
@@projectedName(listAssistantFiles, "csharp", "InternalGetAssistantFiles");
@@access(listMessageFiles, Access.internal, "csharp");
@@projectedName(listMessageFiles, "csharp", "InternalGetMessageFiles");
@@access(listRunSteps, Access.internal, "csharp");
@@projectedName(listRunSteps, "csharp", "InternalGetRunSteps");
@@access(listMessages, Access.internal, "csharp");
@@projectedName(listMessages, "csharp", "InternalGetMessages");
@@access(listRuns, Access.internal, "csharp");
@@projectedName(listRuns, "csharp", "InternalGetRuns");
@@access(FileListResponse, Access.internal, "csharp");
@@projectedName(FileListResponse, "csharp", "InternalFileListResponse");
@@access(listFiles, Access.internal, "csharp");
@@projectedName(listFiles, "csharp", "InternalListFiles");
@@access(FileDeletionStatus, Access.internal, "csharp");
@@projectedName(FileDeletionStatus, "csharp", "InternalFileDeletionStatus");
@@access(deleteFile, Access.internal, "csharp");
@@projectedName(deleteFile, "csharp", "InternalDeleteFile");

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

// RequiredFunctionToolCall, RunStepFunctionToolCall: include name/arguments/output directly

@@access(RunStepFunctionToolCallDetails, Access.internal);
@@projectedName(RunStepFunctionToolCallDetails,
  "csharp",
  "InternalRunStepFunctionToolCallDetails"
);
@@projectedName(RequiredFunctionToolCall.function, "csharp", "InternalDetails");
@@access(RequiredFunctionToolCallDetails, Access.internal);
@@projectedName(RequiredFunctionToolCallDetails,
  "csharp",
  "InternalRequiredFunctionToolCallDetails"
);
@@projectedName(RunStepFunctionToolCall.function, "csharp", "InternalDetails");

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
@@projectedName(MessageTextDetails, "csharp", "InternalMessageTextDetails");
@@projectedName(MessageTextContent.text, "csharp", "InternalDetails");

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

@@projectedName(OpenAIFile, "csharp", "OpenAIFile");
@@projectedName(OpenAIFile.bytes, "csharp", "Size");
@@projectedName(FilePurpose, "csharp", "OpenAIFilePurpose");
@@projectedName(ThreadMessage.content, "csharp", "ContentItems");
@@projectedName(MessageTextDetails.value, "csharp", "Text");
@@projectedName(CreateRunOptions.`model`, "csharp", "OverrideModelName");
@@projectedName(CreateRunOptions.instructions,
  "csharp",
  "OverrideInstructions"
);
@@projectedName(CreateRunOptions.tools, "csharp", "OverrideTools");
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
@@projectedName(createAssistantFile, "csharp", "LinkAssistantFile");
// 'Unlink' counterpart already renamed for DeletionStatus merge
