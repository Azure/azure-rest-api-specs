import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services EncryptionScope
 */
@parentResource(Account)
model EncryptionScope
  is Azure.ResourceManager.ProxyResource<EncryptionScopeProperties> {
  ...ResourceNameParameter<
    Resource = EncryptionScope,
    KeyName = "encryptionScopeName",
    SegmentName = "encryptionScopes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface EncryptionScopes {
  /**
   * Gets the specified EncryptionScope associated with the Cognitive Services account.
   */
  get is ArmResourceRead<EncryptionScope>;

  /**
   * Update the state of specified encryptionScope associated with the Cognitive Services account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<EncryptionScope>;

  /**
   * Deletes the specified encryptionScope associated with the Cognitive Services account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EncryptionScope>;

  /**
   * Gets the content filters associated with the Azure OpenAI account.
   */
  list is ArmResourceListByParent<
    EncryptionScope,
    Response = EncryptionScopeListResult
  >;
}

@@doc(EncryptionScope.name,
  "The name of the encryptionScope associated with the Cognitive Services Account"
);
@@encodedName(EncryptionScope.etag, "application/json", "etag");
@@doc(EncryptionScope.properties,
  "Properties of Cognitive Services EncryptionScope."
);
@@doc(EncryptionScopes.createOrUpdate::parameters.resource,
  "The encryptionScope properties."
);
