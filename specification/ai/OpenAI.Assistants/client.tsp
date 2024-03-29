import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.versioned(Azure.AI.OpenAI.Assistants.ServiceApiVersions)
namespace Azure.AI.OpenAI.Assistants;

// Trivial response value containers should treat these containers as internal details and instead surface a shimmed
// operation that exposes the underlying data directly.
@@clientName(AssistantDeletionStatus,
  "InternalAssistantDeletionStatus",
  "csharp"
);
@@access(deleteAssistant, Access.internal, "csharp");
@@clientName(deleteAssistant, "InternalDeleteAssistant", "csharp");
@@access(AssistantFileDeletionStatus, Access.internal, "csharp");
@@clientName(AssistantFileDeletionStatus,
  "InternalAssistantFileDeletionStatus",
  "csharp"
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
@@clientName(SubmitToolOutputsDetails,
  "InternalSubmitToolOutputsDetails",
  "csharp"
);
@@clientName(SubmitToolOutputsAction.submitToolOutputs,
  "InternalDetails",
  "csharp"
);

// RequiredFunctionToolCall, RunStepFunctionToolCall: include name/arguments/output directly

@@access(RunStepFunctionToolCallDetails, Access.internal);
@@clientName(RunStepFunctionToolCallDetails,
  "InternalRunStepFunctionToolCallDetails",
  "csharp"
);
@@clientName(RequiredFunctionToolCall.function, "InternalDetails", "csharp");
@@access(RequiredFunctionToolCallDetails, Access.internal);
@@clientName(RequiredFunctionToolCallDetails,
  "InternalRequiredFunctionToolCallDetails",
  "csharp"
);
@@clientName(RunStepFunctionToolCall.function, "InternalDetails", "csharp");

// RunStepCodeInterpreterToolCall: include input/outputs directly

@@access(RunStepCodeInterpreterToolCallDetails, Access.internal);
@@clientName(RunStepCodeInterpreterToolCallDetails,
  "InternalCodeInterpreterToolCallDetails",
  "csharp"
);
@@clientName(RunStepCodeInterpreterToolCall.codeInterpreter,
  "InternalDetails",
  "csharp"
);

// MessageTextContent: text/annotations can also merge

@@access(MessageTextDetails, Access.internal);
@@clientName(MessageTextDetails, "InternalMessageTextDetails", "csharp");
@@clientName(MessageTextContent.text, "InternalDetails", "csharp");

// MessageTextFileCitationAnnotation: file_id/quote don't need another type

@@access(MessageTextFileCitationDetails, Access.internal);
@@clientName(MessageTextFileCitationDetails,
  "InternalMessageTextFileCitationDetails",
  "csharp"
);
@@clientName(MessageTextFileCitationAnnotation.fileCitation,
  "InternalDetails",
  "csharp"
);

// MessageTextFilePathAnnotation: file_id doesn't need a separate details client type

@@access(MessageTextFilePathDetails, Access.internal);
@@clientName(MessageTextFilePathDetails,
  "InternalMessageTextFilePathDetails",
  "csharp"
);
@@clientName(MessageTextFilePathAnnotation.filePath,
  "InternalDetails",
  "csharp"
);

// MessageImageFileContent: *two* levels of intermediate structure can be squashed to bring file_id to the parent
// type. Per earlier precedent with image generation, even the introduction of more image file representations (e.g.
// base64) are better accomplished via another approach at the client layer.

@@access(MessageImageFileDetails, Access.internal);
@@clientName(MessageImageFileDetails,
  "InternalMessageImageFileDetails",
  "csharp"
);
@@clientName(MessageImageFileContent.imageFile, "InternalDetails", "csharp");
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
@@clientName(CreateRunOptions.instructions, "OverrideInstructions", "csharp");
@@clientName(CreateRunOptions.tools, "OverrideTools", "csharp");
@@clientName(CreateAndRunThreadOptions.`model`, "OverrideModelName", "csharp");
@@clientName(CreateAndRunThreadOptions.instructions,
  "OverrideInstructions",
  "csharp"
);
@@clientName(CreateAndRunThreadOptions.tools, "OverrideTools", "csharp");
// From https://platform.openai.com/docs/assistants/how-it-works
// "Note that deleting an AssistantFile doesn’t delete the original File object, it simply deletes the association
// between that File and the Assistant."
@@clientName(createAssistantFile, "LinkAssistantFile", "csharp");
// 'Unlink' counterpart already renamed for DeletionStatus merge
