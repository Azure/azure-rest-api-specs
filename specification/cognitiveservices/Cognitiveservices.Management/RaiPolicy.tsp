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
 * Cognitive Services RaiPolicy.
 */
@parentResource(Account)
model RaiPolicy is Azure.ResourceManager.ProxyResource<RaiPolicyProperties> {
  ...ResourceNameParameter<
    Resource = RaiPolicy,
    KeyName = "raiPolicyName",
    SegmentName = "raiPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiPolicies {
  /**
   * Gets the specified Content Filters associated with the Azure OpenAI account.
   */
  get is ArmResourceRead<RaiPolicy>;

  /**
   * Update the state of specified Content Filters associated with the Azure OpenAI account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<RaiPolicy>;

  /**
   * Deletes the specified Content Filters associated with the Azure OpenAI account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RaiPolicy>;

  /**
   * Gets the content filters associated with the Azure OpenAI account.
   */
  list is ArmResourceListByParent<RaiPolicy>;
}

@@doc(RaiPolicy.name,
  "The name of the RaiPolicy associated with the Cognitive Services Account"
);
@@encodedName(RaiPolicy.eTag, "application/json", "etag");
@@doc(RaiPolicy.properties, "Properties of Cognitive Services RaiPolicy.");
@@doc(RaiPolicies.createOrUpdate::parameters.resource,
  "Properties describing the Content Filters."
);
