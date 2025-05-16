import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
namespace ClientCustomizations;

@client(
  {
    name: "Client",
    service: KeyVault,
  },
  "go"
)
interface Client {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteRoleDefinition is KeyVault.RoleDefinitions.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  deleteRoleAssignment is KeyVault.RoleAssignments.delete;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createOrUpdateRoleDefinition is KeyVault.RoleDefinitions.createOrUpdate;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  createRoleAssignment is KeyVault.RoleAssignments.create;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getRoleDefinition is KeyVault.RoleDefinitions.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getRoleAssignment is KeyVault.RoleAssignments.get;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listRoleDefinitions is KeyVault.RoleDefinitions.list;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  listRoleAssignments is KeyVault.RoleAssignments.listForScope;
}
