import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NGINX.NGINXPLUS;

@@clientName(NGINX.NGINXPLUS, "NginxManagementClient", "javascript");

// Client location overrides for NginxDeployments operations
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.get,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.createOrUpdate,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.update,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.delete,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listByResourceGroup,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listBySubscription,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listDefaultWafPolicies,
  "Deployments",
  "!csharp"
);

// Java client name overrides to maintain consistent casing
@@clientName(NGINX.NGINXPLUS.NginxPublicIPAddress,
  "NginxPublicIpAddress",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAddress,
  "NginxPrivateIpAddress",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAllocationMethod,
  "NginxPrivateIpAllocationMethod",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxFrontendIPConfiguration,
  "NginxFrontendIpConfiguration",
  "java"
);
