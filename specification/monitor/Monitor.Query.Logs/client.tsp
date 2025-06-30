import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using MonitorQueryLogs;

@@access(QueryOperationGroup.get, Access.internal);
@@access(QueryOperationGroup.getWithResourceId, Access.internal);
@@access(MetadataOperationGroup.get, Access.internal);
@@access(MetadataOperationGroup.post, Access.internal);
