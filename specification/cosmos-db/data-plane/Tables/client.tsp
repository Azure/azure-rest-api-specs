import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

namespace Customizations;

@@clientNamespace(Data.Tables, "Azure.Data.Tables");
@@clientNamespace(Data.Tables.Table, "Azure.Data.Tables");

@@clientName(Data.Tables, "TableServiceClient");
@@clientName(Data.Tables.Table, "TableClient");

@@clientInitialization(Data.Tables.Table,
  {
    parameters: TablePathParameter,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);

@@clientName(getProperties, "getServiceProperties");
@@clientName(getProperties, "setServiceProperties");
@@clientName(getStatistics, "getServiceStats", "python");
@@clientName(Table.getAccessPolicy, "getTableAccessPolicy");
@@clientName(Table.setAccessPolicy, "setTableAccessPolicy");
@@clientName(Table.insertOrReplaceEntity, "upsertEntity", "python");
@@clientName(AccessPolicy, "TableAccessPolicy");
@@clientName(Logging, "TableAnalyticsLogging");
@@clientName(TableProperties, "TableItem");
@@clientName(CorsRule, "TableCorsRule");
@@access(Table.mergeEntity, Access.internal, "python");
@@access(Table.mergeEntity, Access.internal, "python");
@@access(Table.insertOrMergeEntity, Access.internal, "python");
