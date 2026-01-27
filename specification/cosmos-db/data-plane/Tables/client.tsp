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
  insertOrMergeEntity is Data.Tables.Table.insertOrMergeEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  insertOrReplaceEntity is Data.Tables.Table.insertOrReplaceEntity;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  getAccessPolicy is Data.Tables.Table.getAccessPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  setAccessPolicy is Data.Tables.Table.setAccessPolicy;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  submitTransaction is Data.Tables.Table.submitTransaction;
}

@@clientNamespace(Data.Tables, "Azure.Data.Tables");
@@clientName(Data.Tables.Service.getProperties, "getServiceProperties");
@@clientName(Data.Tables.Service.setProperties, "setServiceProperties");
@@clientName(Data.Tables.Service.getStatistics, "getServiceStats");
@@clientName(Data.Tables.Table.getAccessPolicy, "getTableAccessPolicy");
@@clientName(Data.Tables.Table.setAccessPolicy, "setTableAccessPolicy");
@@clientName(Data.Tables.Table.query, "queryTables");
@@clientName(Data.Tables.Table.create, "createTable");
@@clientName(Data.Tables.Table.delete, "deleteTable");
@@clientName(Data.Tables.Table.insertOrReplaceEntity, "upsertEntity");
@@clientName(AccessPolicy, "TableAccessPolicy");
@@clientName(Logging, "TableAnalyticsLogging");
@@clientName(TableProperties, "TableItem");
@@clientName(CorsRule, "TableCorsRule");
@@access(Table.mergeEntity, Access.internal, "python");
@@access(Table.insertOrMergeEntity, Access.internal, "python");
