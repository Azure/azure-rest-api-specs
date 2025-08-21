import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

using Microsoft.SignalRService;

@@clientName(Microsoft.SignalRService,
  "WebPubSubManagementClient",
  "javascript,python"
);

@@clientDoc(Microsoft.SignalRService.EventHandler.urlTemplate,
  """
    Gets or sets the URL template for the event handler. The actual URL is calculated when the corresponding event is triggered. 
    The template supports predefined parameters syntax: `{event}`, `{hub}`, and KeyVault reference syntax `{&#64;Microsoft.KeyVault(SecretUri=_your_secret_identifier_)}` 
    For example, if the template is `http://example.com/api/{event}`, when `connect` event is triggered, a POST request will be sent to the URL `http://example.com/chat/api/connect`.
    Note: Parameters are not allowed in the hostname of the URL, and curly brackets `{}` are reserved for parameter syntax only. If your URL path contains literal curly brackets, please URL-encode them to ensure proper handling.
    """,
  DocumentationMode.replace,
  "java"
);

@@clientName(WebPubSubProperties.externalIP, "externalIp", "java");
@@clientName(WebPubSubProperties.hostName, "hostname", "java");
@@clientName(WebPubSubProperties.hostNamePrefix, "hostnamePrefix", "java");
@@clientName(ACLAction, "AclAction", "java");
@@clientName(NetworkACL, "NetworkAcl", "java");
@@clientName(IPRule, "IpRule", "java");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "java");

// Resolve breaking changes for Go SDK compatibility
@@clientName(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go");
@@clientName(Microsoft.SignalRService.WebPubSubResourceList,
  "ResourceInfoList",
  "go"
);
