import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./CacheRule.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using Versioning;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a cache rule for a container registry.
 */
@parentResource(Registry)
model CacheRule is Azure.ResourceManager.ProxyResource<CacheRuleProperties> {
  ...ResourceNameParameter<
    Resource = CacheRule,
    KeyName = "cacheRuleName",
    SegmentName = "cacheRules",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * The identity of the cache rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Unable to use `added` decorator on spread property. Use `...ManagedServiceIdentityProperty` instead when feature has been GA'd."
  @added(Versions.vLatestPreview)
  identity?: IdentityProperties;
}

@armResourceOperations
interface CacheRules {
  /**
   * Gets the properties of the specified cache rule resource.
   */
  get is ArmResourceRead<CacheRule>;

  /**
   * Creates a cache rule for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<CacheRule>;

  /**
   * Updates a cache rule for a container registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    CacheRule,
    PatchModel = CacheRuleUpdateParameters,
    Response = ArmResponse<CacheRule> | ArmResourceCreatedResponse<
      CacheRule,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CacheRule> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a cache rule resource from a container registry.
   */
  delete is ArmResourceDeleteWithoutOkAsync<CacheRule>;

  /**
   * Lists all cache rule resources for the specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    CacheRule,
    Response = ArmResponse<CacheRulesListResult>
  >;
}

@@maxLength(CacheRule.name, 50);
@@minLength(CacheRule.name, 5);
@@doc(CacheRule.name, "The name of the cache rule.");
@@doc(CacheRule.properties, "The properties of the cache rule.");
@@doc(CacheRules.create::parameters.resource,
  "The parameters for creating a cache rule."
);
@@doc(CacheRules.update::parameters.properties,
  "The parameters for updating a cache rule."
);
