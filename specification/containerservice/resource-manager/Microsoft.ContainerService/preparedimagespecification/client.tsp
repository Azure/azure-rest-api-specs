import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerService;

@@clientName(Microsoft.ContainerService, "PreparedImgSpecMgmtClient", "java");
@@clientName(Microsoft.ContainerService, "ContainerServicePreparedImgSpecMgmtClient", "python");
