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
/**
 * The log profile resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(LogProfileProperties)
@includeInapplicableMetadataInPayload(false)
model LogProfileResource extends TrackedResourceBase {
  /**
   * The name of the log profile.
   */
  @path
  @key("logProfileName")
  @segment("logprofiles")
  name: string;

  /**
   * The log profile properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: LogProfileProperties;
}

@armResourceOperations
interface LogProfileResources {
  /**
   * Gets the log profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogProfiles_Get")
  get is ArmResourceRead<LogProfileResource>;

  /**
   * Create or update a log profile in Azure Monitoring REST API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogProfileResource>;

  /**
   * Updates an existing LogProfilesResource. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("LogProfiles_Update")
  update is ArmCustomPatchSync<LogProfileResource, LogProfileResourcePatch>;

  /**
   * Deletes the log profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogProfiles_Delete")
  delete is ArmResourceDeleteSync<LogProfileResource>;

  /**
   * List the log profiles.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
