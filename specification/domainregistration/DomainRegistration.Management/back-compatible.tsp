import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.DomainRegistration;

@@clientName(Domains.createOrUpdate::parameters.resource, "domain");
@@clientName(Domains.update::parameters.properties, "domain");
@@clientName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);

@@clientName(TopLevelDomains.listAgreements::parameters.body,
  "agreementOption"
);

@@clientName(DomainsOperationGroup.listRecommendations::parameters.body,
  "parameters"
);
@@clientName(DomainsOperationGroup.checkAvailability::parameters.body,
  "identifier"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DomainOwnershipIdentifier.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DomainPatchResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TopLevelDomain.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Domain.properties);

@@clientLocation(Operations.list, "DomainRegistrationProvider");
@@clientName(Operations.list, "ListOperations");
