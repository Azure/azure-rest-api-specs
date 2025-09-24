import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Consumption;
using Azure.ClientGenerator.Core;

// Java SDK client customizations for breaking change mitigations

// Fix property name changes from lowercase to uppercase
@@clientName(LotSummary.eTag, "etag", "java");
@@clientName(ModernChargeSummary.eTag, "etag", "java");
@@clientName(ChargeSummary.eTag, "etag", "java");
@@clientName(LegacyChargeSummary.eTag, "etag", "java");
@@clientName(EventSummary.eTag, "etag", "java");
@@clientName(Budget.eTag, "etag", "java");
@@clientName(TagsResult.eTag, "etag", "java");
@@clientName(CreditSummary.eTag, "etag", "java");
