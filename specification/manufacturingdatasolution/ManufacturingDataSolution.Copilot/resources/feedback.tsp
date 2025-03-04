import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/copilotmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using CopilotModels;
using CopilotCommon;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.FeedbackService;

alias ServiceTraits = SupportsRepeatableRequests &
    SupportsConditionalRequests &
    SupportsClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("feedbackRequest") 
model FeedbackRequest {
    @doc("The query id")
    operationId: string;

    @doc("conversation id")
    conversationId: string;

    @doc("The feedback")
    feedback: FeedbackCategory;

    @doc("QueryEndpoint")
    queryEndpoint: QueryEndpoint;
}

@doc("Feedback category")
enum FeedbackCategory {
  @doc
  Neutral: "Neutral",

  @doc
  ThumbUp: "ThumbUp",

  @doc("Negative feedback.")
  ThumbDown: "ThumbDown",  
}

@doc("Query endpoint")
enum QueryEndpoint {
    V3: "V3",
    Assistant: "Assistant"
}

interface Feedback { 
    @doc("Send feedback for a query")
    submitFeedback is apiOperations.ResourceCreateOrUpdate<FeedbackRequest>; 
}
