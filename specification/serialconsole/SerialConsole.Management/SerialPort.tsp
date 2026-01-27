import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SerialConsole;
/**
 * Represents the serial port of the parent resource.
 */
@summary("Serial port")
model SerialPort is Azure.ResourceManager.ProxyResource<SerialPortProperties> {
  ...ResourceNameParameter<
    Resource = SerialPort,
    KeyName = "serialPort",
    SegmentName = "serialPorts",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ParentResourceParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * The resource provider namespace of the parent resource.
   */
  @path
  @segment("providers")
  resourceProviderNamespace: string;

  /**
   * The resource type of the parent resource. For example: 'virtualMachines' or 'virtualMachineScaleSets'
   */
  @path(#{ allowReserved: true })
  parentResourceType: string;

  /**
   * The name of the parent resource.
   */
  @path
  parentResource: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SerialPorts {
  /**
   * Gets the configured settings for a serial port
   */
  get is ArmResourceRead<
    SerialPort,
    BaseParameters = ParentResourceParameters,
    Error = CloudError
  >;

  /**
   * Creates or updates a serial port
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceSync<
    SerialPort,
    BaseParameters = ParentResourceParameters,
    Response = ArmResourceCreatedSyncResponse<SerialPort>,
    Error = CloudError
  >;

  /**
   * Lists all of the configured serial ports for a parent resource
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    SerialPort,
    BaseParameters = ParentResourceParameters,
    Response = ArmResponse<SerialPortListResult>,
    Error = CloudError
  >;

  /**
   * Handles requests to list all SerialPort resources in a subscription.
   */
  listBySubscriptions is Azure.ResourceManager.Legacy.ArmListSinglePageBySubscription<
    SerialPort,
    Response = ArmResponse<SerialPortListResult>,
    Error = CloudError
  >;

  /**
   * Connect to serial port of the target resource
   */
  connect is ArmResourceActionSync<
    SerialPort,
    void,
    ArmResponse<SerialPortConnectResult>,
    BaseParameters = ParentResourceParameters,
    Error = CloudError
  >;
}

@@doc(SerialPort.name, "The name of the serial port to connect to.");
@@doc(SerialPort.properties, "The properties of the serial port.");
@@doc(SerialPorts.create::parameters.resource,
  "Parameters supplied to create the serial port."
);
