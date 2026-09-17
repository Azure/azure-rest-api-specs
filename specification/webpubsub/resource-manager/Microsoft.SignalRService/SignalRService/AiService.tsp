import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.SignalRService;

/**
 * An AI service.
 */
@parentResource(WebPubSubResource)
model AiService is Azure.ResourceManager.ProxyResource<
  AiServiceProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AiService,
    KeyName = "name",
    SegmentName = "aiServices",
    NamePattern = ""
  >;
}

/**
 * AI services list.
 */
model AiServiceList is Azure.Core.Page<AiService>;

/**
 * Properties of an AI service.
 */
model AiServiceProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Reference to the Foundry project.
   */
  foundryProject: ResourceReference;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface AiServices {
  /**
   * Get an AI service.
   */
  get is ArmResourceRead<AiService>;

  /**
   * Create or update an AI service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AiService>;

  /**
   * Delete an AI service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The service returns 202 or 204 for delete."
  delete is ArmResourceDeleteWithoutOkAsync<
    AiService,
    Response =
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
      | ErrorResponse
  >;

  /**
   * List all AI services.
   */
  list is ArmResourceListByParent<
    AiService,
    Response = ArmResponse<AiServiceList>
  >;
}

@@doc(AiService.name, "AI service name.");
@@doc(AiService.properties, "Properties of an AI service.");
@@doc(
  AiServices.createOrUpdate::parameters.resource,
  "The AI service resource and its properties."
);
