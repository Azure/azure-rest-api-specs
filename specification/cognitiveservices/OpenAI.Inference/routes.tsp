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

@doc("""
Gets chat completions for the provided chat messages.
This is an Azure-specific version of chat completions that supports integration with configured data sources and
other augmentations to the base chat completions capabilities.
""")
// Note: client libraries should abstract the existence of this as a distinct REST route and instead perform dynamic
//        selection of the appropriate request URL structure based on the presence or non-presence of matching
//        chat extensions configuration in the request options model. Future service API versions may merge this
//        capability into the standard /chat/completions route.
@added(ServiceApiVersions.v2023_08_01_Preview)
@actionSeparator("/")
@action("extensions/chat/completions")
op getChatCompletionsWithAzureExtensions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;

// Note: pending resolution of  cross-language code emission behavior for long-running operations, image generation
//        reuses its final operation response model as its status polling model.
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "MUST fix in next update"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Allowed because this is a non-standard status polling operation."
@doc("Returns the status of the images operation")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/operations/images/{operationId}")
op getAzureBatchImageGenerationOperationStatus is RpcOperation<
  {
    @doc(".") @path operationId: string;
  },
  BatchImageGenerationOperationResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Starts the generation of a batch of images from a text caption")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/images/generations:submit")
@pollingOperation(
  getAzureBatchImageGenerationOperationStatus,
  {
    operationId: ResponseProperty<"id">,
  }
)
op beginAzureBatchImageGeneration is OaiLongRunningRpcOperation<
  ImageGenerationOptions,
  BatchImageGenerationOperationResponse,
  BatchImageGenerationOperationResponse
>;
