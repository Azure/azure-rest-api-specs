import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("A domain specific resource identifier.")
@parentResource(WebSite)
model SiteDomainOwnershipIdentifier is ProxyResource<IdentifierProperties> {
  @doc("Name of domain ownership identifier.")
  @path
  @key("domainOwnershipIdentifierName")
  @segment("domainOwnershipIdentifiers")
  name: string;
}

@armResourceOperations
interface SiteDomainOwnershipIdentifiers {
  @doc("Description for Get domain ownership identifier for web app.")
  getDomainOwnershipIdentifier is ArmResourceRead<SiteDomainOwnershipIdentifier>;
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  createOrUpdateDomainOwnershipIdentifier is ArmResourceCreateOrReplaceSync<SiteDomainOwnershipIdentifier>;
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  updateDomainOwnershipIdentifier is ArmResourcePatchSync<
    SiteDomainOwnershipIdentifier,
    IdentifierProperties
  >;
  @doc("Description for Deletes a domain ownership identifier for a web app.")
  deleteDomainOwnershipIdentifier is ArmResourceDeleteSync<SiteDomainOwnershipIdentifier>;
  @doc("Description for Lists ownership identifiers for domain associated with web app.")
  listDomainOwnershipIdentifiers is ArmResourceListByParent<SiteDomainOwnershipIdentifier>;
}
