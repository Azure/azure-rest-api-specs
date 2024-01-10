import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Domain ownership Identifier.")
@parentResource(Domain)
model DomainOwnershipIdentifier
  is ProxyResource<DomainOwnershipIdentifierProperties> {
  @doc("Name of identifier.")
  @key("name")
  @segment("domainOwnershipIdentifiers")
  name: string;
}

@armResourceOperations
@projectedName("client", "Domains")
interface DomainOwnershipIdentifiers_Domains {
  @doc("Description for Get ownership identifier for domain")
  getOwnershipIdentifier is ArmResourceRead<DomainOwnershipIdentifier>;

  @doc("Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<DomainOwnershipIdentifier>;

  @doc("Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    DomainOwnershipIdentifier
  >;

  @doc("Description for Delete ownership identifier for domain")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<DomainOwnershipIdentifier>;

  @doc("Description for Lists domain ownership identifiers.")
  listOwnershipIdentifiers is ArmResourceListByParent<DomainOwnershipIdentifier>;
}
