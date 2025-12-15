import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

@@clientName(Microsoft.ProviderHub, "ProviderHubMgmtClient", "python");

@@clientLocation(ProviderRegistrations.checkinManifest, "Client", "go");
@@clientLocation(ProviderRegistrations.generateManifest, "Client", "go");
@@clientLocation(OperationsPutContents.createOrUpdate
  , "Client", "go");
@@clientLocation(OperationsPutContents.delete, "Client", "go");
@@clientLocation(OperationsPutContents.listByProviderRegistration, "Client", "go");