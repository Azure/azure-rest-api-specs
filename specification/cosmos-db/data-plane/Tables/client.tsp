import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

namespace Customizations;

@client({
  name: "TableServiceClient",
  service: Data.Tables,
})
interface ClientParent {
  getProperties is Data.Tables.getProperties;
}

@client({
  name: "TableClient",
  service: Data.Tables,
})
interface ClientChild {
  insertOrReplaceEntity is Data.Tables.insertOrReplaceEntity;
}

@@clientNamespace(Data.Tables, "Azure.Data.Tables");
@@clientName(Data.Tables.getProperties, "getServiceProperties");
@@clientName(Data.Tables.setProperties, "setServiceProperties");
@@clientName(Data.Tables.getStatistics, "getServiceStats", "python");
@@clientName(Data.Tables.getAccessPolicy, "getTableAccessPolicy");
@@clientName(Data.Tables.setAccessPolicy, "setTableAccessPolicy");
@@clientName(Data.Tables.insertOrReplaceEntity, "upsertEntity", "python");
@@clientName(AccessPolicy, "TableAccessPolicy");
@@clientName(Logging, "TableAnalyticsLogging");
@@clientName(TableProperties, "TableItem");
@@clientName(CorsRule, "TableCorsRule");
@@access(Table.mergeEntity, Access.internal, "python");
@@access(Table.mergeEntity, Access.internal, "python");
@@access(Table.insertOrMergeEntity, Access.internal, "python");
