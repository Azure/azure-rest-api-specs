import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PaloAltoNetworks.Cloudngfw;

@@clientName(PaloAltoNetworks.Cloudngfw,
  "PaloAltoNetworksNgfwMgmtClient",
  "python"
);

// Java
@@clientName(SupportInfo.helpURL, "helpUrl", "java");
@@clientName(SupportInfo.supportURL, "supportUrl", "java");
@@clientName(SupportInfo.registerURL, "registerUrl", "java");
@@clientName(SupportInfoModel.helpURL, "helpUrl", "java");
@@clientName(SupportInfoModel.supportURL, "supportUrl", "java");
@@clientName(SupportInfoModel.registerURL, "registerUrl", "java");

// Model name compatibility fixes for TypeSpec migration
@@clientName(IPAddress, "IpAddress", "java");
@@clientName(IPAddressSpace, "IpAddressSpace", "java");
@@clientName(DNSSettings, "DnsSettings", "java");
@@clientName(DNSProxy, "DnsProxy", "java");
@@clientName(EnabledDNSType, "EnabledDnsType", "java");
