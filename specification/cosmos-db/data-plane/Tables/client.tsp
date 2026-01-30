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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  getProperties is Data.Tables.Service.getProperties;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  setProperties is Data.Tables.Service.setProperties;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  getStatistics is Data.Tables.Service.getStatistics;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  query is Data.Tables.Table.query;
}

@@clientName(ClientParent.getProperties, "getServiceProperties", "python");
@@clientName(ClientParent.setProperties, "setServiceProperties", "python");
@@clientName(ClientParent.getStatistics, "getServiceStats", "python");
@@access(ClientParent.query, Access.internal, "python");

/** Client initialization options for TableClient */
model TableClientOptions {
  /** The name of the table to operate on */
  tableName: string;
}

@@clientInitialization(ClientChild,
  {
    parameters: TableClientOptions,
  }
);

@client({
  name: "TableClient",
  service: Data.Tables,
})
interface ClientChild {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  create is Data.Tables.Table.create;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  delete is Data.Tables.Table.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  queryEntities is Data.Tables.Table.queryEntities;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  queryEntityWithPartitionAndRowKey is Data.Tables.Table.queryEntityWithPartitionAndRowKey;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  insertEntity is Data.Tables.Table.insertEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  deleteEntity is Data.Tables.Table.deleteEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  updateEntity is Data.Tables.Table.updateEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  mergeEntity is Data.Tables.Table.mergeEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  getAccessPolicy is Data.Tables.Table.getAccessPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  setAccessPolicy is Data.Tables.Table.setAccessPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  submitTransaction is Data.Tables.Table.submitTransaction;
}

@@clientName(ClientChild.getAccessPolicy, "getTableAccessPolicy", "python");
@@clientName(ClientChild.setAccessPolicy, "setTableAccessPolicy", "python");
@@clientName(ClientChild.create, "createTable", "python");
@@clientName(ClientChild.delete, "deleteTable", "python");
@@clientName(ClientChild.queryEntityWithPartitionAndRowKey, "getEntity");
@@access(ClientChild.updateEntity, Access.internal, "python");
@@access(ClientChild.mergeEntity, Access.internal, "python");
@@access(ClientChild.queryEntities, Access.internal, "python");

@@clientName(AccessPolicy, "TableAccessPolicy");
@@clientName(Logging, "TableAnalyticsLogging");
@@clientName(TableProperties, "TableItem");
@@clientName(CorsRule, "TableCorsRule");
