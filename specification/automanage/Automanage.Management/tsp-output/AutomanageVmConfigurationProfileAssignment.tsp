import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automanage;
@doc("Configuration profile assignment is an association between a VM and automanage profile configuration.")
model AutomanageVmConfigurationProfileAssignment
  is ExtensionResource<ConfigurationProfileAssignmentProperties> {
  @doc("The configuration profile assignment name.")
  @path
  @key("configurationProfileAssignmentName")
  @segment("configurationProfileAssignments")
  name: string;

  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface AutomanageVmConfigurationProfileAssignments {
  @doc("Get information about a configuration profile assignment")
  get is ArmResourceRead<AutomanageVmConfigurationProfileAssignment>;
  @doc("Creates an association between a VM and Automanage configuration profile")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomanageVmConfigurationProfileAssignment>;
  @doc("Delete a configuration profile assignment")
  delete is ArmResourceDeleteSync<AutomanageVmConfigurationProfileAssignment>;
  @doc("Get list of configuration profile assignments")
  listByVirtualMachines is ArmResourceListByParent<AutomanageVmConfigurationProfileAssignment>;
}
