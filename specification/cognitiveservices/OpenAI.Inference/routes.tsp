import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
//import "@azure-tools/typespec-client-generator-core";

import "./models/completions.create.tsp";
import "./models/chat.completions.tsp";
import "./models/embeddings.create.tsp";
import "./models/images.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
//using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@TypeSpec.Rest.actionSeparator("/")
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
@actionSeparator("/")
@action("chat/completions") //@convenientAPI(true)
op getChatCompletions is ResourceAction<
    Deployment,
    ChatCompletionsOptions,
    ChatCompletions
>;

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "because"
@doc("Returns the status of the images operation")
@route("/operations/images/{operationId}")
op generateImage is RpcOperation<{@doc(".") @path operationId: string}, ImageOperationResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@route("/images/generations:submit")
@pollingOperation(generateImage, {operationId: ResponseProperty<"id">})
op startGenerateImage is OaiLongRunningRpcOperation<
    ImageRequest,
    ImageOperationResponse,
    ImageOperationStatus>;

