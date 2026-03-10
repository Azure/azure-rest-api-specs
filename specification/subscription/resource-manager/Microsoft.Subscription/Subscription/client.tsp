import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Subscription;
using Azure.Core;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");
