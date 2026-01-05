import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ApiManagement;

// Java-specific compatibility customizations generated per TypeSpec migration guidance.
@@clientName(Microsoft.ApiManagement.PreferredIPVersion,
  "PreferredIpVersion",
  "java"
);
@@clientName(Microsoft.ApiManagement.TagTagResourceContractProperties,
  "TagResourceContractProperties",
  "java"
);
@@clientName(Microsoft.ApiManagement.ConnectivityCheckRequest.preferredIPVersion,
  "preferredIpVersion",
  "java"
);
