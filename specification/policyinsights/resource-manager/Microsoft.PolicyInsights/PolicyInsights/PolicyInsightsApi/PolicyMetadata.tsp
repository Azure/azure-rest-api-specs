import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
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

alias PolicyMetadataOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the policy metadata resource. */
    @path(#{ allowReserved: true })
    @segment("policyMetadata")
    @key
    resourceName: string;
  },
  ErrorType = ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PolicyMetadataOperationGroup {
  /**
   * Get policy metadata resource.
   */
  getResource is PolicyMetadataOps.Read<
    PolicyMetadata,
    Response = PolicyMetadata
  >;
}

@@doc(PolicyMetadata.name, "The name of the policy metadata resource.");
@@doc(PolicyMetadata.properties, "Properties of the policy metadata.");
