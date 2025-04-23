import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeMarketplace;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Publisher.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Offer.properties);
