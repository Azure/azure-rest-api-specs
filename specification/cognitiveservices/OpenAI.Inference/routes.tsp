import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/completions.create.tsp";
import "./models/chat.completions.tsp";
import "./models/embeddings.create.tsp";
import "./models/images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@action("embeddings") //@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<
  Deployment,
  EmbeddingsOptions,
  Embeddings
>;

@doc("""
Gets completions for the provided input prompts.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@actionSeparator("/")
@action("completions") //@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<
  Deployment,
  CompletionsOptions,
  Completions
>;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@added(ServiceApiVersions.v2023_05_15)
@actionSeparator("/")
@action("chat/completions") //@convenientAPI(true)
op getChatCompletions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Allowed because this is a non-standard status polling operation."
@doc("Returns the status of the images operation")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/operations/images/{operationId}")
op getImageOperationStatus is RpcOperation<
  {
    @doc(".") @path operationId: string;
  },
  ImageOperationResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Starts the generation of a batch of images from a text caption")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/images/generations:submit")
@pollingOperation(
  getImageOperationStatus,
  {
    operationId: ResponseProperty<"id">,
  }
)
op startGenerateImage is OaiLongRunningRpcOperation<
  ImageGenerationOptions,
  ImageOperationResponse,
  ImageOperationStatus
>;
