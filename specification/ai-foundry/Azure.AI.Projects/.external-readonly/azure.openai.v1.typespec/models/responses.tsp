import "../../openai.external.typespec/responses/models.tsp";

using Azure.AI.Decorators;

namespace AzureOpenAI;

@@doc(OpenAI.CreateResponse.service_tier, "Note: service_tier is not applicable to Azure OpenAI.");
@@doc(OpenAI.Response.service_tier, "Note: service_tier is not applicable to Azure OpenAI.");

@@changePropertyType(OpenAI.CreateResponse.`model`, string);
@@changePropertyType(OpenAI.Response.`model`, string);

@@doc(OpenAI.CreateResponse.`model`, "The model deployment to use for the creation of this response.");
@@doc(OpenAI.Response.`model`, "The model deployment to use for the creation of this response.");

// Note: this substitution removes OpenAI-local doc links.
@@doc(OpenAI.CreateResponse.tools,
  """
    An array of tools the model may call while generating a response. You 
    can specify which tool to use by setting the `tool_choice` parameter.
    
    The two categories of tools you can provide the model are:
    
    - **Built-in tools**: Tools that are provided by OpenAI that extend the
      model's capabilities, like file search.
    - **Function calls (custom tools)**: Functions that are defined by you,
      enabling the model to call your own code.
    """
);

@@doc(OpenAI.ResponseWebSearchCallCompletedEvent,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.ResponseWebSearchCallInProgressEvent,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.ResponseWebSearchCallSearchingEvent,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.WebSearchPreviewTool,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.ToolChoiceObjectWebSearch,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.WebSearchToolCallItemParam,
  "Note: web_search is not yet available via Azure OpenAI."
);
@@doc(OpenAI.WebSearchToolCallItemResource,
  "Note: web_search is not yet available via Azure OpenAI."
);
