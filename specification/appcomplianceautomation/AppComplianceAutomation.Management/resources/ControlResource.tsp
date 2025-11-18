import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./SnapshotResource.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent a AppComplianceAutomation control resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
@parentResource(SnapshotResource)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ControlProperties)
@added(Versions.v2024_12_15_preview)
model ControlResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Control Id.
   */
  @path
  @key("controlId")
  @segment("controls")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-_]{1,64}$")
  name: string;

  /**
   * Control's property.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ControlProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
@added(Versions.v2024_12_15_preview)
interface ControlInterface {
  /**
   * Get the AppComplianceAutomation control and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Control_Get")
  get is ArmResourceRead<ControlResource>;

  /**
   * Get the AppComplianceAutomation control list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Control_List")
  list is ArmResourceListByParent<
    ControlResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<ControlResource>;
      ...QueryParameters;
    }
  >;
}
