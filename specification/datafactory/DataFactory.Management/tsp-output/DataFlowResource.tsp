import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Data flow resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@Azure.ResourceManager.Private.armResourceInternal(DataFlow)
@includeInapplicableMetadataInPayload(false)
model DataFlowResource extends SubResource {
  /**
   * The data flow name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("dataFlowName")
  @segment("dataflows")
  name: string;

  /**
   * Data flow properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: DataFlow;
}

@armResourceOperations
interface DataFlowResources {
  /**
   * Gets a data flow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlows_Get")
  get is ArmResourceRead<
    DataFlowResource,
    {
      ...BaseParameters<DataFlowResource>;

      /**
       * ETag of the data flow entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a data flow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlows_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFlowResource,
    {
      ...BaseParameters<DataFlowResource>;

      /**
       * ETag of the data flow entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a data flow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlows_Delete")
  delete is ArmResourceDeleteSync<DataFlowResource>;

  /**
   * Lists data flows.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataFlows_ListByFactory")
  listByFactory is ArmResourceListByParent<DataFlowResource>;
}

@@projectedName(DataFlowResources.createOrUpdate::parameters.resource,
  "json",
  "dataFlow"
);
@@extension(DataFlowResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "dataFlow"
);
@@doc(DataFlowResources.createOrUpdate::parameters.resource,
  "Data flow resource definition."
);
