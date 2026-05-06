import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.HorizonDb, "HorizonDBMgmtClient");
@@clientName(Microsoft.HorizonDb.HorizonDbCluster, "HorizonDBCluster");
@@clientName(Microsoft.HorizonDb.HorizonDbPool, "HorizonDBPool");
@@clientName(Microsoft.HorizonDb.HorizonDbReplica, "HorizonDBReplica");
@@clientName(Microsoft.HorizonDb.HorizonDbFirewallRule, "HorizonDBFirewallRule");
@@clientName(Microsoft.HorizonDb.HorizonDbPrivateLinkResource, "HorizonDBPrivateLinkResource");
@@clientName(Microsoft.HorizonDb.HorizonDbParameterGroup, "HorizonDBParameterGroup");
@@clientName(Microsoft.HorizonDb.HorizonDbClusterProperties, "HorizonDBClusterProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbClusterPropertiesForPatchUpdate, "HorizonDBClusterPropertiesForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbClusterForPatchUpdate, "HorizonDBClusterForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbPoolProperties, "HorizonDBPoolProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbReplicaProperties, "HorizonDBReplicaProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbReplicaPropertiesForPatchUpdate, "HorizonDBReplicaPropertiesForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbReplicaForPatchUpdate, "HorizonDBReplicaForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbFirewallRuleProperties, "HorizonDBFirewallRuleProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbParameterGroupProperties, "HorizonDBParameterGroupProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbParameterGroupPropertiesForPatchUpdate, "HorizonDBParameterGroupPropertiesForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbParameterGroupForPatchUpdate, "HorizonDBParameterGroupForPatchUpdate");
@@clientName(Microsoft.HorizonDb.HorizonDbParameterGroupConnectionProperties, "HorizonDBParameterGroupConnectionProperties");
@@clientName(Microsoft.HorizonDb.HorizonDbClusterParameterGroupConnectionProperties, "HorizonDBClusterParameterGroupConnectionProperties");
