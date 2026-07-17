import "../../common/models.tsp";

using Azure.Core.Experimental;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Experimental features applied to augment inherited OpenAI models"
namespace Azure.AI.Projects {
  @@changePropertyType(OpenAI.CreateChatCompletionRequest.`model`, string);
  @@changePropertyType(OpenAI.CreateChatCompletionResponse.`model`, string);
  @@doc(
    OpenAI.CreateChatCompletionRequest.`model`,
    "The model deployment to use for this chat completion."
  );
  @@doc(
    OpenAI.CreateChatCompletionResponse.`model`,
    "The model deployment used for the creation of this chat completion."
  );
  @@changePropertyType(OpenAI.Response.`model`, string);

  @@copyProperties(
    OpenAI.CreateChatCompletionRequest,
    {
      /**
       * User security context contains several parameters that describe the application itself, and the end user that interacts with the application. These fields assist your security operations teams to investigate and mitigate security incidents by providing a comprehensive approach to protecting your AI applications. [Learn more](https://aka.ms/TP4AI/Documentation/EndUserContext) about protecting AI applications using Microsoft Defender for Cloud.
       */
      user_security_context?: AzureUserSecurityContext,
    }
  );
}
