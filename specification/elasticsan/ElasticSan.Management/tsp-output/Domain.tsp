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

namespace Microsoft.CertificateRegistration;
@doc("Information about a domain.")
model Domain is TrackedResource<DomainProperties> {
  @doc("Name of the domain.")
  @path
  @key("domainName")
  @segment("domains")
  name: string;
}

@armResourceOperations
interface Domains {
  @doc("Description for Get a domain.")
  get is ArmResourceRead<Domain>;

  @doc("Description for Creates or updates a domain.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Domain>;

  @doc("Description for Creates or updates a domain.")
  update is ArmCustomPatchSync<Domain, DomainPatchResource>;

  @doc("Description for Delete a domain.")
  delete is ArmResourceDeleteSync<
    Domain,
    {
      ...BaseParameters<Domain>;

      @doc("Specify <code>true</code> to delete the domain immediately. The default is <code>false</code> which deletes the domain after 24 hours.")
      @query("forceHardDeleteDomain")
      forceHardDeleteDomain?: boolean;
    }
  >;

  @doc("Description for Get all domains in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Domain>;

  @doc("Description for Get all domains in a subscription.")
  list is ArmListBySubscription<Domain>;

  @doc("Description for Renew a domain.")
  renew is ArmResourceActionSync<Domain, void, void>;
}

@@projectedName(Domains.createOrUpdate::parameters.resource, "json", "domain");
@@extension(Domains.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "domain"
);
@@doc(Domains.createOrUpdate::parameters.resource,
  "Domain registration information."
);
@@projectedName(Domains.update::parameters.properties, "json", "domain");
@@extension(Domains.update::parameters.properties,
  "x-ms-client-name",
  "domain"
);
@@doc(Domains.update::parameters.properties,
  "Domain registration information."
);
