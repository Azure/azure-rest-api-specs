import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using BatchPricingsAPI;

@@clientName(BatchPricings.createOrUpdate::parameters.resource, "pricingBatch");
