import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;

@@clientName(Microsoft.Commerce, "UsageManagementClient", "python");
@@clientName(OfferTermInfoName, "OfferTermInfoEnum", "python");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Legacy.clientDefaultValue(UsageAggregatesListParameters.aggregationGranularity,
  "Daily",
  "python"
);

@@alternateType(Microsoft.Commerce.UsageSample.infoFields,
  ClientCustomizations.InfoField,
  "java"
);

namespace ClientCustomizations {
  model InfoField extends Record<string> {
    project?: string;
  }
}