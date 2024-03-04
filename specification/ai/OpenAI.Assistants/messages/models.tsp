import "@typespec/versioning";

namespace Azure.AI.OpenAI.Assistants;

using TypeSpec.Versioning;

@doc("A single message within an assistant thread, as provided during that thread's creation for its initial state.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ThreadInitializationMessage {
  @doc("The role associated with the assistant thread message. Currently, only 'user' is supported when providing initial messages to a new thread.")
  role: MessageRole;

  @doc("The textual content of the initial message. Currently, robust input including images and annotated text may only be provided via a separate call to the create message API.")
  content: string;

  @encodedName("application/json", "file_ids")
  @doc("""
  A list of file IDs that the assistant should use. Useful for tools like retrieval and code_interpreter that can
  access files.
  """)
  fileIds?: string[] = [];

  ...OptionalNullableMetadata;
}

@doc("A single, existing message within an assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ThreadMessage {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread.message'.")
  object: "thread.message";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  @encodedName("application/json", "thread_id")
  @doc("The ID of the thread that this message belongs to.")
  threadId: string;

  @doc("The role associated with the assistant thread message.")
  role: MessageRole;

  @doc("The list of content items associated with the assistant thread message.")
  content: MessageContent[];

  @encodedName("application/json", "assistant_id")
  @doc("If applicable, the ID of the assistant that authored this message.")
  assistantId?: string;

  @encodedName("application/json", "run_id")
  @doc("If applicable, the ID of the run associated with the authoring of this message.")
  runId?: string;

  @encodedName("application/json", "file_ids")
  @doc("""
  A list of file IDs that the assistant should use. Useful for tools like retrieval and code_interpreter that can
  access files.
  """)
  fileIds: string[];

  ...RequiredNullableMetadata;
}

// Message content types: "text" | "image_file"

@discriminator("type")
@doc("An abstract representation of a single item of thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageContent {
  @doc("The object type.")
  type: string;
}

@doc("A representation of a textual item of thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextContent extends MessageContent {
  @doc("The object type, which is always 'text'.")
  type: "text";

  @doc("The text and associated annotations for this thread message content item.")
  text: MessageTextDetails;
}

@doc("A representation of image file content in a thread message.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageImageFileContent extends MessageContent {
  @doc("The object type, which is always 'image_file'.")
  type: "image_file";

  @encodedName("application/json", "image_file")
  @doc("The image file for this thread message content item.")
  imageFile: MessageImageFileDetails;
}

// Text content details

@doc("The text and associated annotations for a single item of assistant thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextDetails {
  @doc("The text data.")
  value: string;

  @doc("A list of annotations associated with this text.")
  annotations: MessageTextAnnotation[];
}

// Annotations, used by text content: "file_citation" | "file_path"

@discriminator("type")
@doc("An abstract representation of an annotation to text thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextAnnotation {
  @doc("The object type.")
  type: string;

  @doc("The textual content associated with this text annotation item.")
  text: string;

  @encodedName("application/json", "start_index")
  @doc("The first text index associated with this text annotation.")
  startIndex: int32;

  @encodedName("application/json", "end_index")
  @doc("The last text index associated with this text annotation.")
  endIndex: int32;
}

// File citation annotation + details

@doc("A citation within the message that points to a specific quote from a specific File associated with the assistant or the message. Generated when the assistant uses the 'retrieval' tool to search files.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextFileCitationAnnotation extends MessageTextAnnotation {
  @doc("The object type, which is always 'file_citation'.")
  type: "file_citation";

  @encodedName("application/json", "file_citation")
  @doc("""
  A citation within the message that points to a specific quote from a specific file.
  Generated when the assistant uses the "retrieval" tool to search files.
  """)
  fileCitation: MessageTextFileCitationDetails;
}

@doc("A representation of a file-based text citation, as used in a file-based annotation of text thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextFileCitationDetails {
  @encodedName("application/json", "file_id")
  @doc("The ID of the file associated with this citation.")
  fileId: string;

  @doc("The specific quote cited in the associated file.")
  quote: string;
}

// File path annotation + details

@doc("A citation within the message that points to a file located at a specific path.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextFilePathAnnotation extends MessageTextAnnotation {
  @doc("The object type, which is always 'file_path'.")
  type: "file_path";

  @encodedName("application/json", "file_path")
  @doc("A URL for the file that's generated when the assistant used the code_interpreter tool to generate a file.")
  filePath: MessageTextFilePathDetails;
}

@doc("An encapsulation of an image file ID, as used by message image content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageTextFilePathDetails {
  @doc("The ID of the specific file that the citation is from.")
  @encodedName("application/json", "file_id")
  fileId: string;
}

// Image file content details

@doc("An image reference, as represented in thread message content.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageImageFileDetails {
  @encodedName("application/json", "file_id")
  @doc("The ID for the file associated with this image.")
  fileId: string;
}

// Assistant message file representation, used for message "list files" route responses

@doc("Information about a file attached to an assistant thread message.")
@added(ServiceApiVersions.v2024_02_15_preview)
model MessageFile {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread.message.file'.")
  object: "thread.message.file";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  @encodedName("application/json", "message_id")
  @doc("The ID of the message that this file is attached to.")
  messageId: string;
}
