import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Cdn;
/**
 * Defines a web agent resource for Azure CDN.
 */
@added(Versions.v2025_09_01_preview)
model WebAgent is Azure.ResourceManager.TrackedResource<WebAgentProperties> {
  ...ResourceNameParameter<
    Resource = WebAgent,
    KeyName = "webAgentName",
    SegmentName = "webAgents",
    NamePattern = ""
  >;
}

/**
 * Defines a WebAgent response body for long-running operations.
 */
@added(Versions.v2025_09_01_preview)
model WebAgentAcceptedBody {
  /**
   * Defines a WebAgent response body
   */
  @bodyRoot
  @added(Versions.v2025_09_01_preview)
  _: WebAgent;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface WebAgents {
  /**
   * Gets a web agent with the specified name within a resource group.
   */
  get is ArmResourceRead<WebAgent>;

  /**
   * Creates or updates a web agent with the specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WebAgent,
    Response = ArmResourceUpdatedResponse<WebAgent> | ArmResourceCreatedResponse<WebAgent> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WebAgent>> &
      WebAgentAcceptedBody)
  >;

  /**
   * Updates an existing web agent with the specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    WebAgent,
    PatchModel = WebAgentUpdateParameters,
    Response = ArmResponse<WebAgent> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> &
      WebAgentAcceptedBody)
  >;

  /**
   * Deletes a web agent with the specified name within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    WebAgent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all web agents within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    WebAgent,
    Response = ArmResponse<WebAgentList>
  >;

  /**
   * Lists all web agents within a subscription.
   */
  listBySubscription is ArmListBySubscription<
    WebAgent,
    Response = ArmResponse<WebAgentList>
  >;
}

@@maxLength(WebAgent.name, 64);
@@minLength(WebAgent.name, 1);
@@doc(WebAgent.name, "The name of the web agent.");
@@doc(WebAgent.properties, "Properties of the web agent.");
@@doc(WebAgents.createOrUpdate::parameters.resource,
  "Web agent to be created or updated."
);
@@doc(WebAgents.update::parameters.properties,
  "Web agent parameters to be updated."
);
