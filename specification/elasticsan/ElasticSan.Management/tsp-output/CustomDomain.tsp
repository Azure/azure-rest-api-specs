import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SignalRResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
@doc("A custom domain")
@parentResource(SignalRResource)
model CustomDomain is ProxyResource<CustomDomainProperties> {
  @doc("Custom domain name.")
  @path
  @key("name")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface CustomDomains {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a custom domain.")
  @operationId("SignalRCustomDomains_Get")
  get is ArmResourceRead<CustomDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a custom domain.")
  @operationId("SignalRCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a custom domain.")
  @operationId("SignalRCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<CustomDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all custom domains.")
  @operationId("SignalRCustomDomains_List")
  list is ArmResourceListByParent<CustomDomain>;
}

@@projectedName(CustomDomains.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(CustomDomains.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CustomDomains.createOrUpdate::parameters.resource, "");
