import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
@doc("Configuration profile assignment is an association between a VM and automanage profile configuration.")
model ConfigurationProfileAssignment
  is ExtensionResource<ConfigurationProfileAssignmentProperties> {
  @doc("The configuration profile assignment name.")
  @path
  @key("configurationProfileAssignmentName")
  @segment("configurationProfileAssignments")
  name: string;

  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface ConfigurationProfileAssignments {
  @doc("Get information about a configuration profile assignment")
  get is ArmResourceRead<ConfigurationProfileAssignment>;

  @doc("Creates an association between a VM and Automanage configuration profile")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationProfileAssignment>;

  @doc("Delete a configuration profile assignment")
  delete is ArmResourceDeleteSync<ConfigurationProfileAssignment>;

  @doc("Get list of configuration profile assignments")
  listByVirtualMachines is ArmResourceListByParent<ConfigurationProfileAssignment>;
}

@@projectedName(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration profile assignment."
);
