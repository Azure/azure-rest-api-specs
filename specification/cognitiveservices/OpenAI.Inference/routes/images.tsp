import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/images/images.tsp";
import "../models/images/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

@doc("Creates an image given a prompt.")
@added(ServiceApiVersions.v2023_12_01_Preview)
@actionSeparator("/")
@action("images/generations")
op getImageGenerations is Azure.Core.ResourceAction<
  Deployment,
  ImageGenerationOptions,
  ImageGenerations
>;

// Note: pending resolution of cross-language code emission behavior for long-running operations, image generation
// reuses its final operation response model as its status polling model.

// Note2: see the comments in the models/images/images.tsp file for more information on why the op is commented out

#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "MUST fix in next update"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Allowed because this is a non-standard status polling operation."
@doc("Returns the status of the images operation")
@added(ServiceApiVersions.v2023_06_01_Preview)
@removed(ServiceApiVersions.v2023_12_01_Preview)
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
@removed(ServiceApiVersions.v2023_12_01_Preview)
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
