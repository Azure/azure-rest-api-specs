import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Microsoft.Workloads;

/**
 * Defines the environment type - Production/Non Production.
 */
enum EpicEnvironmentType {
  /**
   * Environment is designated for non-production use.
   */
  NonProduction,

  /**
   * Environment is designated for production use.
   */
  Production,
}

/**
 * The configuration Type.
 */
enum EpicConfigurationType {
  /**
   * Configuration for registration.
   */
  Registration,
}

/**
 * Defines the Epic Instance status.
 */
enum EpicVirtualInstanceStatus {
  /**
   * Instance is currently running.
   */
  Running,

  /**
   * Instance is offline.
   */
  Offline,

  /**
   * Instance is unavailable.
   */
  Unavailable,
}

/**
 * Defines the health of Epic Instances.
 */
enum EpicHealthState {
  /**
   * Health state is available.
   */
  Available,

  /**
   * Instance is unavailable.
   */
  Unavailable,

  /**
   * Instance is unknown.
   */
  Unknown,

  /**
   * Instance health is degraded.
   */
  Degraded,
}

/**
 * Defines the Virtual Instance for Epic state.
 */
enum EpicVirtualInstanceState {
  /**
   * Registration of the instance is in progress.
   */
  RegistrationInProgress,

  /**
   * Registration of the instance has failed.
   */
  RegistrationFailed,

  /**
   * Registration of the instance is complete.
   */
  RegistrationComplete,
}

/**
 * Defines the provisioning states.
 */
enum EpicVirtualInstanceProvisioningState {
  /**
   * Provisioning has succeeded.
   */
  Succeeded,

  /**
   * Provisioning is updating.
   */
  Updating,

  /**
   * Provisioning is creating resources.
   */
  Creating,

  /**
   * Provisioning has failed.
   */
  Failed,

  /**
   * Provisioning is deleting resources.
   */
  Deleting,

  /**
   * Provisioning has been canceled.
   */
  Canceled,
}

/**
 * The role of the Wss VM.
 */
enum WssRole {
  /**
   * Role for WSS InterConnect.
   */
  WSSInterConnect,

  /**
   * Role for WBS.
   */
  WBS,

  /**
   * Role for EPS.
   */
  EPS,

  /**
   * Role for MyChart.
   */
  MyChart,

  /**
   * Role for BCA.
   */
  BCA,
}

/**
 * The role of the database VM.
 */
enum DatabaseVmRole {
  /**
   * Role for ODB.
   */
  ODB,

  /**
   * Role for ECP.
   */
  ECP,

  /**
   * Role for EMFI.
   */
  EMFI,

  /**
   * Role for Reporting.
   */
  Reporting,

  /**
   * Role for Clarity.
   */
  Clarity,

  /**
   * Role for Caboodle.
   */
  Caboodle,
}

/**
 * The role of the Presentation VM.
 */
enum PresentationRole {
  /**
   * Role for Hyperspace VDI.
   */
  `Hyperspace VDI`,

  /**
   * Role for Hyperdrive VDI.
   */
  `Hyperdrive VDI`,

  /**
   * Role for BCA Web.
   */
  `BCA Web`,
}

/**
 * The role of the Shared VM.
 */
enum SharedRole {
  /**
   * Role for Kuiper.
   */
  Kuiper,

  /**
   * Role for System Pulse.
   */
  `System Pulse`,

  /**
   * Role for MPSQL.
   */
  MPSQL,
}

/**
 * The role of the Hyperspace Web VM.
 */
enum HyperspaceWebRole {
  /**
   * Role for Hyperspace Web.
   */
  HyperSpaceWeb,
}

/**
 * Defines the Virtual Instance for Epic solutions resource properties.
 */
model EpicVirtualInstanceProperties {
  /**
   * Defines the environment type - Production/Non Production.
   */
  @visibility("read", "create")
  environment: EpicEnvironmentType;

  /**
   * Defines if the Epic system is being created using Azure Center for Epic solutions (ACSS) or if an existing Epic system is being registered with ACSS
   */
  configuration: EpicConfiguration;

  /**
   * Managed resource group configuration
   */
  managedResourceGroupConfiguration?: ManagedRgConfiguration;

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the Virtual Instance for Epic state.
   */
  @visibility("read")
  state?: EpicVirtualInstanceState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Indicates any errors on the Virtual Instance for Epic solutions resource.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * The Epic Configuration.
 */
@discriminator("configurationType")
model EpicConfiguration {}

/**
 * Managed resource group configuration
 */
model ManagedRgConfiguration {
  /**
   * Managed resource group name
   */
  name?: string;
}

/**
 * An error response from the Virtual Instance for Epic Workload service.
 */
model EpicVirtualInstanceError {
  /**
   * The Virtual Instance for Epic error body.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: ErrorDefinition[];
}

/**
 * Defines the Epic Wss Services Instance properties.
 */
model WssServerProperties {
  /**
   * The list of virtual machines corresponding to the Wss Services instance.
   */
  @visibility("read")
  vmDetails?: WssServerVmDetails[];

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Defines the errors related to Epic WSS server Instance resource.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * The Epic Wss Services Instance VM details.
 */
model WssServerVmDetails {
  /**
   * The unique identifier of the virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * The role of the Wss VM.
   */
  @visibility("read")
  role?: WssRole;
}

/**
 * Defines the Database properties.
 */
model DatabaseServerProperties {
  /**
   * The list of virtual machines corresponding to the Database resource.
   */
  @visibility("read")
  vmDetails?: DatabaseServerVmDetails[];

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Defines the errors related to Database resource.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * Database VM details.
 */
model DatabaseServerVmDetails {
  /**
   * The unique identifier of the virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * The role of the database VM.
   */
  @visibility("read")
  role?: DatabaseVmRole;
}

/**
 * Defines the Epic HyperspaceWeb Server instance properties.
 */
model HyperspaceWebServerProperties {
  /**
   * The list of virtual machines.
   */
  @visibility("read")
  vmDetails?: HyperspaceWebServerVmDetails[];

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Defines the HyperspaceWeb Instance errors.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * The HyperspaceWeb Server VM Details.
 */
model HyperspaceWebServerVmDetails {
  /**
   * The unique identifier of the virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * The role of the Wss VM.
   */
  @visibility("read")
  role?: WssRole;
}

/**
 * Defines the Epic Presentation Server instance properties.
 */
model PresentationServerProperties {
  /**
   * The list of virtual machines.
   */
  @visibility("read")
  vmDetails?: PresentationServerVmDetails[];

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Defines the Presentation Instance errors.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * The Epic Presentation Services Instance VM details.
 */
model PresentationServerVmDetails {
  /**
   * The unique identifier of the virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * The role of the Presentation VM.
   */
  @visibility("read")
  role?: PresentationRole;
}

/**
 * Defines the Epic Shared Server instance properties.
 */
model SharedServerProperties {
  /**
   * The list of virtual machines.
   */
  @visibility("read")
  vmDetails?: SharedServerVmDetails[];

  /**
   * Defines the Epic Instance status.
   */
  @visibility("read")
  status?: EpicVirtualInstanceStatus;

  /**
   * Defines the health of Epic Instances.
   */
  @visibility("read")
  health?: EpicHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: EpicVirtualInstanceProvisioningState;

  /**
   * Defines the Shared Instance errors.
   */
  @visibility("read")
  errors?: EpicVirtualInstanceError;
}

/**
 * The Epic Shared Services Instance VM details.
 */
model SharedServerVmDetails {
  /**
   * The unique identifier of the virtual machine.
   */
  @visibility("read")
  virtualMachineId?: string;

  /**
   * The role of the Shared VM.
   */
  @visibility("read")
  role?: SharedRole;
}

/**
 * Defines the registration configuration details, extending from the base EpicConfiguration.
 */
model RegistrationConfiguration extends EpicConfiguration {
  /**
   * Registration details for WSS servers, including VM identifiers and roles.
   */
  wssServerInstance?: {
    vmDetails: WssServerDetails[];
  };

  /**
   * Registration details for Database servers, including VM identifiers and roles.
   */
  databaseServerInstance?: {
    vmDetails: DatabaseServerDetails[];
  };

  /**
   * Registration details for HyperspaceWeb servers, including VM identifiers and roles.
   */
  hyperspaceWebServerInstance?: {
    vmDetails: HyperspaceWebServerDetails[];
  };

  /**
   * Registration details for Presentation servers, including VM identifiers and roles.
   */
  presentationServerInstance?: {
    vmDetails: PresentationServerDetails[];
  };

  /**
   * Registration details for Shared servers, including VM identifiers and roles.
   */
  sharedServerInstance?: {
    vmDetails: SharedServerDetails[];
  };

  /**
   * Specifies the type of configuration, explicitly marked as "Registration" to denote its purpose in system setup.
   */
  configurationType: "Registration";
}

/**
 * Represents the registration details of a VM designated for WSS operations.
 */
model WssServerDetails {
  /**
   * The unique identifier for the virtual machine, crucial for tracking and management within the registration framework.
   */
  id: string;

  /**
   * Specifies the role that this VM fulfills within the WSS registration setup, aiding in role-based configuration.
   */
  role?: WssRole;
}

/**
 * Describes the registration details of a Database Server VM, including its identifier and role.
 */
model DatabaseServerDetails {
  /**
   * The unique identifier of the virtual machine, essential for identification and configuration in the registration process.
   */
  id: string;

  /**
   * The role of the VM within the database server's registration framework, indicating its specific function.
   */
  role?: DatabaseVmRole;
}

/**
 * Contains the registration details for HyperspaceWeb Server VMs, including IDs and roles.
 */
model HyperspaceWebServerDetails {
  /**
   * The unique identifier of the virtual machine, key for its identification and setup in the registration schema.
   */
  id: string;

  /**
   * The role of the VM in the HyperspaceWeb server's registration architecture, defining its responsibilities.
   */
  role?: HyperspaceWebRole;
}

/**
 * Defines the registration details for Presentation Server VMs, including their identifiers and roles.
 */
model PresentationServerDetails {
  /**
   * The unique identifier of the virtual machine, vital for its configuration and management in the registration context.
   */
  id: string;

  /**
   * The role of the VM within the presentation server registration process, clarifying its operational purpose.
   */
  role?: PresentationRole;
}

/**
 * Outlines the registration details for Shared Server VMs, detailing their IDs and roles.
 */
model SharedServerDetails {
  /**
   * The unique identifier of the virtual machine, important for tracking and setup during registration.
   */
  id: string;

  /**
   * The role of the VM in the shared server's registration setup, specifying its function and usage.
   */
  role?: SharedRole;
}
