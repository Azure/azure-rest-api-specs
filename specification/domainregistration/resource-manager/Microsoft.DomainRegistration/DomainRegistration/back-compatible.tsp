import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.DomainRegistration;

@@clientName(Domains.createOrUpdate::parameters.resource, "domain");
@@clientName(Domains.update::parameters.properties, "domain");
@@clientLocation(DomainOwnershipIdentifiers.getOwnershipIdentifier,
  Domains,
  "!csharp"
);
@@clientLocation(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier,
  Domains,
  "!csharp"
);
@@clientName(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier::parameters.resource,
  "domainOwnershipIdentifier"
);
@@clientLocation(DomainOwnershipIdentifiers.updateOwnershipIdentifier,
  Domains,
  "!csharp"
);
@@clientName(DomainOwnershipIdentifiers.updateOwnershipIdentifier::parameters.properties,
  "domainOwnershipIdentifier"
);
@@clientLocation(DomainOwnershipIdentifiers.deleteOwnershipIdentifier,
  Domains,
  "!csharp"
);
@@clientLocation(DomainOwnershipIdentifiers.listOwnershipIdentifiers,
  Domains,
  "!csharp"
);

@@clientName(TopLevelDomains.listAgreements::parameters.body,
  "agreementOption"
);
@@clientLocation(DomainsOperationGroup.checkAvailability, Domains, "!csharp");
@@clientLocation(DomainsOperationGroup.getControlCenterSsoRequest,
  Domains,
  "!csharp"
);
@@clientLocation(DomainsOperationGroup.listRecommendations, Domains, "!csharp");

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

@@clientLocation(Operations.list, "DomainRegistrationProvider", "!csharp");
@@clientName(Operations.list, "ListOperations");
