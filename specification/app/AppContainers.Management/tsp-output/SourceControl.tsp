import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App SourceControl.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ContainerApp)
@Azure.ResourceManager.Private.armResourceInternal(SourceControlProperties)
@includeInapplicableMetadataInPayload(false)
model SourceControl extends ProxyResourceBase {
  /**
   * Name of the Container App SourceControl.
   */
  @path
  @key("sourceControlName")
  @segment("sourcecontrols")
  name: string;

  /**
   * SourceControl resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SourceControlProperties;
}

@armResourceOperations
interface SourceControls {
  /**
   * Get a SourceControl of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsSourceControls_Get")
  get is ArmResourceRead<SourceControl>;

  /**
   * Create or update the SourceControl for a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsSourceControls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SourceControl>;

  /**
   * Delete a Container App SourceControl.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsSourceControls_Delete")
  delete is ArmResourceDeleteAsync<SourceControl>;

  /**
   * Get the Container App SourceControls in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsSourceControls_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<SourceControl>;
}

@@projectedName(SourceControls.createOrUpdate::parameters.resource,
  "json",
  "sourceControlEnvelope"
);
@@extension(SourceControls.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "sourceControlEnvelope"
);
@@doc(SourceControls.createOrUpdate::parameters.resource,
  "Properties used to create a Container App SourceControl"
);
