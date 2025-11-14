import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

@@clientName(QosPolicyOverrides.priorityValue8021Action_Cluster,
  "priorityValue8021ActionCluster"
);
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSMB"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSMB"
);

@@clientLocation(Clusters.listByCluster, Offers);

@@clientLocation(UpdateSummariesOperationGroup.get, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.put, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.delete, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.list, "UpdateSummaries");

@@clientLocation(KubernetesVersionsOperationGroup.listBySubscriptionLocationResource,
  "KubernetesVersions"
);
