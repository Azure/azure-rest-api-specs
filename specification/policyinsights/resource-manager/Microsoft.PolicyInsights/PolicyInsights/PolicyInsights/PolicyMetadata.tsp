import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PolicyInsightsApi;
/**
 * Policy metadata resource definition.
 */
@tenantResource
model PolicyMetadata
  is Azure.ResourceManager.ProxyResource<PolicyMetadataProperties> {
  ...ResourceNameParameter<
    Resource = PolicyMetadata,
    KeyName = "resourceName",
    SegmentName = "policyMetadata",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PolicyMetadataOperationGroup {
  /**
   * Get policy metadata resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyMetadata_GetResource")
  getResource is ArmResourceRead<
    PolicyMetadata,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;
}

@@doc(PolicyMetadata.name, "The name of the policy metadata resource.");
@@doc(PolicyMetadata.properties, "Properties of the policy metadata.");
