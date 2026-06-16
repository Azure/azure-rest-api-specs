import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Quota;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuotaRequestSubmitResponse201.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CurrentQuotaLimit.quotaInformation);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CurrentQuotaLimit.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuotaRequestOneResourceSubmitResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuotaRequestOneResourceProperties.properties);

@@clientLocation(CurrentQuotaLimitBases.get, "Quota");
@@clientLocation(CurrentQuotaLimitBases.createOrUpdate, "Quota");
@@clientName(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.update, "Quota");
@@clientName(CurrentQuotaLimitBases.update::parameters.properties,
  "createQuotaRequest"
);
@@clientLocation(CurrentQuotaLimitBases.list, "Quota");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuotaRequestDetails.properties);
