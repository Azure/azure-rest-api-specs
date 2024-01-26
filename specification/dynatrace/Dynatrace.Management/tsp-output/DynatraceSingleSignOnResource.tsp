import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Dynatrace.Observability;
/**
 * Single sign-on configurations for a given monitor resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MonitorResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  DynatraceSingleSignOnProperties
)
model DynatraceSingleSignOnResource extends ProxyResourceBase {
  /**
   * Single Sign On Configuration Name
   */
  @path
  @key("configurationName")
  @segment("singleSignOnConfigurations")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: DynatraceSingleSignOnProperties;
}

@armResourceOperations
interface DynatraceSingleSignOnResources {
  /**
   * Get a DynatraceSingleSignOnResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOn_Get")
  get is ArmResourceRead<DynatraceSingleSignOnResource>;

  /**
   * Create a DynatraceSingleSignOnResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOn_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DynatraceSingleSignOnResource,
    BaseParameters<DynatraceSingleSignOnResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all DynatraceSingleSignOnResource by monitorName
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SingleSignOn_List")
  list is ArmResourceListByParent<DynatraceSingleSignOnResource>;
}
