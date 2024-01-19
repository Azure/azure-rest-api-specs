import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
@doc("Custom domain resource payload.")
@parentResource(AppResource)
model CustomDomainResource is ProxyResource<CustomDomainProperties> {
  @doc("The name of the custom domain resource.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface CustomDomainResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the custom domain of one lifecycle application.")
  @operationId("CustomDomains_Get")
  get is ArmResourceRead<CustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update custom domain of one lifecycle application.")
  @operationId("CustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update custom domain of one lifecycle application.")
  @operationId("CustomDomains_Update")
  update is ArmCustomPatchAsync<CustomDomainResource, CustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the custom domain of one lifecycle application.")
  @operationId("CustomDomains_Delete")
  delete is ArmResourceDeleteAsync<CustomDomainResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the custom domains of one lifecycle application.")
  @operationId("CustomDomains_List")
  list is ArmResourceListByParent<CustomDomainResource>;
}

@@projectedName(CustomDomainResources.createOrUpdate::parameters.resource,
  "json",
  "domainResource"
);
@@extension(CustomDomainResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "domainResource"
);
@@doc(CustomDomainResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(CustomDomainResources.update::parameters.properties,
  "json",
  "domainResource"
);
@@extension(CustomDomainResources.update::parameters.properties,
  "x-ms-client-name",
  "domainResource"
);
@@doc(CustomDomainResources.update::parameters.properties,
  "Parameters for the create or update operation"
);
