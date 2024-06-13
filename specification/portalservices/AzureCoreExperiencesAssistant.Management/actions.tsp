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
using Azure.Core;

namespace Microsoft.PortalServices;

@armResourceOperations
interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface AzureCoreExperiencesAssistant {
  @doc("Send a chat to the assistant")
  @armResourceAction(AssistantRequest)
  @route("{resourceId}/providers/Microsoft.PortalServices/")
  @post
  invokeAssistant(
    ...ApiVersionParameter,

    @doc("The ARM Id of the resource we are invoking the reqeust on")
    @path
    resourceId: armResourceIdentifier,

    @doc("The request body.")
    @body
    assistantRequest: AssistantRequest,
  ): AssistantResponse | ErrorResponse;
}
