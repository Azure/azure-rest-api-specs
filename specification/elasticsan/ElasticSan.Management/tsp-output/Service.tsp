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
@doc("Object that represents a Service resource.")
@tenantResource
model Service is ProxyResource<ServiceProperties> {
  @doc("Name of the Azure service.")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface Services {
  @doc("Gets a specific Azure service for support ticket creation.")
  get is ArmResourceRead<Service>;

  @doc("Lists all the Azure services available for support ticket creation. For **Technical** issues, select the Service Id that maps to the Azure service/product as displayed in the **Services** drop-down list on the Azure portal's [New support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview) page. Always use the service and its corresponding problem classification(s) obtained programmatically for support ticket creation. This practice ensures that you always have the most recent set of service and problem classification Ids.")
  list is ArmResourceListByParent<Service>;
}
