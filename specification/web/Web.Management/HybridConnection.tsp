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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Retrieve a Hybrid Connection in use in an App Service plan.")
  getHybridConnection is HybridConnectionOps.Read<
    HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Delete a Hybrid Connection in use in an App Service plan.
   */
  @summary("Delete a Hybrid Connection in use in an App Service plan.")
  deleteHybridConnection is HybridConnectionOps.DeleteSync<
    HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get the send key name and value of a Hybrid Connection.
   */
  @summary("Get the send key name and value of a Hybrid Connection.")
  @action("listKeys")
  listHybridConnectionKeys is HybridConnectionOps.ActionSync<
    HybridConnection,
    void,
    ArmResponse<HybridConnectionKey>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all apps that use a Hybrid Connection in an App Service Plan.
   */
  @summary("Get all apps that use a Hybrid Connection in an App Service Plan.")
  @get
  @action("sites")
  @list
  listWebAppsByHybridConnection is HybridConnectionOps.ActionSync<
    HybridConnection,
    void,
    ArmResponse<ResourceCollection>,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  getHybridConnection is HybridConnectionOperationGroupOps.Read<
    HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  createOrUpdateHybridConnection is HybridConnectionOperationGroupOps.CreateOrUpdateSync<
    HybridConnection,
    Response = ArmResourceUpdatedResponse<HybridConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @patch(#{ implicitOptionality: false })
  updateHybridConnection is HybridConnectionOperationGroupOps.CustomPatchSync<
    HybridConnection,
    PatchModel = HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Removes a Hybrid Connection from this site.")
  deleteHybridConnection is HybridConnectionOperationGroupOps.DeleteSync<
    HybridConnection,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Retrieves a specific Service Bus Hybrid Connection used by this Web App.")
  getHybridConnectionSlot is HybridConnectionSlotOps.Read<
    HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  createOrUpdateHybridConnectionSlot is HybridConnectionSlotOps.CreateOrUpdateSync<
    HybridConnection,
    Response = ArmResourceUpdatedResponse<HybridConnection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new Hybrid Connection using a Service Bus relay.
   */
  @summary("Creates a new Hybrid Connection using a Service Bus relay.")
  @patch(#{ implicitOptionality: false })
  updateHybridConnectionSlot is HybridConnectionSlotOps.CustomPatchSync<
    HybridConnection,
    PatchModel = HybridConnection,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Removes a Hybrid Connection from this site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Removes a Hybrid Connection from this site.")
  deleteHybridConnectionSlot is HybridConnectionSlotOps.DeleteSync<
    HybridConnection,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
