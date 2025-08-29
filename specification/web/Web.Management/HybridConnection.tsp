import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Hybrid Connection contract. This is used to configure a Hybrid Connection.
 */
@parentResource(AppServicePlan)
model HybridConnection
  is Azure.ResourceManager.ProxyResource<HybridConnectionProperties> {
  ...ResourceNameParameter<
    Resource = HybridConnection,
    KeyName = "relayName",
    SegmentName = "relays",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HybridConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service plan. */
        @path
        @segment("serverfarms")
        @key
        name: string,

        /** Name of the Service Bus namespace. */
        @path
        @segment("hybridConnectionNamespaces")
        @key
        namespaceName: string,
      },
      {
        /** Name of the Service Bus relay. */
        @path
        @segment("relays")
        @key
        relayName: string,
      }
    > {}

@armResourceOperations
interface HybridConnections {
  /**
   * Description for Retrieve a Hybrid Connection in use in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_GetHybridConnection")
  getHybridConnection is HybridConnectionOps.Read<HybridConnection>;

  /**
   * Description for Delete a Hybrid Connection in use in an App Service plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_DeleteHybridConnection")
  deleteHybridConnection is HybridConnectionOps.DeleteSync<HybridConnection>;

  /**
   * Description for Get the send key name and value of a Hybrid Connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_ListHybridConnectionKeys")
  @action("listKeys")
  listHybridConnectionKeys is HybridConnectionOps.ActionSync<
    HybridConnection,
    void,
    ArmResponse<HybridConnectionKey>
  >;

  /**
   * Description for Get all apps that use a Hybrid Connection in an App Service Plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServicePlans_ListWebAppsByHybridConnection")
  @get
  @action("sites")
  @list
  listWebAppsByHybridConnection is HybridConnectionOps.ActionSync<
    HybridConnection,
    void,
    ArmResponse<ResourceCollection>
  >;
}
@armResourceOperations
interface HybridConnectionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** The namespace for this hybrid connection. */
        @path
        @segment("hybridConnectionNamespaces")
        @key
        namespaceName: string,
      },
      {
        /** The relay name for this hybrid connection. */
        @path
        @segment("relays")
        @key
        relayName: string,
      }
    > {}

@armResourceOperations
interface HybridConnectionOperationGroup {
  /**
   * Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetHybridConnection")
  getHybridConnection is HybridConnectionOperationGroupOps.Read<HybridConnection>;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateHybridConnection")
  createOrUpdateHybridConnection is HybridConnectionOperationGroupOps.CreateOrUpdateSync<
    HybridConnection,
    Response = ArmResourceUpdatedResponse<HybridConnection>
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateHybridConnection")
  @patch(#{ implicitOptionality: false })
  updateHybridConnection is HybridConnectionOperationGroupOps.CustomPatchSync<
    HybridConnection,
    PatchModel = HybridConnection
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteHybridConnection")
  deleteHybridConnection is HybridConnectionOperationGroupOps.DeleteSync<
    HybridConnection,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;
}
@armResourceOperations
interface HybridConnectionSlotOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** The name of the slot for the web app. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** The namespace for this hybrid connection. */
        @path
        @segment("hybridConnectionNamespaces")
        @key
        namespaceName: string,
      },
      {
        /** The relay name for this hybrid connection. */
        @path
        @segment("relays")
        @key
        relayName: string,
      }
    > {}

@armResourceOperations
interface HybridConnectionSlotOperationGroup {
  /**
   * Description for Retrieves a specific Service Bus Hybrid Connection used by this Web App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetHybridConnectionSlot")
  getHybridConnectionSlot is HybridConnectionSlotOps.Read<HybridConnection>;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateHybridConnectionSlot")
  createOrUpdateHybridConnectionSlot is HybridConnectionSlotOps.CreateOrUpdateSync<
    HybridConnection,
    Response = ArmResourceUpdatedResponse<HybridConnection>
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateHybridConnectionSlot")
  @patch(#{ implicitOptionality: false })
  updateHybridConnectionSlot is HybridConnectionSlotOps.CustomPatchSync<
    HybridConnection,
    PatchModel = HybridConnection
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteHybridConnectionSlot")
  deleteHybridConnectionSlot is HybridConnectionSlotOps.DeleteSync<
    HybridConnection,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;
}

@@doc(HybridConnection.name, "Name of the Service Bus relay.");
@@doc(HybridConnection.properties,
  "HybridConnection resource specific properties"
);
@@doc(HybridConnectionOperationGroup.createOrUpdateHybridConnection::parameters.resource,
  "The details of the hybrid connection."
);
@@doc(HybridConnectionOperationGroup.updateHybridConnection::parameters.properties,
  "The details of the hybrid connection."
);
@@doc(HybridConnectionSlotOperationGroup.createOrUpdateHybridConnectionSlot::parameters.resource,
  "The details of the hybrid connection."
);
@@doc(HybridConnectionSlotOperationGroup.updateHybridConnectionSlot::parameters.properties,
  "The details of the hybrid connection."
);
