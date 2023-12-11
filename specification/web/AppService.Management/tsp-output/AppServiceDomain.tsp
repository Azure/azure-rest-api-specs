import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Information about a domain.")
model AppServiceDomain is TrackedResource<DomainProperties> {
  @doc("Name of the domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface AppServiceDomains {
  @doc("Description for Get a domain.")
  get is ArmResourceRead<AppServiceDomain>;
  @doc("Description for Creates or updates a domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppServiceDomain>;
  @doc("Description for Creates or updates a domain.")
  update is ArmResourcePatchSync<AppServiceDomain, DomainProperties>;
  @doc("Description for Delete a domain.")
  delete is ArmResourceDeleteSync<
    AppServiceDomain,
    {
      ...BaseParameters<AppServiceDomain>;

      @doc("Specify <code>true</code> to delete the domain immediately. The default is <code>false</code> which deletes the domain after 24 hours.")
      @query("forceHardDeleteDomain")
      forceHardDeleteDomain?: boolean;
    }
  >;
  @doc("Description for Get all domains in a resource group.")
  listByResourceGroup is ArmResourceListByParent<AppServiceDomain>;
  @doc("Description for Get all domains in a subscription.")
  list is ArmListBySubscription<AppServiceDomain>;
  @doc("Description for Renew a domain.")
  renew is ArmResourceActionSync<AppServiceDomain, {}, {}>;
}
