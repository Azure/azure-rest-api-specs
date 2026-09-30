import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UsageAggregation.properties);

@@clientLocation(UsageAggregatesOperationGroup.list, "UsageAggregates");

@@clientLocation(RateCardOperationGroup.get, "RateCard");
