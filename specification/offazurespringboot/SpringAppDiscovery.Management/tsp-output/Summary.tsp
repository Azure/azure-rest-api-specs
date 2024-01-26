import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
/**
 * The summary resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SpringbootsitesModel)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SummariesProperties)
model Summary extends ProxyResourceBase {
  /**
   * The name of summary
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z][A-Za-z0-9]*$")
  @path
  @key("summaryName")
  @segment("summaries")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SummariesProperties;
}

@armResourceOperations
interface Summaries {
  /**
   * Gets the Summaries resource.
   */
  get is ArmResourceRead<Summary>;

  /**
   * Lists the Summaries resource in springbootsites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Summaries_ListBySite")
  listBySite is ArmResourceListByParent<Summary>;
}
