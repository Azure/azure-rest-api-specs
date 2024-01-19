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

namespace Microsoft.Insights;
@doc("The log profile resource.")
@subscriptionResource
model LogProfileResource is TrackedResource<LogProfileProperties> {
  @doc("The name of the log profile.")
  @path
  @key("logProfileName")
  @segment("logprofiles")
  name: string;
}

@armResourceOperations
interface LogProfileResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the log profile.")
  @operationId("LogProfiles_Get")
  get is ArmResourceRead<LogProfileResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a log profile in Azure Monitoring REST API.")
  @operationId("LogProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogProfileResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing LogProfilesResource. To update other fields use the CreateOrUpdate method.")
  @operationId("LogProfiles_Update")
  update is ArmCustomPatchSync<LogProfileResource, LogProfileResourcePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the log profile.")
  @operationId("LogProfiles_Delete")
  delete is ArmResourceDeleteSync<LogProfileResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the log profiles.")
  @operationId("LogProfiles_List")
  list is ArmResourceListByParent<LogProfileResource>;
}

@@projectedName(LogProfileResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LogProfileResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LogProfileResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@projectedName(LogProfileResources.update::parameters.properties,
  "json",
  "logProfilesResource"
);
@@extension(LogProfileResources.update::parameters.properties,
  "x-ms-client-name",
  "logProfilesResource"
);
@@doc(LogProfileResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
