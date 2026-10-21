import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Edge;

/*
 * Following section is for overriding the client sdk method names
 */
@@clientName(Sites.list, "ListByResourceGroup");
@@clientName(SitesByServiceGroup.list, "ListByServiceGroup");
