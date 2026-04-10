import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using HealthReportsAPI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HealthReport.properties);

