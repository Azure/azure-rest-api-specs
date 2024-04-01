import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/chat_completions.tsp";
import "./models/embeddings.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace ModelClient;

@doc("Defines the service behaviour when unknown parameters are passed as extra properties in the request payload.")
enum UnknownParameters {
  @doc("The service should error when it sees unknown parameters in the request payload. This is the default behaviour if the service.")
  error: "error",

  @doc("The service should ignore unknown parameters in the request payload. They will not be passed to the back-end AI model.")
  ignore: "ignore",

  @doc("The service should pass unknown parameters to the back-end AI model.")
  allow: "allow",
}

@doc("Additional request headers")
model AdditionalRequestHeaders {
  @doc("Controls what happens if unknown parameters are passed as extra properties in the request payload.")
  @header("unknown-parameters")
  unknownParameters?: UnknownParameters;

  @doc("""
  Name of the deployment to which you would like to route the request. Relevant only to Model-as-a-Platform (MaaP) deployments.
  Typically used when you want to target a test enviroment instead of production enviroment.
  """)
  @header("azureml-model-deployment")
  modelDeployment?: string;
}

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@actionSeparator("/")
@route("v1/chat/completions")
op getChatCompletions is Azure.Core.RpcOperation<
  {
    @doc("The JSON payload containing chat completion options.")
    @body
    chatCompletionsOptions: ChatCompletionsOptions;

    ...AdditionalRequestHeaders;
  },
  ChatCompletions
>;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@route("v1/embeddings")
op getEmbeddings is Azure.Core.RpcOperation<
  {
    @doc("The JSON payload containing embedding options.")
    @body
    embeddingsOptions: EmbeddingsOptions;

    ...AdditionalRequestHeaders;
  },
  EmbeddingsResult
>;
