import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

/** Task definition for custom conversational summarization. */
@added(Versions.v2024_11_15_preview)
model AnalyzeCustomConversationSummarizationTask
  extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.CustomConversationalSummarizationTask;

  /** parameters */
  parameters?: CustomConversationSummarizationTaskParameters;
}

/** Task definition for conversational summarization. */
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationTask extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.ConversationalSummarizationTask;

  /** parameters */
  parameters?: ConversationSummarizationTaskParameters;
}

/** Supported parameters for a conversational summarization task. */
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParametersBase
  is AbstractiveSummarizationTaskParametersBase {
  /** Array of Summary Aspects */
  summaryAspects: Array<SummaryAspect>;

  /** a text field to allow customers to use natural language to describe their needs for summarization. */
  @added(Versions.v2024_11_15_preview)
  instruction?: string;
}

/** Supported parameters for pre-build conversational summarization task. */
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParameters is PreBuiltTaskParameters {
  ...ConversationSummarizationTaskParametersBase;
}

/** Supported parameters for a custom conversation summarization task. */
@added(Versions.v2024_11_15_preview)
model CustomConversationSummarizationTaskParameters is CustomTaskParameters {
  /** It controls the approximate number of sentences in the output summaries. */
  sentenceCount?: int32;

  /** String index type */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** Controls the approximate length of the output summaries. Recommended to use summaryLength over sentenceCount */
  summaryLength?: SummaryLengthBucket;

  /** Array of Summary Aspects */
  summaryAspects: Array<SummaryAspect>;
}

/** Supported parameters for a conversational summarization task. */
@added(Versions.v2023_04_01)
union SummaryAspect {
  string,

  /** Summary of issues in transcripts of web chats and service calls between customer-service agents and customers. */
  issue: "issue",

  /** Summary of resolutions in transcripts of web chats and service calls between customer-service agents and customers. */
  resolution: "resolution",

  /** Chapter title of any conversation. It's usually one phrase or several phrases naturally combined. Long conversations tend to have more chapters. You can find the chapter boundary from the summary context. */
  chapterTitle: "chapterTitle",

  /** Generic narrative summary of any conversation. It generally converts the conversational language into formal written language, compresses the text length, and keeps the salient information. */
  narrative: "narrative",

  /** A concise one-paragraph summary to provide a quick overview. */
  @added(Versions.v2024_05_01)
  recap: "recap",

  /** Action items and tasks that arose during a meeting. */
  @added(Versions.v2024_11_15_preview)
  followUpTasks: "follow-up tasks",
}

/** Result for the summarization task on the conversation. */
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.ConversationalSummarizationResults;

  /** results */
  results: SummaryResult;
}

/** Result for the custom summarization task on the conversation. */
@added(Versions.v2024_11_15_preview)
model AnalyzeCustomConversationSummarizationResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.CustomConversationalSummarizationResults;

  /** Custom Summary Result */
  results: CustomSummaryResult;
}

/** Summary Results Base */
@added(Versions.v2023_04_01)
model SummaryResultBase {
  /** array of conversations */
  conversations: Array<ConversationsSummaryResult>;
}

/** Summary Results */
@added(Versions.v2023_04_01)
model SummaryResult {
  ...SummaryResultBase;
  ...PreBuiltResult;
}

/** Custom Summary Results */
@added(Versions.v2024_11_15_preview)
model CustomSummaryResult {
  ...SummaryResultBase;
  ...CustomResult;
}

/** Conversations Summary Result */
@added(Versions.v2023_04_01)
model ConversationsSummaryResult {
  ...ConversationResultBase;

  /** array of summaries */
  summaries: Array<SummaryResultItem>;
}

/** Summary Result Item */
@added(Versions.v2023_04_01)
model SummaryResultItem {
  /** aspect */
  aspect: string;

  /** text */
  text: string;

  /** Context list of the summary. */
  contexts?: Array<ItemizedSummaryContext>;
}

/** Context of the summary with a conversation item ID. */
@added(Versions.v2023_04_01)
model ItemizedSummaryContext is SummaryContext {
  /** Reference to the ID of ConversationItem. */
  conversationItemId: string;
}

/** Enum that defines the length of the output summaries. */
@added(Versions.v2024_05_01)
union SummaryLengthBucket {
  string,

  /** Instructs model to generate shorter length summaries. */
  short: "short",

  /** Instructs model to generate medium length summaries. */
  medium: "medium",

  /** Instructs model to generate longer length summaries. */
  long: "long",
}

/** Supported parameters for an Abstractive Summarization task. */
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParametersBase {
  /** It controls the approximate number of sentences in the output summaries. */
  sentenceCount?: int32;

  /** String index type */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries. */
  @added(Versions.v2024_05_01)
  summaryLength?: SummaryLengthBucket;
}

/** The context of the summary. */
@added(Versions.v2023_04_01)
model SummaryContext {
  /** Start position for the context. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** The length of the context. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;
}
