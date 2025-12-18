import "@typespec/openapi";
import "../common";
import "./custom/items.tsp";
import "./models.tsp";

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

#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
model CreateResponse {
  ...CreateResponse_Pre_Update;
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  conversation?: string | {
    id: string;
  };
}

model Response {
  ...Response_Pre_Update;
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  conversation: {
    id: string;
  } | null;
}

model EasyInputMessage {
  role: string;
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  content: string | InputContent[];
}
