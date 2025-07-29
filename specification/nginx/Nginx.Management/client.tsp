import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NGINX.NGINXPLUS;

@@clientName(NGINX.NGINXPLUS, "NginxManagementClient", "javascript");
