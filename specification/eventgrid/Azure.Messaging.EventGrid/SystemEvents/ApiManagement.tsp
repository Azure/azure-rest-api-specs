import "@azure-tools/typespec-client-generator-core";


using Azure.ClientGenerator.Core;

@doc("Describes the schema of the Azure API Management events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid;
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserCreated event.")
  model ApiManagementUserCreatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserUpdated event.")
  model ApiManagementUserUpdatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.UserDeleted event.")
  model ApiManagementUserDeletedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionCreated event.")
  model ApiManagementSubscriptionCreatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionUpdated event.")
  model ApiManagementSubscriptionUpdatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.SubscriptionDeleted event.")
  model ApiManagementSubscriptionDeletedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductCreated event.")
  model ApiManagementProductCreatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductUpdated event.")
  model ApiManagementProductUpdatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.ProductDeleted event.")
  model ApiManagementProductDeletedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APICreated event.")
  model ApiManagementApiCreatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIUpdated event.")
  model ApiManagementApiUpdatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIDeleted event.")
  model ApiManagementApiDeletedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseCreated event.")
  model ApiManagementApiReleaseCreatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseUpdated event.")
  model ApiManagementApiReleaseUpdatedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.APIReleaseDeleted event.")
  model ApiManagementApiReleaseDeletedEventData {
    ...ApiManagementBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCreated event.")
  model ApiManagementGatewayCreatedEventData {
    ...ApiGatewayBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayUpdated event.")
  model ApiManagementGatewayUpdatedEventData {
    ...ApiGatewayBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayDeleted event.")
  model ApiManagementGatewayDeletedEventData {
    ...ApiGatewayBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationCreated event.")
  model ApiManagementGatewayHostnameConfigurationCreatedEventData {
    ...ApiGatewayHostnameBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationUpdated event.")
  model ApiManagementGatewayHostnameConfigurationUpdatedEventData {
    ...ApiGatewayHostnameBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayHostnameConfigurationDeleted event.")
  model ApiManagementGatewayHostnameConfigurationDeletedEventData {
    ...ApiGatewayHostnameBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityCreated event.")
  model ApiManagementGatewayCertificateAuthorityCreatedEventData {
    ...ApiGatewayCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityUpdated event.")
  model ApiManagementGatewayCertificateAuthorityUpdatedEventData {
    ...ApiGatewayCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayCertificateAuthorityDeleted event.")
  model ApiManagementGatewayCertificateAuthorityDeletedEventData {
    ...ApiGatewayCertificateBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIAdded event.")
  model ApiManagementGatewayApiAddedEventData {
    ...ApiGatewayApiBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.ApiManagement.GatewayAPIRemoved event.")
  model ApiManagementGatewayApiRemovedEventData {
    ...ApiGatewayApiBase;
  }

  alias ApiManagementBase = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/<ResourceType>/<ResourceName>`")
    resourceUri?: string;
  };

  alias ApiGatewayBase = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<ResourceName>`")
    resourceUri?: string;
  };

  alias ApiGatewayHostnameBase = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/hostnameConfigurations/<ResourceName>`")
    resourceUri?: string;
  };

  alias ApiGatewayCertificateBase = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/certificateAuthorities/<ResourceName>`")
    resourceUri?: string;
  };

  alias ApiGatewayApiBase = {
    @doc("The fully qualified ID of the resource that the compliance state change is for, including the resource name and resource type. Uses the format, `/subscriptions/<SubscriptionID>/resourceGroups/<ResourceGroup>/Microsoft.ApiManagement/service/<ServiceName>/gateways/<GatewayName>/apis/<ResourceName>`")
    resourceUri?: string;
  };
