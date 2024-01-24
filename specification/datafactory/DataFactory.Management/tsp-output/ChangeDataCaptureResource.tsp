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
 * Change data capture resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@Azure.ResourceManager.Private.armResourceInternal(ChangeDataCapture)
@includeInapplicableMetadataInPayload(false)
model ChangeDataCaptureResource extends SubResource {
  /**
   * The change data capture name.
   */
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("changeDataCaptureName")
  @segment("adfcdcs")
  name: string;

  /**
   * Properties of the change data capture.
   */
  @extension("x-ms-client-flatten", true)
  properties: ChangeDataCapture;
}

@armResourceOperations
interface ChangeDataCaptureResources {
  /**
   * Gets a change data capture.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_Get")
  get is ArmResourceRead<
    ChangeDataCaptureResource,
    {
      ...BaseParameters<ChangeDataCaptureResource>;

      /**
       * ETag of the change data capture entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates a change data capture resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ChangeDataCaptureResource,
    {
      ...BaseParameters<ChangeDataCaptureResource>;

      /**
       * ETag of the change data capture entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes a change data capture.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_Delete")
  delete is ArmResourceDeleteSync<ChangeDataCaptureResource>;

  /**
   * Lists all resources of type change data capture.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_ListByFactory")
  listByFactory is ArmResourceListByParent<ChangeDataCaptureResource>;

  /**
   * Starts a change data capture.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_Start")
  start is ArmResourceActionSync<ChangeDataCaptureResource, void, void>;

  /**
   * Stops a change data capture.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_Stop")
  stop is ArmResourceActionSync<ChangeDataCaptureResource, void, void>;

  /**
   * Gets the current status for the change data capture resource.
   */
  // FIXME: ChangeDataCapture_Status could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChangeDataCapture_Status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/adfcdcs/{changeDataCaptureName}/status")
  @get
  status is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The factory name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      /**
       * The change data capture name.
       */
      @maxLength(260)
      @minLength(1)
      @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
      @path
      changeDataCaptureName: string;
    },
    void
  >;
}

@@projectedName(ChangeDataCaptureResources.createOrUpdate::parameters.resource,
  "json",
  "changeDataCapture"
);
@@extension(ChangeDataCaptureResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "changeDataCapture"
);
@@doc(ChangeDataCaptureResources.createOrUpdate::parameters.resource,
  "Change data capture resource definition."
);
