import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DomainRegistration;

@@clientName(Domains.createOrUpdate::parameters.resource, "domain");
@@clientName(Domains.update::parameters.properties, "domain");
@@clientLocation(DomainOwnershipIdentifiers.getOwnershipIdentifier, "Domains");
@@clientLocation(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier,
  "Domains"
);
@@clientName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(DomainOwnershipIdentifiers.updateOwnershipIdentifier,
  "Domains"
);
@@clientName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(DomainOwnershipIdentifiers.deleteOwnershipIdentifier,
  "Domains"
);
@@clientLocation(DomainOwnershipIdentifiers.listOwnershipIdentifiers,
  "Domains"
);

@@clientName(TopLevelDomains.listAgreements::parameters.body,
  "agreementOption"
);
@@clientLocation(DomainsOperationGroup.checkAvailability, "Domains");
@@clientLocation(DomainsOperationGroup.getControlCenterSsoRequest, "Domains");
@@clientLocation(DomainsOperationGroup.listRecommendations, "Domains");

@@clientName(DomainsOperationGroup.listRecommendations::parameters.body, "parameters");
@@clientName(DomainsOperationGroup.checkAvailability::parameters.body, "identifier");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainOwnershipIdentifier.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DomainPatchResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TopLevelDomain.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Domain.properties);

@@OpenAPI.extension(NameIdentifierCollection.value, "x-ms-identifiers", #["name"]);
@@OpenAPI.extension(TldLegalAgreementCollection.value, "x-ms-identifiers", #["agreementKey"]);

@@clientLocation(Operations.list, "DomainRegistrationProvider");
@@clientName(Operations.list, "ListOperations");