import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Data.Tables;

@@clientNamespace(Data.Tables, "Azure.Data.Tables");
@@clientNamespace(Data.Tables.Table, "Azure.Data.Tables");


@@clientInitialization(Data.Tables.Table,
  {
    parameters: TablePathParameter,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
