import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("A domain specific resource identifier.")
@parentResource(Site)
model Identifier is ProxyResource<IdentifierProperties> {
  @doc("Name of domain ownership identifier.")
  @key("domainOwnershipIdentifierName")
  @segment("domainOwnershipIdentifiers")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get domain ownership identifier for web app.")
  getDomainOwnershipIdentifier is ArmResourceRead<Identifier>;
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  createOrUpdateDomainOwnershipIdentifier is ArmResourceCreateOrReplaceSync<Identifier>;
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  updateDomainOwnershipIdentifier is ArmCustomPatchSync<Identifier, Identifier>;
  @doc("Description for Deletes a domain ownership identifier for a web app.")
  deleteDomainOwnershipIdentifier is ArmResourceDeleteSync<Identifier>;
  @doc("Description for Lists ownership identifiers for domain associated with web app.")
  listDomainOwnershipIdentifiers is ArmResourceListByParent<Identifier>;
}
