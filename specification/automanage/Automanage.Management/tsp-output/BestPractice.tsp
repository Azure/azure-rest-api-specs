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

namespace Microsoft.Automanage;
/**
 * Definition of the Automanage best practice.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(
  ConfigurationProfileProperties
)
@includeInapplicableMetadataInPayload(false)
model BestPractice extends ProxyResourceBase {
  /**
   * The Automanage best practice name.
   */
  @path
  @key("bestPracticeName")
  @segment("bestPractices")
  name: string;

  /**
   * Properties of the best practice.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationProfileProperties;
}

@armResourceOperations
interface BestPractices {
  /**
   * Get information about a Automanage best practice
   */
  get is ArmResourceRead<BestPractice>;

  /**
   * Retrieve a list of Automanage best practices
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BestPractices_ListByTenant")
  listByTenant is ArmResourceListByParent<BestPractice>;
}
