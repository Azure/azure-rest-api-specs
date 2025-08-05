import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using LiftrBase;
using LiftrBase.Storage;

namespace LiftrBase;

@@clientName(Qumulo.Storage, "QumuloMgmt", "python");
@@clientName(FileSystemResource, "QumuloFileSystemResource", "csharp");
@@clientName(FileSystemResourceProperties.storageSku,
  "StorageSkuName",
  "csharp"
);
@@clientName(FileSystemResourceProperties.clusterLoginUrl,
  "clusterLoginUri",
  "csharp"
);
@@alternateType(FileSystemResourceProperties.clusterLoginUrl, url, "csharp");
@@alternateType(FileSystemResourceProperties.privateIPs,
  ipV4Address[],
  "csharp"
);
@@clientName(ProvisioningState, "QumuloArmProvisioningState", "csharp");
@@clientName(FileSystemResourceProperties.provisioningState,
  "ArmProvisioningState",
  "csharp"
);
@@clientName(UserDetails, "QumuloUserDetails", "csharp");
@@clientName(MarketplaceSubscriptionStatus,
  "QumuloMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(MarketplaceDetails.marketplaceSubscriptionStatus,
  "QumuloMarketplaceSubscriptionStatus",
  "csharp"
);
@@alternateType(FileSystemResourceUpdateProperties.delegatedSubnetId,
  armResourceIdentifier,
  "csharp"
);

#suppress "deprecated" "for backward compatibility purpose"
@@flattenProperty(LiftrBase.Storage.FileSystemResource.properties, "csharp");

/**
 * For backward compatibility purpose, this enum is added back.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "This is added back for backward compatibility purpose because the previous api-version has this"
@usage(Usage.input | Usage.output, "csharp")
@access(Access.public, "csharp")
enum StorageSku {
  /** Standard Storage Sku. */
  Standard,

  /** Performance Storage Sku. */
  Performance,
}

/**
 * For backward compatibility purpose, this enum is added back.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "This is added back for backward compatibility purpose because the previous api-version has this"
@usage(Usage.input | Usage.output, "csharp")
@access(Access.public, "csharp")
enum QumuloProvisioningState {
  NotSpecified,
  Accepted,
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
  Deleted,
}

/**
 * For backward compatibility purpose, this enum is added back.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "This is added back for backward compatibility purpose because the previous api-version has this"
@usage(Usage.input | Usage.output, "csharp")
@access(Access.public, "csharp")
@clientName("MarketplaceSubscriptionStatus", "csharp")
enum OldMarketplaceSubscriptionStatus {
  PendingFulfillmentStart,
  Subscribed,
  Suspended,
  Unsubscribed,
}
