import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
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

@@clientName(DomainsOperationGroup.listRecommendations::parameters.body,
  "parameters"
);
@@clientName(DomainsOperationGroup.checkAvailability::parameters.body,
  "identifier"
);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DomainOwnershipIdentifier.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DomainPatchResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TopLevelDomain.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Domain.properties);

@@OpenAPI.extension(NameIdentifierCollection.value,
  "x-ms-identifiers",
  #["name"]
);
@@OpenAPI.extension(TldLegalAgreementCollection.value,
  "x-ms-identifiers",
  #["agreementKey"]
);

@@clientLocation(Operations.list, "DomainRegistrationProvider");
@@clientName(Operations.list, "ListOperations");
