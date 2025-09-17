import "@typespec/openapi";
import "../common";
import "./custom/items.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

@error
model ResponseErrorResponse {
  error: ResponseError;
}

union ReasoningItemSummaryPartType {
  string,
  summary_text: "summary_text",
}

@discriminator("type")
model ReasoningItemSummaryPart {
  type: ReasoningItemSummaryPartType;
}

model ReasoningItemSummaryTextPart extends ReasoningItemSummaryPart {
  type: ReasoningItemSummaryPartType.summary_text;
  text: string;
}

model WithObfuscation {
  /**
   * A field of random characters introduced by stream obfuscation. Stream obfuscation is a mechanism that mitigates certain side-channel attacks.
   */
  obfuscation: string;
}