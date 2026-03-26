import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Resources;

@@clientName(Subscriptions.checkZonePeers::parameters.body, "parameters");
@@clientName(checkResourceName::parameters.body, "Resource Name Definition");
