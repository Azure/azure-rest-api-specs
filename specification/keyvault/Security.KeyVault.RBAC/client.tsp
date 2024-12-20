import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
namespace ClientCustomizations;

@client({
  name: "Client",
  service: KeyVault,
})
interface Client {
  DeleteRoleDefinition is KeyVault.RoleDefinitions.delete;
  DeleteRoleAssignment is KeyVault.RoleAssignments.delete;
  CreateOrUpdateRoleDefinition is KeyVault.RoleDefinitions.createOrUpdate;
  CreateRoleAssignment is KeyVault.RoleAssignments.create;
  GetRoleDefinition is KeyVault.RoleDefinitions.get;
  GetRoleAssignment is KeyVault.RoleAssignments.get;
  ListRoleDefinitions is KeyVault.RoleDefinitions.list;
  ListRoleAssignments is KeyVault.RoleAssignments.listForScope;
}
