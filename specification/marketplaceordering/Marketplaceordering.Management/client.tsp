import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MarketplaceOrdering;

@@clientName(AgreementTermsOperationGroup, "AgreementTerms");
@@clientName(MarketplaceAgreements.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgreementTerms.properties);

@@clientName(OldAgreementTermsOperationGroup, "OldAgreementTerms");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OldAgreementTerms.properties);
