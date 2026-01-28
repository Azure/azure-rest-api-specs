import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebSiteInstanceStatus.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Process Information.
 */
@parentResource(WebSiteInstanceStatus)
model ProcessInfo
  is Azure.ResourceManager.ProxyResource<ProcessInfoProperties> {
  ...ResourceNameParameter<
    Resource = ProcessInfo,
    KeyName = "processId",
    SegmentName = "processes",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface ProcessInfoOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances". */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfos {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcess is ProcessInfoOps.Read<
    ProcessInfo,
    Response = ArmResponse<ProcessInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  deleteInstanceProcess is ProcessInfoOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  listInstanceProcesses is ProcessInfoOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @action("dump")
  getInstanceProcessDump is ProcessInfoOps.ActionSync<
    ProcessInfo,
    void,
    {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @list
  @action("threads")
  listInstanceProcessThreads is ProcessInfoOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface ProcessInfoOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessInfoOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getProcess is ProcessInfoOperationGroupOps.Read<
    ProcessInfo,
    Response = ArmResponse<ProcessInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  deleteProcess is ProcessInfoOperationGroupOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  listProcesses is ProcessInfoOperationGroupOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @action("dump")
  getProcessDump is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @action("threads")
  @list
  listProcessThreads is ProcessInfoOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface InstanceProcessSlotOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,

        /** ID of a specific scaled-out instance. This is the value of the name property in the JSON response from "GET api/sites/{siteName}/instances". */
        @path
        @segment("instances")
        @key
        instanceId: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface InstanceProcessSlotOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcessSlot is InstanceProcessSlotOps.Read<
    ProcessInfo,
    Response = ArmResponse<ProcessInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  deleteInstanceProcessSlot is InstanceProcessSlotOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  @segment("processes")
  listInstanceProcessesSlot is InstanceProcessSlotOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @action("dump")
  getInstanceProcessDumpSlot is InstanceProcessSlotOps.ActionSync<
    ProcessInfo,
    void,
    {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @list
  @action("threads")
  listInstanceProcessThreadsSlot is InstanceProcessSlotOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface ProcessSlotOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Site name. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API returns deployments for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      }
    > {}

@armResourceOperations
interface ProcessSlotOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getProcessSlot is ProcessSlotOperationGroupOps.Read<
    ProcessInfo,
    Response = ArmResponse<ProcessInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  deleteProcessSlot is ProcessSlotOperationGroupOps.DeleteSync<
    ProcessInfo,
    Response = ArmDeletedNoContentResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.
   */
  @summary("Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  listProcessesSlot is ProcessSlotOperationGroupOps.List<
    ProcessInfo,
    Response = ArmResponse<ProcessInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @action("dump")
  getProcessDumpSlot is ProcessSlotOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    {
      @header("Content-Type")
      contentType: "*/*";

      @doc("Receipt body in COSE format")
      @bodyRoot
      body: bytes;
    } | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @get
  @list
  @action("threads")
  listProcessThreadsSlot is ProcessSlotOperationGroupOps.ActionSync<
    ProcessInfo,
    void,
    ArmResponse<ProcessThreadInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ProcessInfo.name, "PID.");
@@doc(ProcessInfo.properties, "ProcessInfo resource specific properties");
