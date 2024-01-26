import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PolicyInsights;
/**
 * Policy metadata resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PolicyMetadataProperties)
model PolicyMetadata extends ProxyResourceBase {
  /**
   * The name of the policy metadata resource.
   */
  @path
  @key("resourceName")
  @segment("policyMetadata")
  @visibility("read")
  name: string;

  /**
   * Properties of the policy metadata.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PolicyMetadataProperties;
}

@armResourceOperations
@projectedName("client", "PolicyMetadata")
interface PolicyMetadataOperationGroup {
  /**
   * Get policy metadata resource.
   */
  getResource is ArmResourceRead<PolicyMetadata>;

  /**
   * Get a list of the policy metadata resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PolicyMetadata_List")
  list is ArmResourceListByParent<
    PolicyMetadata,
    {
      ...BaseParameters<PolicyMetadata>;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;
    }
  >;
}
