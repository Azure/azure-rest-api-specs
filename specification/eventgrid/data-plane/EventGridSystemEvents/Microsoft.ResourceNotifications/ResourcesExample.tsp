import "./Resources.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftResourceNotificationsResourcesCreatedOrUpdatedExample: ResourceNotificationsResourceManagementCreatedOrUpdatedEventData = #{
  resourceInfo: #{
    tags: #{},
    id: "/subscriptions/{subscription-id} /resourceGroups/{rg-name}/providers/Microsoft.Storage/storageAccounts/{storageAccount-name}",
    name: "StorageAccount-name",
    type: "Microsoft.Storage/storageAccounts",
    location: "eastus",
    properties: #{
      privateEndpointConnections: #[],
      minimumTlsVersion: "TLS1_2",
      allowBlobPublicAccess: 1,
      allowSharedKeyAccess: 1,
      networkAcls: #{
        bypass: "AzureServices",
        virtualNetworkRules: #[],
        ipRules: #[],
        defaultAction: "Allow",
      },
      supportsHttpsTrafficOnly: 1,
      encryption: #{
        requireInfrastructureEncryption: 0,
        services: #{
          file: #{
            keyType: "Account",
            enabled: 1,
            lastEnabledTime: utcDateTime.fromISO("2023-07-28T20:12:50.6380308Z"),
          },
          blob: #{
            keyType: "Account",
            enabled: 1,
            lastEnabledTime: utcDateTime.fromISO("2023-07-28T20:12:50.6380308Z"),
          },
        },
        keySource: "Microsoft.Storage",
      },
      accessTier: "Hot",
      provisioningState: "Succeeded",
      creationTime: utcDateTime.fromISO("2023-07-28T20:12:50.4661564Z"),
      primaryEndpoints: #{
        dfs: "https://{storageAccount-name}.dfs.core.windows.net/",
        web: "https://{storageAccount-name}.z13.web.core.windows.net/",
        blob: "https://{storageAccount-name}.blob.core.windows.net/",
        queue: "https://{storageAccount-name}.queue.core.windows.net/",
        table: "https://{storageAccount-name}.table.core.windows.net/",
        file: "https://{storageAccount-name}.file.core.windows.net/",
      },
      primaryLocation: "eastus",
      statusOfPrimary: "available",
      secondaryLocation: "westus",
      statusOfSecondary: "available",
      secondaryEndpoints: #{
        dfs: "https://{storageAccount-name} -secondary.dfs.core.windows.net/",
        web: "https://{storageAccount-name}-secondary.z13.web.core.windows.net/",
        blob: "https://{storageAccount-name}-secondary.blob.core.windows.net/",
        queue: "https://{storageAccount-name}-secondary.queue.core.windows.net/",
        table: "https://{storageAccount-name}-secondary.table.core.windows.net/",
      },
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2023-07-28T20:13:10.8418063Z"),
  },
  apiVersion: "2019-06-01",
};

const MicrosoftResourceNotificationsResourcesDeletedExample: ResourceNotificationsResourceManagementDeletedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Storage/storageAccounts/{storageAccount-name}",
    name: "storageAccount-name",
    type: "Microsoft.Storage/storageAccounts",
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2023-07-28T20:11:36.6347858Z"),
  },
};
