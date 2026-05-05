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
 * Cognitive Services RAI Tool Label resource.
 */
@parentResource(Account)
model RaiToolLabel
  is Azure.ResourceManager.ProxyResource<RaiToolLabelProperties> {
  ...ResourceNameParameter<
    Resource = RaiToolLabel,
    KeyName = "raiToolConnectionName",
    SegmentName = "raiToolLabels",
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiToolLabels {
  /**
   * Gets the specified RAI Tool Label associated with the Azure OpenAI account.
   */
  get is ArmResourceRead<RaiToolLabel>;

  /**
   * Creates the RAI Tool Label associated with the Azure OpenAI account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<RaiToolLabel>;

  /**
   * Deletes the specified RAI Tool Label associated with the Azure OpenAI account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RaiToolLabel>;

  /**
   * Lists all RAI Tool Labels associated with the Azure OpenAI account.
   */
  list is ArmResourceListByParent<
    RaiToolLabel,
    Response = ArmResponse<RaiToolLabelResult>
  >;
}

@@doc(RaiToolLabel.name, "The name of the Rai Tool Label");
@@encodedName(RaiToolLabel.etag, "application/json", "etag");
@@doc(RaiToolLabel.properties, "Properties of the RAI Tool Label.");
@@doc(RaiToolLabels.createOrUpdate::parameters.resource,
  "Properties describing the RAI Tool Label."
);
