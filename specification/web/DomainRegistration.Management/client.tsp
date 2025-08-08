import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DomainRegistration;

@@clientLocation(DomainOwnershipIdentifiers.getOwnershipIdentifier, "Domains");
@@clientLocation(DomainOwnershipIdentifiers.createOrUpdateOwnershipIdentifier,
  "Domains"
);
@@clientLocation(DomainOwnershipIdentifiers.updateOwnershipIdentifier,
  "Domains"
);
@@clientLocation(DomainOwnershipIdentifiers.deleteOwnershipIdentifier,
  "Domains"
);
@@clientLocation(DomainOwnershipIdentifiers.listOwnershipIdentifiers,
  "Domains"
);

@@clientLocation(DomainsOperationGroup.checkAvailability, "Domains");
@@clientLocation(DomainsOperationGroup.getControlCenterSsoRequest, "Domains");
@@clientLocation(DomainsOperationGroup.listRecommendations, "Domains");
