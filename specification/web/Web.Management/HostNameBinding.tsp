import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * A hostname binding object.
 */
@parentResource(Site)
model HostNameBinding
  is Azure.ResourceManager.ProxyResource<HostNameBindingProperties> {
  ...ResourceNameParameter<
    Resource = HostNameBinding,
    KeyName = "hostName",
    SegmentName = "hostNameBindings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HostNameBindingOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Hostname in the hostname binding. */
        @path
        @segment("hostNameBindings")
        @key
        hostName: string,
      }
    > {}

@armResourceOperations
interface HostNameBindings {
  /**
   * Description for Get the named hostname binding for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_GetHostNameBinding")
  getHostNameBinding is HostNameBindingOps.Read<
    HostNameBinding,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_CreateOrUpdateHostNameBinding")
  createOrUpdateHostNameBinding is HostNameBindingOps.CreateOrUpdateSync<
    HostNameBinding,
    Response = ArmResourceUpdatedResponse<HostNameBinding>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_DeleteHostNameBinding")
  deleteHostNameBinding is HostNameBindingOps.DeleteSync<
    HostNameBinding,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get hostname bindings for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_ListHostNameBindings")
  listHostNameBindings is HostNameBindingOps.List<
    HostNameBinding,
    Response = ArmResponse<HostNameBindingCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface HostNameBindingOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API the named binding for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Hostname in the hostname binding. */
        @path
        @segment("hostNameBindings")
        @key
        hostName: string,
      }
    > {}

@armResourceOperations
interface HostNameBindingOperationGroup {
  /**
   * Description for Get the named hostname binding for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_GetHostNameBindingSlot")
  getHostNameBindingSlot is HostNameBindingOperationGroupOps.Read<
    HostNameBinding,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_CreateOrUpdateHostNameBindingSlot")
  createOrUpdateHostNameBindingSlot is HostNameBindingOperationGroupOps.CreateOrUpdateSync<
    HostNameBinding,
    Response = ArmResourceUpdatedResponse<HostNameBinding>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_DeleteHostNameBindingSlot")
  deleteHostNameBindingSlot is HostNameBindingOperationGroupOps.DeleteSync<
    HostNameBinding,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get hostname bindings for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebApps_ListHostNameBindingsSlot")
  listHostNameBindingsSlot is HostNameBindingOperationGroupOps.List<
    HostNameBinding,
    Response = ArmResponse<HostNameBindingCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(HostNameBinding.name, "Hostname in the hostname binding.");
@@doc(HostNameBinding.properties,
  "HostNameBinding resource specific properties"
);
@@doc(HostNameBindings.createOrUpdateHostNameBinding::parameters.resource,
  "Binding details. This is the JSON representation of a HostNameBinding object."
);
@@doc(HostNameBindingOperationGroup.createOrUpdateHostNameBindingSlot::parameters.resource,
  "Binding details. This is the JSON representation of a HostNameBinding object."
);
