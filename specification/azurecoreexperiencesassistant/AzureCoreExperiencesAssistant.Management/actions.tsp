import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureCoreExperiencesAssistant;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

@armResourceOperations
interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface AzureCoreExperiencesAssistant {
  @doc("Send a chat to the assistant")
  @armResourceAction(AssistantRequest)
  @route("/providers/Microsoft.AzureCoreExperiencesAssistant/")
  @post
  invokeAssistant(
    ...ApiVersionParameter,

    @doc("The request body.")
    @body
    assistantRequest: AssistantRequest,
  ): AssistantResponse | ErrorResponse;
}
