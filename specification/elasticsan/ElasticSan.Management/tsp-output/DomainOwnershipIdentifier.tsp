import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Domain ownership Identifier.")
@parentResource(Domain)
model DomainOwnershipIdentifier
  is ProxyResource<DomainOwnershipIdentifierProperties> {
  @doc("Name of identifier.")
  @path
  @key("name")
  @segment("domainOwnershipIdentifiers")
  name: string;
}

@armResourceOperations
interface DomainOwnershipIdentifiers {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get ownership identifier for domain")
  @operationId("Domains_GetOwnershipIdentifier")
  getOwnershipIdentifier is ArmResourceRead<DomainOwnershipIdentifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  @operationId("Domains_CreateOrUpdateOwnershipIdentifier")
  createOrUpdateOwnershipIdentifier is ArmResourceCreateOrReplaceSync<DomainOwnershipIdentifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates an ownership identifier for a domain or updates identifier details for an existing identifier")
  @operationId("Domains_UpdateOwnershipIdentifier")
  updateOwnershipIdentifier is ArmCustomPatchSync<
    DomainOwnershipIdentifier,
    DomainOwnershipIdentifier
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete ownership identifier for domain")
  @operationId("Domains_DeleteOwnershipIdentifier")
  deleteOwnershipIdentifier is ArmResourceDeleteSync<DomainOwnershipIdentifier>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Lists domain ownership identifiers.")
  @operationId("Domains_ListOwnershipIdentifiers")
  listOwnershipIdentifiers is ArmResourceListByParent<DomainOwnershipIdentifier>;
}

@@projectedName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "A JSON representation of the domain ownership properties."
);
@@projectedName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "json",
  "domainOwnershipIdentifier"
);
@@extension(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "x-ms-client-name",
  "domainOwnershipIdentifier"
);
@@doc(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "A JSON representation of the domain ownership properties."
);
