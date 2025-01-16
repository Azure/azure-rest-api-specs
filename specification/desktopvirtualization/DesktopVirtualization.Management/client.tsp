import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./AppAttachPackage.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using Microsoft.DesktopVirtualization;

@@clientName(AppAttachPackages, "AppAttachPackage");
