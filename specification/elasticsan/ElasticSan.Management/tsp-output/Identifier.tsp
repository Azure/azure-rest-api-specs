import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("A domain specific resource identifier.")
@parentResource(Site)
model Identifier is ProxyResource<IdentifierProperties> {
  @doc("Name of domain ownership identifier.")
  @path
  @key("domainOwnershipIdentifierName")
  @segment("domainOwnershipIdentifiers")
  name: string;
}

@armResourceOperations
interface Identifiers {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get domain ownership identifier for web app.")
  @operationId("WebApps_GetDomainOwnershipIdentifier")
  getDomainOwnershipIdentifier is ArmResourceRead<Identifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @operationId("WebApps_CreateOrUpdateDomainOwnershipIdentifier")
  createOrUpdateDomainOwnershipIdentifier is ArmResourceCreateOrReplaceSync<Identifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a domain ownership identifier for web app, or updates an existing ownership identifier.")
  @operationId("WebApps_UpdateDomainOwnershipIdentifier")
  updateDomainOwnershipIdentifier is ArmCustomPatchSync<Identifier, Identifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a domain ownership identifier for a web app.")
  @operationId("WebApps_DeleteDomainOwnershipIdentifier")
  deleteDomainOwnershipIdentifier is ArmResourceDeleteSync<Identifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Lists ownership identifiers for domain associated with web app.")
  @operationId("WebApps_ListDomainOwnershipIdentifiers")
  listDomainOwnershipIdentifiers is ArmResourceListByParent<Identifier>;
}

@@projectedName(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(Identifiers.createOrUpdateDomainOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@projectedName(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(Identifiers.updateDomainOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
