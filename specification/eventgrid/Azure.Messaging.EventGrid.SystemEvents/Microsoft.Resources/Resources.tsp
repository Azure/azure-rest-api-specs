/** Describes the schema of the Azure resource events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  //TODO urls dont work as examples?

  const MicrosoftResourcesResourceWriteSuccessExample: ResourceWriteSuccessEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/write",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      _claim_names: "{\"groups\":\"src1\"}",
      _claim_sources: "{\"src1\":{\"endpoint\":\"{URI}\"}}",
    },
    correlationId: "{ID}",
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/write",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteSuccess event. This is raised when a resource create or update operation succeeds. */
  @example(MicrosoftResourcesResourceWriteSuccessExample)
  model ResourceWriteSuccessEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceWriteFailureExample: ResourceWriteFailureEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/write",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      _claim_names: "{\"groups\":\"src1\"}",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/write",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteFailure event. This is raised when a resource create or update operation fails. */
  @example(MicrosoftResourcesResourceWriteFailureExample)
  model ResourceWriteFailureEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceWriteCancelExample: ResourceWriteCancelEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/write",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      _claim_names: "{\"groups\":\"src1\"}",
      _claim_sources: "{\"src1\":{\"endpoint\":\"{URI}\"}}",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/write",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteCancel event. This is raised when a resource create or update operation is canceled. */
  @example(MicrosoftResourcesResourceWriteCancelExample)
  model ResourceWriteCancelEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceDeleteSuccessExample: ResourceDeleteSuccessEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/delete",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      _claim_names: "{\"groups\":\"src1\"}",
      _claim_sources: "{\"src1\":{\"endpoint\":\"{URI}\"}}",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "DELETE",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}?api-version=2018-02-01",
    },
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/delete",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteSuccess event. This is raised when a resource delete operation succeeds. */
  @example(MicrosoftResourcesResourceDeleteSuccessExample)
  model ResourceDeleteSuccessEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceDeleteFailureExample: ResourceDeleteFailureEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/delete",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "DELETE",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}?api-version=2018-02-01",
    },
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/delete",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteFailure event. This is raised when a resource delete operation fails. */
  @example(MicrosoftResourcesResourceDeleteFailureExample)
  model ResourceDeleteFailureEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceDeleteCancelExample: ResourceDeleteCancelEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
      action: "Microsoft.Storage/storageAccounts/delete",
      evidence: #{ role: "Subscription Admin" },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      _claim_names: "{\"groups\":\"src1\"}",
      _claim_sources: "{\"src1\":{\"endpoint\":\"{URI}\"}}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "DELETE",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}?api-version=2018-02-01",
    },
    resourceProvider: "Microsoft.Storage",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Storage/storageAccounts/{storage-name}",
    operationName: "Microsoft.Storage/storageAccounts/delete",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteCancel event. This is raised when a resource delete operation is canceled. */
  @example(MicrosoftResourcesResourceDeleteCancelExample)
  model ResourceDeleteCancelEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceActionSuccessExample: ResourceActionSuccessEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
      action: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
      evidence: #{
        role: "Contributor",
        roleAssignmentScope: "/subscriptions/{subscription-id}",
        roleAssignmentId: "{ID}",
        roleDefinitionId: "{ID}",
        principalId: "{ID}",
        principalType: "ServicePrincipal",
      },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      aio: "{token}",
      appid: "{ID}",
      appidacr: "2",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "POST",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey/listKeys?api-version=2017-04-01",
    },
    resourceProvider: "Microsoft.EventHub",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
    operationName: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionSuccess event. This is raised when a resource action operation succeeds. */
  @example(MicrosoftResourcesResourceActionSuccessExample)
  model ResourceActionSuccessEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceActionFailureExample: ResourceActionFailureEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
      action: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
      evidence: #{
        role: "Contributor",
        roleAssignmentScope: "/subscriptions/{subscription-id}",
        roleAssignmentId: "{ID}",
        roleDefinitionId: "{ID}",
        principalId: "{ID}",
        principalType: "ServicePrincipal",
      },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      aio: "{token}",
      appid: "{ID}",
      appidacr: "2",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "POST",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey/listKeys?api-version=2017-04-01",
    },
    resourceProvider: "Microsoft.EventHub",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
    operationName: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionFailure event. This is raised when a resource action operation fails. */
  @example(MicrosoftResourcesResourceActionFailureExample)
  model ResourceActionFailureEventData {
    ...ResourceBaseEventData;
  }

  const MicrosoftResourcesResourceActionCancelExample: ResourceActionCancelEventData = #{
    authorization: #{
      scope: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
      action: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
      evidence: #{
        role: "Contributor",
        roleAssignmentScope: "/subscriptions/{subscription-id}",
        roleAssignmentId: "{ID}",
        roleDefinitionId: "{ID}",
        principalId: "{ID}",
        principalType: "ServicePrincipal",
      },
    },
    claims: #{
      aud: "{audience-claim}",
      iss: "{issuer-claim}",
      iat: "{issued-at-claim}",
      nbf: "{not-before-claim}",
      exp: "{expiration-claim}",
      aio: "{token}",
      appid: "{ID}",
      appidacr: "2",
      uti: "{ID}",
      ver: "1.0",
    },
    correlationId: "{ID}",
    httpRequest: #{
      clientRequestId: "{ID}",
      clientIpAddress: "{IP-address}",
      method: "POST",
      url: "https://management.azure.com/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey/listKeys?api-version=2017-04-01",
    },
    resourceProvider: "Microsoft.EventHub",
    resourceUri: "/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.EventHub/namespaces/{namespace}/AuthorizationRules/RootManageSharedAccessKey",
    operationName: "Microsoft.EventHub/namespaces/AuthorizationRules/listKeys/action",
    status: "Succeeded",
    subscriptionId: "{subscription-id}",
    tenantId: "{tenant-id}",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionCancel event. This is raised when a resource action operation is canceled. */
  @example(MicrosoftResourcesResourceActionCancelExample)
  model ResourceActionCancelEventData {
    ...ResourceBaseEventData;
  }

  /** The details of the HTTP request. */
  model ResourceHttpRequest {
    /** The client request ID. */
    clientRequestId?: string;

    /** The client IP address. */
    clientIpAddress?: string;

    /** The request method. */
    method?: string;

    /** The url used in the request. */
    url?: string;
  }

  /** The details of the authorization for the resource. */
  model ResourceAuthorization {
    /** The scope of the authorization. */
    scope?: string;

    /** The action being requested. */
    action?: string;

    /** The evidence for the authorization. */
    evidence: Record<string>;
  }

  alias ResourceBaseEventData = {
    /** The tenant ID of the resource. */
    tenantId?: string;

    /** The subscription ID of the resource. */
    subscriptionId?: string;

    /** The resource group of the resource. */
    resourceGroup?: string;

    /** The resource provider performing the operation. */
    resourceProvider?: string;

    /** The URI of the resource in the operation. */
    resourceUri?: string;

    /** The operation that was performed. */
    operationName?: string;

    /** The status of the operation. */
    status?: string;

    /** The requested authorization for the operation. */
    authorization: ResourceAuthorization;

    /** The properties of the claims. */
    claims: Record<string>;

    /** An operation ID used for troubleshooting. */
    correlationId?: string;

    /** The details of the operation. */
    httpRequest?: ResourceHttpRequest;
  };
}
