import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

@@clientName(ClusterProperties.pointInTimeUTC, "PointInTimeUtc", "java");
