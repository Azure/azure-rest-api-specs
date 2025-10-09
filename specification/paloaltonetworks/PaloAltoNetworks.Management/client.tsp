import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PaloAltoNetworks.Cloudngfw;

// Java
@@clientName(SupportInfo.helpURL, "helpUrl", "java");
@@clientName(SupportInfo.supportURL, "supportUrl", "java");
@@clientName(SupportInfo.registerURL, "registerUrl", "java");
@@clientName(SupportInfoModel.helpURL, "helpUrl", "java");
@@clientName(SupportInfoModel.supportURL, "supportUrl", "java");
@@clientName(SupportInfoModel.registerURL, "registerUrl", "java");
