import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProcessInfo.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Process Module Information.
 */
@parentResource(ProcessInfo)
model ProcessModuleInfo
  is Azure.ResourceManager.ProxyResource<ProcessModuleInfoProperties> {
  ...ResourceNameParameter<
    Resource = ProcessModuleInfo,
    KeyName = "baseAddress",
    SegmentName = "modules",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface ProcessModuleInfoOps
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

        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      },
      {
        /** Module base address. */
        @path
        @segment("modules")
        @key
        baseAddress: string,
      }
    > {}

@armResourceOperations
interface ProcessModuleInfos {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcessModule is ProcessModuleInfoOps.Read<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  listInstanceProcessModules is ProcessModuleInfoOps.List<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface ProcessModuleInfoOperationGroupOps
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

        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      },
      {
        /** Module base address. */
        @path
        @segment("modules")
        @key
        baseAddress: string,
      }
    > {}

@armResourceOperations
interface ProcessModuleInfoOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getProcessModule is ProcessModuleInfoOperationGroupOps.Read<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  listProcessModules is ProcessModuleInfoOperationGroupOps.List<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface InstanceProcessModuleSlotOperationGroupOps
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

        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      },
      {
        /** Module base address. */
        @path
        @segment("modules")
        @key
        baseAddress: string,
      }
    > {}

@armResourceOperations
interface InstanceProcessModuleSlotOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcessModuleSlot is InstanceProcessModuleSlotOperationGroupOps.Read<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  @segment("modules")
  listInstanceProcessModulesSlot is InstanceProcessModuleSlotOperationGroupOps.List<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface ProcessModuleSlotOperationGroupOps
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

        /** PID. */
        @path
        @segment("processes")
        @key
        processId: string,
      },
      {
        /** Module base address. */
        @path
        @segment("modules")
        @key
        baseAddress: string,
      }
    > {}

@armResourceOperations
interface ProcessModuleSlotOperationGroup {
  /**
   * Description for Get process information by its ID for a specific scaled-out instance in a web site.
   */
  @summary("Get process information by its ID for a specific scaled-out instance in a web site.")
  getProcessModuleSlot is ProcessModuleSlotOperationGroupOps.Read<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfo> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for List module information for a process by its ID for a specific scaled-out instance in a web site.
   */
  @summary("List module information for a process by its ID for a specific scaled-out instance in a web site.")
  listProcessModulesSlot is ProcessModuleSlotOperationGroupOps.List<
    ProcessModuleInfo,
    Response = ArmResponse<ProcessModuleInfoCollection> | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ProcessModuleInfo.name, "Module base address.");
@@doc(ProcessModuleInfo.properties,
  "ProcessModuleInfo resource specific properties"
);
