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

namespace Microsoft.CertificateRegistration;
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = HostNameBinding,
        KeyName = "hostName",
        SegmentName = "hostNameBindings",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface HostNameBindings {
  /**
   * Description for Get the named hostname binding for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetHostNameBinding")
  getHostNameBinding is HostNameBindingOps.Read<HostNameBinding>;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateHostNameBinding")
  createOrUpdateHostNameBinding is HostNameBindingOps.CreateOrUpdateSync<
    HostNameBinding,
    Response = ArmResourceUpdatedResponse<HostNameBinding>
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteHostNameBinding")
  deleteHostNameBinding is HostNameBindingOps.DeleteSync<HostNameBinding>;

  /**
   * Description for Get hostname bindings for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListHostNameBindings")
  listHostNameBindings is HostNameBindingOps.List<
    HostNameBinding,
    Response = ArmResponse<HostNameBindingCollection>
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
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "name",
          SegmentName = "sites",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Site,
          KeyName = "slot",
          SegmentName = "slots",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = HostNameBinding,
        KeyName = "hostName",
        SegmentName = "hostNameBindings",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface HostNameBindingOperationGroup {
  /**
   * Description for Get the named hostname binding for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetHostNameBindingSlot")
  getHostNameBindingSlot is HostNameBindingOperationGroupOps.Read<HostNameBinding>;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateHostNameBindingSlot")
  createOrUpdateHostNameBindingSlot is HostNameBindingOperationGroupOps.CreateOrUpdateSync<
    HostNameBinding,
    Response = ArmResourceUpdatedResponse<HostNameBinding>
  >;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_DeleteHostNameBindingSlot")
  deleteHostNameBindingSlot is HostNameBindingOperationGroupOps.DeleteSync<HostNameBinding>;

  /**
   * Description for Get hostname bindings for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_ListHostNameBindingsSlot")
  listHostNameBindingsSlot is HostNameBindingOperationGroupOps.List<
    HostNameBinding,
    Response = ArmResponse<HostNameBindingCollection>
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
