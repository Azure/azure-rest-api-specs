import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./WebAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Cdn;
/**
 * Defines a knowledge source resource for a web agent.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(WebAgent)
model KnowledgeSource
  is Azure.ResourceManager.ProxyResource<KnowledgeSourceProperties> {
  ...ResourceNameParameter<
    Resource = KnowledgeSource,
    KeyName = "knowledgeSourceName",
    SegmentName = "knowledgeSources",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-]{0,62}[a-zA-Z0-9]$"
  >;
}

/**
 * Defines a KnowledgeSource response body for long-running operation
 */
@added(Versions.v2025_09_01_preview)
model KnowledgeSourceAcceptedBody {
  /**
   * Defines a KnowledgeSource response body
   */
  @bodyRoot
  @added(Versions.v2025_09_01_preview)
  _: KnowledgeSource;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface KnowledgeSources {
  /**
   * Gets a knowledge source with the specified name within a web agent.
   */
  get is ArmResourceRead<KnowledgeSource>;

  /**
   * Creates or updates a knowledge source with the specified name within a web agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    KnowledgeSource,
    Response = ArmResourceUpdatedResponse<KnowledgeSource> | ArmResourceCreatedResponse<KnowledgeSource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = KnowledgeSource>> &
      KnowledgeSourceAcceptedBody)
  >;

  /**
   * Updates an existing knowledge source with the specified name within a web agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    KnowledgeSource,
    PatchModel = KnowledgeSourceUpdateParameters,
    Response = ArmResponse<KnowledgeSource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> &
      KnowledgeSourceAcceptedBody)
  >;

  /**
   * Deletes a knowledge source with the specified name within a web agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    KnowledgeSource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all knowledge sources within a web agent.
   */
  listByWebAgent is ArmResourceListByParent<
    KnowledgeSource,
    Response = ArmResponse<KnowledgeSourceList>
  >;

  /**
   * Remove the cache of a knowledge source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge is ArmResourceActionAsync<
    KnowledgeSource,
    void,
    OkResponse,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@maxLength(KnowledgeSource.name, 64);
@@minLength(KnowledgeSource.name, 1);
@@doc(KnowledgeSource.name, "The name of the knowledge source.");
@@doc(KnowledgeSource.properties, "Properties of the knowledge source.");
@@doc(KnowledgeSources.createOrUpdate::parameters.resource,
  "Knowledge source to be created or updated."
);
@@doc(KnowledgeSources.update::parameters.properties,
  "Knowledge source parameters to be updated."
);
