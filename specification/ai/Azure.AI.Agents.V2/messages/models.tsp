import "@typespec/openapi";
import "../assistants/models.tsp";
import "../common/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Represents a message within a [thread](https://platform.openai.com/docs/api-reference/threads). */
@summary("The message object")
@extension(
  "x-oaiMeta",
  #{
    name: "The message object",
    beta: true,
    example: "{\n  \"id\": \"msg_abc123\",\n  \"object\": \"thread.message\",\n  \"created_at\": 1698983503,\n  \"thread_id\": \"thread_abc123\",\n  \"role\": \"assistant\",\n  \"content\": [\n    {\n      \"type\": \"text\",\n      \"text\": {\n        \"value\": \"Hi! How can I help you today?\",\n        \"annotations\": []\n      }\n    }\n  ],\n  \"assistant_id\": \"asst_abc123\",\n  \"run_id\": \"run_abc123\",\n  \"attachments\": [],\n  \"metadata\": {}\n}\n",
  }
)
model MessageObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.message`. */
  @extension("x-stainless-const", true)
  object: "thread.message";

  /** The Unix timestamp (in seconds) for when the message was created. */
  created_at: integer;

  /** The [thread](https://platform.openai.com/docs/api-reference/threads) ID that this message belongs to. */
  thread_id: string;

  /** The status of the message, which can be either `in_progress`, `incomplete`, or `completed`. */
  status: "in_progress" | "incomplete" | "completed";

  /** On an incomplete message, details about why the message is incomplete. */
  incomplete_details: {
    reason:
      | "content_filter"
      | "max_tokens"
      | "run_cancelled"
      | "run_expired"
      | "run_failed";
  } | null;

  /** The Unix timestamp (in seconds) for when the message was completed. */
  completed_at: integer | null;

  /** The Unix timestamp (in seconds) for when the message was marked as incomplete. */
  incomplete_at: integer | null;

  /** The entity that produced the message. One of `user` or `assistant`. */
  role: "user" | "assistant";

  /** The content of the message in array of text and/or images. */
  content: MessageContent[];

  /** If applicable, the ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) that authored this message. */
  assistant_id: string | null;

  /** The ID of the [run](https://platform.openai.com/docs/api-reference/runs) associated with the creation of this message. Value is `null` when messages are created manually using the create message or create thread endpoints. */
  run_id: string | null;

  /** A list of files attached to the message, and the tools they were added to. */
  attachments: {
    file_id?: string;
    tools?: (AssistantToolsCode | AssistantToolsFileSearchTypeOnly)[];
  }[] | null;

  metadata: Metadata;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union MessageContent {
  image_file: MessageContentImageFileObject,
  image_url: MessageContentImageUrlObject,
  text: MessageContentTextObject,
  refusal: MessageContentRefusalObject,
}

/** References an image [File](https://platform.openai.com/docs/api-reference/files) in the content of a message. */
@summary("Image file")
model MessageContentImageFileObject {
  /** Always `image_file`. */
  @extension("x-stainless-const", true)
  type: "image_file";

  image_file: {
    file_id: string;
    detail?: "auto" | "low" | "high" = "auto";
  };
}

/** References an image URL in the content of a message. */
@summary("Image URL")
model MessageContentImageUrlObject {
  /** The type of the content part. */
  @extension("x-stainless-const", true)
  type: "image_url";

  image_url: {
    url: url;
    detail?: "auto" | "low" | "high" = "auto";
  };
}

/** The text content that is part of a message. */
@summary("Text")
model MessageContentTextObject {
  /** Always `text`. */
  @extension("x-stainless-const", true)
  type: "text";

  text: {
    value: string;
    annotations: TextAnnotation[];
  };
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union TextAnnotation {
  file_citation: MessageContentTextAnnotationsFileCitationObject,
  file_path: MessageContentTextAnnotationsFilePathObject,
}

/** A citation within the message that points to a specific quote from a specific File associated with the assistant or the message. Generated when the assistant uses the "file_search" tool to search files. */
@summary("File citation")
model MessageContentTextAnnotationsFileCitationObject {
  /** Always `file_citation`. */
  @extension("x-stainless-const", true)
  type: "file_citation";

  /** The text in the message content that needs to be replaced. */
  text: string;

  file_citation: {
    file_id: string;
  };

  @minValue(0)
  start_index: integer;

  @minValue(0)
  end_index: integer;
}

/** A URL for the file that's generated when the assistant used the `code_interpreter` tool to generate a file. */
@summary("File path")
model MessageContentTextAnnotationsFilePathObject {
  /** Always `file_path`. */
  @extension("x-stainless-const", true)
  type: "file_path";

  /** The text in the message content that needs to be replaced. */
  text: string;

  file_path: {
    file_id: string;
  };

  @minValue(0)
  start_index: integer;

  @minValue(0)
  end_index: integer;
}

/** The refusal content generated by the assistant. */
@summary("Refusal")
model MessageContentRefusalObject {
  /** Always `refusal`. */
  @extension("x-stainless-const", true)
  type: "refusal";

  refusal: string;
}

model CreateMessageRequest {
  /**The role of the entity that is creating the message. Allowed values include:
  - `user`: Indicates the message is sent by an actual user and should be used in most cases to represent user-generated messages.
  - `assistant`: Indicates the message is generated by the assistant. Use this value to insert messages from the assistant into the conversation.*/
  role: "user" | "assistant";

  content: string | (MessageContentImageFileObject | MessageContentImageUrlObject | MessageRequestContentTextObject)[];

  /** A list of files attached to the message, and the tools they should be added to. */
  attachments?: {
    file_id?: string;
    tools?: (AssistantToolsCode | AssistantToolsFileSearchTypeOnly)[];
  }[] | null;

  metadata?: Metadata;
}

/** The text content that is part of a message. */
@summary("Text")
model MessageRequestContentTextObject {
  /** Always `text`. */
  @extension("x-stainless-const", true)
  type: "text";

  /** Text content to be sent to the model */
  text: string;
}

model DeleteMessageResponse {
  id: string;
  deleted: boolean;

  @extension("x-stainless-const", true)
  object: "thread.message.deleted";
}

model ListMessagesResponse {
  object: string;
  data: MessageObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

/** References an image [File](https://platform.openai.com/docs/api-reference/files) in the content of a message. */
@summary("Image file")
model MessageDeltaContentImageFileObject {
  /** The index of the content part in the message. */
  index: integer;

  /** Always `image_file`. */
  @extension("x-stainless-const", true)
  type: "image_file";

  image_file?: {
    file_id?: string;
    detail?: "auto" | "low" | "high" = "auto";
  };
}

/** References an image URL in the content of a message. */
@summary("Image URL")
model MessageDeltaContentImageUrlObject {
  /** The index of the content part in the message. */
  index: integer;

  /** Always `image_url`. */
  @extension("x-stainless-const", true)
  type: "image_url";

  image_url?: {
    url?: string;
    detail?: "auto" | "low" | "high" = "auto";
  };
}

/** The refusal content that is part of a message. */
@summary("Refusal")
model MessageDeltaContentRefusalObject {
  /** The index of the refusal part in the message. */
  index: integer;

  /** Always `refusal`. */
  @extension("x-stainless-const", true)
  type: "refusal";

  refusal?: string;
}

/** A citation within the message that points to a specific quote from a specific File associated with the assistant or the message. Generated when the assistant uses the "file_search" tool to search files. */
@summary("File citation")
model MessageDeltaContentTextAnnotationsFileCitationObject {
  /** The index of the annotation in the text content part. */
  index: integer;

  /** Always `file_citation`. */
  @extension("x-stainless-const", true)
  type: "file_citation";

  /** The text in the message content that needs to be replaced. */
  text?: string;

  file_citation?: {
    file_id?: string;
    quote?: string;
  };

  @minValue(0)
  start_index?: integer;

  @minValue(0)
  end_index?: integer;
}

/** A URL for the file that's generated when the assistant used the `code_interpreter` tool to generate a file. */
@summary("File path")
model MessageDeltaContentTextAnnotationsFilePathObject {
  /** The index of the annotation in the text content part. */
  index: integer;

  /** Always `file_path`. */
  @extension("x-stainless-const", true)
  type: "file_path";

  /** The text in the message content that needs to be replaced. */
  text?: string;

  file_path?: {
    file_id?: string;
  };

  @minValue(0)
  start_index?: integer;

  @minValue(0)
  end_index?: integer;
}

/** The text content that is part of a message. */
@summary("Text")
model MessageDeltaContentTextObject {
  /** The index of the content part in the message. */
  index: integer;

  /** Always `text`. */
  @extension("x-stainless-const", true)
  type: "text";

  text?: {
    value?: string;
    annotations?: TextAnnotationDelta[];
  };
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union TextAnnotationDelta {
  file_citation: MessageDeltaContentTextAnnotationsFileCitationObject,
  file_path: MessageDeltaContentTextAnnotationsFilePathObject,
}

/** Represents a message delta i.e. any changed fields on a message during streaming. */
@summary("Message delta object")
@extension(
  "x-oaiMeta",
  #{
    name: "The message delta object",
    beta: true,
    example: "{\n  \"id\": \"msg_123\",\n  \"object\": \"thread.message.delta\",\n  \"delta\": {\n    \"content\": [\n      {\n        \"index\": 0,\n        \"type\": \"text\",\n        \"text\": { \"value\": \"Hello\", \"annotations\": [] }\n      }\n    ]\n  }\n}\n",
  }
)
model MessageDeltaObject {
  /** The identifier of the message, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.message.delta`. */
  @extension("x-stainless-const", true)
  object: "thread.message.delta";

  /** The delta containing the fields that have changed on the Message. */
  delta: {
    role?: "user" | "assistant";
    content?: MessageContentDelta[];
  };
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union MessageContentDelta {
  image_file: MessageDeltaContentImageFileObject,
  text: MessageDeltaContentTextObject,
  refusal: MessageDeltaContentRefusalObject,
  image_url: MessageDeltaContentImageUrlObject,
}

model ModifyMessageRequest {
  metadata?: Metadata;
}
