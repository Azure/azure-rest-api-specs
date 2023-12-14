import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.versioned(Azure.AI.OpenAI.Assistants.ServiceApiVersions)
namespace Azure.AI.OpenAI.Assistants;

// Language-specific idiomatic renames
@@projectedName(File, "csharp", "OpenAIFile");
@@projectedName(File.bytes, "csharp", "Size");
@@projectedName(FilePurpose, "csharp", "OpenAIFilePurpose");
@@projectedName(ThreadMessage.content, "csharp", "ContentItems");
@@projectedName(MessageTextContent.text, "csharp", "AnnotatedText");
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

// Trivial response value containers should treat these containers as internal details and instead surface a shimmed
// operation that exposes the underlying data directly.
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
@@access(FunctionDefinition, Access.internal);
@@projectedName(FunctionDefinition, "csharp", "InternalFunctionDefinition");
@@projectedName(FunctionToolDefinition.function, "csharp", "InternalFunction");
@@access(SubmitToolOutputsDetails, Access.internal);
@@projectedName(SubmitToolOutputsDetails,
  "csharp",
  "InternalSubmitToolOutputsDetails"
);
@@projectedName(SubmitToolOutputsAction.submitToolOutputs,
  "csharp",
  "InternalSubmitToolOutputs"
);

// Ensure some types remain public despite interaction with previously internalized details
@@usage(FilePurpose, Usage.input | Usage.output);
@@usage(ListSortOrder, Usage.input | Usage.output);
