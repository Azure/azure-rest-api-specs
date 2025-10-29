import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Cdn;

@@clientName(CertificateSourceParameters,
  "CertificateSourceParametersBase",
  "go"
);
@@clientName(CdnEndpoint, "LinkedEndpoint", "go");
@@clientName(CdnEndpoint, "EndpointResource", "java");

@@clientName(ValidateProbeInput.probeURL, "probeUrl", "java");

@@clientName(AFDDomain, "AfdDomain", "java");
@@clientName(AFDDomainProperties, "AfdDomainProperties", "java");
@@clientName(AFDDomainHttpsCustomizedCipherSuiteSet,
  "AfdDomainHttpsCustomizedCipherSuiteSet",
  "java"
);
@@clientName(AFDDomainHttpsParameters, "AfdDomainHttpsParameters", "java");
@@clientName(AFDDomains, "AfdDomains", "java");
@@clientName(AFDDomainUpdateParameters, "AfdDomainUpdateParameters", "java");
@@clientName(AFDDomainUpdatePropertiesParameters,
  "AfdDomainUpdatePropertiesParameters",
  "java"
);

@@clientName(AFDEndpoint, "AfdEndpoint", "java");
@@clientName(AFDEndpointProperties, "AfdEndpointProperties", "java");
@@clientName(AFDEndpoints, "AfdEndpoints", "java");
@@clientName(AFDEndpointUpdateParameters,
  "AfdEndpointUpdateParameters",
  "java"
);
@@clientName(AFDEndpointPropertiesUpdateParameters,
  "AfdEndpointPropertiesUpdateParameters",
  "java"
);

@@clientName(AFDOrigin, "AfdOrigin", "java");
@@clientName(AFDOriginProperties, "AfdOriginProperties", "java");
@@clientName(AFDOrigins, "AfdOrigins", "java");
@@clientName(AFDOriginGroupUpdateParameters,
  "AfdOriginGroupUpdateParameters",
  "java"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters,
  "AfdOriginGroupUpdatePropertiesParameters",
  "java"
);

@@clientName(AFDOriginGroup, "AfdOriginGroup", "java");
@@clientName(AFDOriginGroupProperties, "AfdOriginGroupProperties", "java");
@@clientName(AFDOriginGroups, "AfdOriginGroups", "java");
@@clientName(AFDOriginGroupUpdateParameters,
  "AfdOriginGroupUpdateParameters",
  "java"
);
@@clientName(AFDOriginGroupUpdatePropertiesParameters,
  "AfdOriginGroupUpdatePropertiesParameters",
  "java"
);

@@clientName(CustomDomainProperties.hostName, "hostname", "java");
@@clientName(CustomDomainPropertiesParameters.hostName, "hostname", "java");
@@clientName(DeepCreatedOriginProperties.hostName, "hostname", "java");
@@clientName(DeepCreatedCustomDomainProperties.hostName, "hostname", "java");
@@clientName(OriginUpdatePropertiesParameters.hostName, "hostname", "java");
@@clientName(EndpointProperties.hostName, "hostname", "java");
@@clientName(ValidateCustomDomainInput.hostName, "hostname", "java");

@@clientName(DeliveryRuleHostNameCondition,
  "DeliveryRuleHostnameCondition",
  "java"
);
@@clientName(AFDOriginUpdateParameters, "AfdOriginUpdateParameters", "java");
@@clientName(HostNameMatchConditionParameters,
  "HostnameMatchConditionParameters",
  "java"
);
@@clientName(AFDEndpointProtocols, "AfdEndpointProtocols", "java");
@@clientName(CheckHostNameAvailabilityInput,
  "CheckHostnameAvailabilityInput",
  "java"
);
@@clientName(RequestSchemeMatchValue,
  "RequestSchemeMatchConditionParametersMatchValuesItem",
  "java"
);
@@clientName(IsDeviceMatchValue,
  "IsDeviceMatchConditionParametersMatchValuesItem",
  "java"
);
@@clientName(DeliveryRuleActionName, "DeliveryRuleActionValue", "java");
@@clientName(AFDStateProperties, "AfdStateProperties", "java");
@@clientName(HostNameOperator, "HostnameOperator", "java");
@@clientName(Microsoft.Cdn, "CdnManagementClient", "javascript");
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`405`,
  "FourHundredFive",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`406`,
  "FourHundredSix",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`403`,
  "FourHundredThree",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`429`,
  "FourHundredTwentyNine",
  "javascript,go"
);
@@clientName(PolicySettingsDefaultCustomBlockResponseStatusCode.`200`,
  "TwoHundred",
  "javascript,go"
);
@@clientName(CdnWebApplicationFirewallPolicy, "CdnWafPolicy", "go");
@@clientName(WebApplicationFirewallPolicy,
  "WebApplicationFirewallPolicy",
  "go"
);
@@clientName(CdnWebApplicationFirewallPolicyProperties,
  "CdnWafPolicyProperties",
  "go"
);
@@clientName(WebApplicationFirewallPolicyProperties,
  "WebApplicationFirewallPolicyProperties",
  "go"
);

@@clientLocation(checkEndpointNameAvailability, "ManagementClient", "go");
@@clientLocation(checkNameAvailability, "ManagementClient", "go");
@@clientLocation(checkNameAvailabilityWithSubscription,
  "ManagementClient",
  "go"
);
@@clientLocation(validateProbe, "ManagementClient", "go");
