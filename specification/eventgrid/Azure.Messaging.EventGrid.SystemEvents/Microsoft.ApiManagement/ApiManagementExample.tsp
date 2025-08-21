import "./ApiManagement.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftApiManagementUserCreatedExample: ApiManagementUserCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/users/apimuser-contoso-com",
};

const MicrosoftApiManagementUserUpdatedExample: ApiManagementUserUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/users/apimuser-contoso-com",
};

const MicrosoftApiManagementUserDeletedExample: ApiManagementUserDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/users/apimuser-contoso-com",
};

const MicrosoftApiManagementSubscriptionCreatedExample: ApiManagementSubscriptionCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/subscriptions/{subscriptionId}",
};

const MicrosoftApiManagementSubscriptionUpdatedExample: ApiManagementSubscriptionUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/subscriptions/{subscriptionId}",
};

const MicrosoftApiManagementSubscriptionDeletedExample: ApiManagementSubscriptionDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/subscriptions/{subscriptionId}",
};

const MicrosoftApiManagementProductCreatedExample: ApiManagementProductCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/products/my_product",
};

const MicrosoftApiManagementProductUpdatedExample: ApiManagementProductUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/products/my_product",
};

const MicrosoftApiManagementProductDeletedExample: ApiManagementProductDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/products/my_product",
};

const MicrosoftApiManagementAPICreatedExample: ApiManagementApiCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/my_api",
};

const MicrosoftApiManagementAPIUpdatedExample: ApiManagementApiUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/my_api;Rev=1",
};

const MicrosoftApiManagementAPIDeletedExample: ApiManagementApiDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/my_api;Rev=1",
};

const MicrosoftApiManagementAPIReleaseCreatedExample: ApiManagementApiReleaseCreatedEventData = #{
  resourceUri: "/subscriptions/subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/{apiId}/releases/{releaseId}",
};

const MicrosoftApiManagementAPIReleaseUpdatedExample: ApiManagementApiReleaseUpdatedEventData = #{
  resourceUri: "/subscriptions/subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/{apiId}/releases/{releaseId}",
};

const MicrosoftApiManagementAPIReleaseDeletedExample: ApiManagementApiReleaseDeletedEventData = #{
  resourceUri: "/subscriptions/subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/apis/{apiId}/releases/{releaseId}",
};

const MicrosoftApiManagementGatewayCreatedExample: ApiManagementGatewayCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}",
};

const MicrosoftApiManagementGatewayUpdatedExample: ApiManagementGatewayUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}",
};

const MicrosoftApiManagementGatewayDeletedExample: ApiManagementGatewayDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}",
};

const MicrosoftApiManagementGatewayHostnameConfigurationCreatedExample: ApiManagementGatewayHostnameConfigurationCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/hostnameConfigurations/example-hostname",
};

const MicrosoftApiManagementGatewayHostnameConfigurationUpdatedExample: ApiManagementGatewayHostnameConfigurationUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/hostnameConfigurations/example-hostname",
};

const MicrosoftApiManagementGatewayHostnameConfigurationDeletedExample: ApiManagementGatewayHostnameConfigurationDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/hostnameConfigurations/example-hostname",
};

const MicrosoftApiManagementGatewayCertificateAuthorityCreatedExample: ApiManagementGatewayCertificateAuthorityCreatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/certificateAuthorities/example-ca",
};

const MicrosoftApiManagementGatewayCertificateAuthorityUpdatedExample: ApiManagementGatewayCertificateAuthorityUpdatedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/certificateAuthorities/example-ca",
};

const MicrosoftApiManagementGatewayCertificateAuthorityDeletedExample: ApiManagementGatewayCertificateAuthorityDeletedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/certificateAuthorities/example-ca",
};

const MicrosoftApiManagementGatewayAPIAddedExample: ApiManagementGatewayApiAddedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/apis/example-api",
};

const MicrosoftApiManagementGatewayAPIRemovedExample: ApiManagementGatewayApiRemovedEventData = #{
  resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{your-rg}/providers/Microsoft.ApiManagement/service/{your-APIM-instance}/gateways/{gateway-name}/apis/example-api",
};
