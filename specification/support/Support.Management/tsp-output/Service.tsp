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

namespace Microsoft.Support;
/**
 * Object that represents a Service resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ServiceProperties)
model Service extends ProxyResourceBase {
  /**
   * Name of the Azure service.
   */
  @path
  @key("serviceName")
  @segment("services")
  @visibility("read")
  name: string;

  /**
   * Properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ServiceProperties;
}

@armResourceOperations
interface Services {
  /**
   * Gets a specific Azure service for support ticket creation.
   */
  get is ArmResourceRead<Service>;

  /**
   * Lists all the Azure services available for support ticket creation. For **Technical** issues, select the Service Id that maps to the Azure service/product as displayed in the **Services** drop-down list on the Azure portal's [New support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview) page. Always use the service and its corresponding problem classification(s) obtained programmatically for support ticket creation. This practice ensures that you always have the most recent set of service and problem classification Ids.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_List")
  list is ArmResourceListByParent<Service>;
}
