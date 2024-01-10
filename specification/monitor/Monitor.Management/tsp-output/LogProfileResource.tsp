import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("The log profile resource.")
@subscriptionResource
model LogProfileResource is TrackedResource<LogProfileProperties> {
  @doc("The name of the log profile.")
  @key("logProfileName")
  @segment("logprofiles")
  name: string;
}

@armResourceOperations
@projectedName("client", "LogProfiles")
interface LogProfileResources_LogProfiles {
  @doc("Gets the log profile.")
  get is ArmResourceRead<LogProfileResource>;

  @doc("Create or update a log profile in Azure Monitoring REST API.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogProfileResource>;

  @doc("Updates an existing LogProfilesResource. To update other fields use the CreateOrUpdate method.")
  update is ArmCustomPatchSync<LogProfileResource, LogProfileResourcePatch>;

  @doc("Deletes the log profile.")
  delete is ArmResourceDeleteSync<LogProfileResource>;

  @doc("List the log profiles.")
  list is ArmResourceListByParent<LogProfileResource>;
}
