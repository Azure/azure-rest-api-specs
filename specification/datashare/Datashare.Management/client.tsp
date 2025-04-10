import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataShare;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConsumerSourceDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen1FileDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen1FolderDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FileDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FileDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FileSystemDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FileSystemDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FolderDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdlsGen2FolderDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobContainerDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobContainerDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobFolderDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobFolderDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoClusterDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoClusterDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoDatabaseDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KustoDatabaseDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledSourceSynchronizationSetting.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledSynchronizationSetting.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledTrigger.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlDBTableDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlDBTableDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlDWTableDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SqlDWTableDataSetMapping.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SynapseWorkspaceSqlPoolTableDataSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SynapseWorkspaceSqlPoolTableDataSetMapping.properties);

@@clientName(Accounts.create::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "accountUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Account.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConsumerInvitation.properties);

@@clientName(DataSets.create::parameters.resource, "dataSet");

@@clientName(DataSetMappings.create::parameters.resource, "dataSetMapping");

@@clientName(Invitations.create::parameters.resource, "invitation");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Invitation.properties);

@@clientName(ProviderShareSubscriptions.adjust::parameters.body,
  "providerShareSubscription"
);
@@clientName(ProviderShareSubscriptions.reinstate::parameters.body,
  "providerShareSubscription"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProviderShareSubscription.properties);

@@clientName(Shares.create::parameters.resource, "share");
@@clientName(Shares.listSynchronizationDetails::parameters.body,
  "shareSynchronization"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Share.properties);

@@clientName(ShareSubscriptions.create::parameters.resource,
  "shareSubscription"
);
@@clientName(ShareSubscriptions.cancelSynchronization::parameters.body,
  "shareSubscriptionSynchronization"
);
@@clientName(ShareSubscriptions.listSynchronizationDetails::parameters.body,
  "shareSubscriptionSynchronization"
);
@@clientName(ShareSubscriptions.synchronize::parameters.body, "synchronize");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ShareSubscription.properties);

@@clientName(SynchronizationSettings.create::parameters.resource,
  "synchronizationSetting"
);

@@clientName(Triggers.create::parameters.resource, "trigger");
