import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Subscription;

@@clientName(SubscriptionAliasResponses.create::parameters.resource, "body");

@@clientName(GetTenantPolicyResponses.addUpdatePolicyForTenant::parameters.resource,
  "body"
);
