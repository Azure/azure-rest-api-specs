import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "./models/investigationModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Monitor;
/**
 * Investigation resource, including result.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
//@Azure.ResourceManager.Private.armResourceInternal(InvestigationProperties)
@doc("An investigation definition.")
//@Versioning.added(Versions.v2024_01_01_preview)
@added(Microsoft.Monitor.Versions.v2024_01_01_preview)
model InvestigationResource extends ExtensionResource<InvestigationProperties> {
  /**
   * The name of the investigation.
   */
  @doc("The name of the investigation.")
  @path
  @key("investigationId")
  @segment("investigations")
  @visibility("read")
  name: string;

  /**
   * The investigation properties, including result.
   */
  // @extension("x-ms-client-flatten", true)
  // properties: InvestigationProperties;
}

@armResourceOperations
interface InvestigationResources {
  /**
   * Gets an investigation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_GetAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  getAtResource is ArmResourceRead<InvestigationResource>;

  /**
   * You can provide the template and parameters directly in the request or link to JSON files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_CreateOrUpdateAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  createOrUpdateAtResource is ArmResourceCreateOrReplaceAsync<
    InvestigationResource,
    BaseParameters<InvestigationResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * A template investigation that is currently running cannot be deleted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_DeleteAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  deleteAtResource is ArmResourceDeleteSync<InvestigationResource>;

  /**
   * Get all the Investigations at the given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtResource")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  listAtResource is ArmResourceListByParent<
    InvestigationResource,
    {
      ...BaseParameters<InvestigationResource>;

      /**
       * The number of results to get. If null is passed, returns all Investigations.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Get all the Investigations at the given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Investigations_ListAtSubscription")
  @added(Microsoft.Monitor.Versions.v2024_01_01_preview)
  listAtSubscription is ArmListBySubscription<InvestigationResource>;

}

@@projectedName(InvestigationResources.createOrUpdateAtResource::parameters.resource,
  "json",
  "investigation"
);
@@extension(InvestigationResources.createOrUpdateAtResource::parameters.resource,
  "x-ms-client-name",
  "investigation"
);
@@doc(InvestigationResources.createOrUpdateAtResource::parameters.resource,
  "Additional parameters supplied to the operation."
);
