import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
@doc("Friendly domain name mapping to the endpoint hostname that the customer provides for branding purposes, e.g. www.contoso.com.")
@parentResource(Profile)
model AFDDomain is ProxyResource<AFDDomainProperties> {
  @doc("Name of the domain under the profile which is unique globally.")
  @path
  @key("customDomainName")
  @segment("customDomains")
  name: string;
}

@armResourceOperations
interface AFDDomains {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.")
  @operationId("FrontDoorCustomDomains_Get")
  get is ArmResourceRead<AFDDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a new domain within the specified profile.")
  @operationId("FrontDoorCustomDomains_Create")
  create is ArmResourceCreateOrUpdateAsync<
    AFDDomain,
    BaseParameters<AFDDomain>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing domain within a profile.")
  @operationId("FrontDoorCustomDomains_Update")
  update is ArmCustomPatchAsync<
    AFDDomain,
    AFDDomainUpdateParameters,
    BaseParameters<AFDDomain>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing AzureFrontDoor domain with the specified domain name under the specified subscription, resource group and profile.")
  @operationId("FrontDoorCustomDomains_Delete")
  delete is ArmResourceDeleteAsync<
    AFDDomain,
    BaseParameters<AFDDomain>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists existing AzureFrontDoor domains.")
  @operationId("FrontDoorCustomDomains_ListByProfile")
  listByProfile is ArmResourceListByParent<AFDDomain>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the domain validation token.")
  @operationId("FrontDoorCustomDomains_RefreshValidationToken")
  refreshValidationToken is ArmResourceActionAsync<
    AFDDomain,
    void,
    void,
    BaseParameters<AFDDomain>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(AFDDomains.create::parameters.resource, "json", "customDomain");
@@extension(AFDDomains.create::parameters.resource,
  "x-ms-client-name",
  "customDomain"
);
@@doc(AFDDomains.create::parameters.resource, "Domain properties");
@@projectedName(AFDDomains.update::parameters.properties,
  "json",
  "customDomainUpdateProperties"
);
@@extension(AFDDomains.update::parameters.properties,
  "x-ms-client-name",
  "customDomainUpdateProperties"
);
@@doc(AFDDomains.update::parameters.properties, "Domain properties");
