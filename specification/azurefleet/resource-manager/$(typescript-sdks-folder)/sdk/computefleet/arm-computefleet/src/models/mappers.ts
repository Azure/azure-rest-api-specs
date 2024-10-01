import * as coreClient from "@azure/core-client";

export const OperationListResult: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OperationListResult",
    modelProperties: {
      value: {
        serializedName: "value",
        readOnly: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "Operation",
            },
          },
        },
      },
      nextLink: {
        serializedName: "nextLink",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const Operation: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "Operation",
    modelProperties: {
      name: {
        serializedName: "name",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      isDataAction: {
        serializedName: "isDataAction",
        readOnly: true,
        type: {
          name: "Boolean",
        },
      },
      display: {
        serializedName: "display",
        type: {
          name: "Composite",
          className: "OperationDisplay",
        },
      },
      origin: {
        serializedName: "origin",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      actionType: {
        serializedName: "actionType",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const OperationDisplay: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OperationDisplay",
    modelProperties: {
      provider: {
        serializedName: "provider",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      resource: {
        serializedName: "resource",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      operation: {
        serializedName: "operation",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      description: {
        serializedName: "description",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const ErrorResponse: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ErrorResponse",
    modelProperties: {
      error: {
        serializedName: "error",
        type: {
          name: "Composite",
          className: "ErrorDetail",
        },
      },
    },
  },
};

export const ErrorDetail: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ErrorDetail",
    modelProperties: {
      code: {
        serializedName: "code",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      message: {
        serializedName: "message",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      target: {
        serializedName: "target",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      details: {
        serializedName: "details",
        readOnly: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ErrorDetail",
            },
          },
        },
      },
      additionalInfo: {
        serializedName: "additionalInfo",
        readOnly: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ErrorAdditionalInfo",
            },
          },
        },
      },
    },
  },
};

export const ErrorAdditionalInfo: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ErrorAdditionalInfo",
    modelProperties: {
      type: {
        serializedName: "type",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      info: {
        serializedName: "info",
        readOnly: true,
        type: {
          name: "Dictionary",
          value: { type: { name: "any" } },
        },
      },
    },
  },
};

export const FleetListResult: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetListResult",
    modelProperties: {
      value: {
        serializedName: "value",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "Fleet",
            },
          },
        },
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const FleetProperties: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetProperties",
    modelProperties: {
      provisioningState: {
        serializedName: "provisioningState",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      spotPriorityProfile: {
        serializedName: "spotPriorityProfile",
        type: {
          name: "Composite",
          className: "SpotPriorityProfile",
        },
      },
      regularPriorityProfile: {
        serializedName: "regularPriorityProfile",
        type: {
          name: "Composite",
          className: "RegularPriorityProfile",
        },
      },
      vmSizesProfile: {
        serializedName: "vmSizesProfile",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VmSizeProfile",
            },
          },
        },
      },
      vmAttributes: {
        serializedName: "vmAttributes",
        type: {
          name: "Composite",
          className: "VMAttributes",
        },
      },
      additionalLocationsProfile: {
        serializedName: "additionalLocationsProfile",
        type: {
          name: "Composite",
          className: "AdditionalLocationsProfile",
        },
      },
      computeProfile: {
        serializedName: "computeProfile",
        type: {
          name: "Composite",
          className: "ComputeProfile",
        },
      },
      timeCreated: {
        serializedName: "timeCreated",
        readOnly: true,
        type: {
          name: "DateTime",
        },
      },
      uniqueId: {
        serializedName: "uniqueId",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const SpotPriorityProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SpotPriorityProfile",
    modelProperties: {
      capacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "capacity",
        type: {
          name: "Number",
        },
      },
      minCapacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "minCapacity",
        type: {
          name: "Number",
        },
      },
      maxPricePerVM: {
        serializedName: "maxPricePerVM",
        type: {
          name: "Number",
        },
      },
      evictionPolicy: {
        serializedName: "evictionPolicy",
        type: {
          name: "String",
        },
      },
      allocationStrategy: {
        serializedName: "allocationStrategy",
        type: {
          name: "String",
        },
      },
      maintain: {
        serializedName: "maintain",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const RegularPriorityProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "RegularPriorityProfile",
    modelProperties: {
      capacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "capacity",
        type: {
          name: "Number",
        },
      },
      minCapacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "minCapacity",
        type: {
          name: "Number",
        },
      },
      allocationStrategy: {
        serializedName: "allocationStrategy",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VmSizeProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VmSizeProfile",
    modelProperties: {
      name: {
        serializedName: "name",
        required: true,
        type: {
          name: "String",
        },
      },
      rank: {
        constraints: {
          InclusiveMaximum: 65535,
          InclusiveMinimum: 0,
        },
        serializedName: "rank",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const VMAttributes: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMAttributes",
    modelProperties: {
      vCpuCount: {
        serializedName: "vCpuCount",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      memoryInMiB: {
        serializedName: "memoryInMiB",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      localStorageSupport: {
        serializedName: "localStorageSupport",
        type: {
          name: "String",
        },
      },
      localStorageDiskType: {
        serializedName: "localStorageDiskType",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      localStorageInGB: {
        serializedName: "localStorageInGB",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      localStorageDiskTypes: {
        serializedName: "localStorageDiskTypes",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      dataDiskCount: {
        serializedName: "dataDiskCount",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      networkInterfaceCount: {
        serializedName: "networkInterfaceCount",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      networkBandwidthInMbps: {
        serializedName: "networkBandwidthInMbps",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      rdmaSupport: {
        serializedName: "rdmaSupport",
        type: {
          name: "String",
        },
      },
      rdmaNetworkInterfaceCount: {
        serializedName: "rdmaNetworkInterfaceCount",
        type: {
          name: "Composite",
          className: "VMAttributeMinMax",
        },
      },
      gpuSupport: {
        serializedName: "gpuSupport",
        type: {
          name: "String",
        },
      },
      gpuManufacturers: {
        serializedName: "gpuManufacturers",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      vmCategories: {
        serializedName: "vmCategories",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      architectureTypes: {
        serializedName: "architectureTypes",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      cpuManufacturers: {
        serializedName: "cpuManufacturers",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      burstableSupport: {
        serializedName: "burstableSupport",
        type: {
          name: "String",
        },
      },
      excludedVMSizes: {
        serializedName: "excludedVMSizes",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
    },
  },
};

export const VMAttributeMinMax: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMAttributeMinMax",
    modelProperties: {
      min: {
        serializedName: "min",
        type: {
          name: "Number",
        },
      },
      max: {
        serializedName: "max",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const AdditionalLocationsProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AdditionalLocationsProfile",
    modelProperties: {
      locationProfiles: {
        serializedName: "locationProfiles",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "LocationProfile",
            },
          },
        },
      },
    },
  },
};

export const LocationProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LocationProfile",
    modelProperties: {
      location: {
        serializedName: "location",
        required: true,
        type: {
          name: "String",
        },
      },
      virtualMachineProfileOverride: {
        serializedName: "virtualMachineProfileOverride",
        type: {
          name: "Composite",
          className: "BaseVirtualMachineProfile",
        },
      },
    },
  },
};

export const BaseVirtualMachineProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "BaseVirtualMachineProfile",
    modelProperties: {
      osProfile: {
        serializedName: "osProfile",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetOSProfile",
        },
      },
      storageProfile: {
        serializedName: "storageProfile",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetStorageProfile",
        },
      },
      networkProfile: {
        serializedName: "networkProfile",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetNetworkProfile",
        },
      },
      securityProfile: {
        serializedName: "securityProfile",
        type: {
          name: "Composite",
          className: "SecurityProfile",
        },
      },
      diagnosticsProfile: {
        serializedName: "diagnosticsProfile",
        type: {
          name: "Composite",
          className: "DiagnosticsProfile",
        },
      },
      extensionProfile: {
        serializedName: "extensionProfile",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetExtensionProfile",
        },
      },
      licenseType: {
        serializedName: "licenseType",
        type: {
          name: "String",
        },
      },
      scheduledEventsProfile: {
        serializedName: "scheduledEventsProfile",
        type: {
          name: "Composite",
          className: "ScheduledEventsProfile",
        },
      },
      userData: {
        serializedName: "userData",
        type: {
          name: "String",
        },
      },
      capacityReservation: {
        serializedName: "capacityReservation",
        type: {
          name: "Composite",
          className: "CapacityReservationProfile",
        },
      },
      applicationProfile: {
        serializedName: "applicationProfile",
        type: {
          name: "Composite",
          className: "ApplicationProfile",
        },
      },
      hardwareProfile: {
        serializedName: "hardwareProfile",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetHardwareProfile",
        },
      },
      serviceArtifactReference: {
        serializedName: "serviceArtifactReference",
        type: {
          name: "Composite",
          className: "ServiceArtifactReference",
        },
      },
      securityPostureReference: {
        serializedName: "securityPostureReference",
        type: {
          name: "Composite",
          className: "SecurityPostureReference",
        },
      },
      timeCreated: {
        serializedName: "timeCreated",
        readOnly: true,
        type: {
          name: "DateTime",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetOSProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetOSProfile",
    modelProperties: {
      computerNamePrefix: {
        serializedName: "computerNamePrefix",
        type: {
          name: "String",
        },
      },
      adminUsername: {
        serializedName: "adminUsername",
        type: {
          name: "String",
        },
      },
      adminPassword: {
        serializedName: "adminPassword",
        type: {
          name: "String",
        },
      },
      customData: {
        serializedName: "customData",
        type: {
          name: "String",
        },
      },
      windowsConfiguration: {
        serializedName: "windowsConfiguration",
        type: {
          name: "Composite",
          className: "WindowsConfiguration",
        },
      },
      linuxConfiguration: {
        serializedName: "linuxConfiguration",
        type: {
          name: "Composite",
          className: "LinuxConfiguration",
        },
      },
      secrets: {
        serializedName: "secrets",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VaultSecretGroup",
            },
          },
        },
      },
      allowExtensionOperations: {
        serializedName: "allowExtensionOperations",
        type: {
          name: "Boolean",
        },
      },
      requireGuestProvisionSignal: {
        serializedName: "requireGuestProvisionSignal",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const WindowsConfiguration: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "WindowsConfiguration",
    modelProperties: {
      provisionVMAgent: {
        serializedName: "provisionVMAgent",
        type: {
          name: "Boolean",
        },
      },
      enableAutomaticUpdates: {
        serializedName: "enableAutomaticUpdates",
        type: {
          name: "Boolean",
        },
      },
      timeZone: {
        serializedName: "timeZone",
        type: {
          name: "String",
        },
      },
      additionalUnattendContent: {
        serializedName: "additionalUnattendContent",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "AdditionalUnattendContent",
            },
          },
        },
      },
      patchSettings: {
        serializedName: "patchSettings",
        type: {
          name: "Composite",
          className: "PatchSettings",
        },
      },
      winRM: {
        serializedName: "winRM",
        type: {
          name: "Composite",
          className: "WinRMConfiguration",
        },
      },
      enableVMAgentPlatformUpdates: {
        serializedName: "enableVMAgentPlatformUpdates",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const AdditionalUnattendContent: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AdditionalUnattendContent",
    modelProperties: {
      passName: {
        defaultValue: "OobeSystem",
        isConstant: true,
        serializedName: "passName",
        type: {
          name: "String",
        },
      },
      componentName: {
        defaultValue: "Microsoft-Windows-Shell-Setup",
        isConstant: true,
        serializedName: "componentName",
        type: {
          name: "String",
        },
      },
      settingName: {
        serializedName: "settingName",
        type: {
          name: "String",
        },
      },
      content: {
        serializedName: "content",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const PatchSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PatchSettings",
    modelProperties: {
      patchMode: {
        serializedName: "patchMode",
        type: {
          name: "String",
        },
      },
      enableHotpatching: {
        serializedName: "enableHotpatching",
        type: {
          name: "Boolean",
        },
      },
      assessmentMode: {
        serializedName: "assessmentMode",
        type: {
          name: "String",
        },
      },
      automaticByPlatformSettings: {
        serializedName: "automaticByPlatformSettings",
        type: {
          name: "Composite",
          className: "WindowsVMGuestPatchAutomaticByPlatformSettings",
        },
      },
    },
  },
};

export const WindowsVMGuestPatchAutomaticByPlatformSettings: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "WindowsVMGuestPatchAutomaticByPlatformSettings",
      modelProperties: {
        rebootSetting: {
          serializedName: "rebootSetting",
          type: {
            name: "String",
          },
        },
        bypassPlatformSafetyChecksOnUserSchedule: {
          serializedName: "bypassPlatformSafetyChecksOnUserSchedule",
          type: {
            name: "Boolean",
          },
        },
      },
    },
  };

export const WinRMConfiguration: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "WinRMConfiguration",
    modelProperties: {
      listeners: {
        serializedName: "listeners",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "WinRMListener",
            },
          },
        },
      },
    },
  },
};

export const WinRMListener: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "WinRMListener",
    modelProperties: {
      protocol: {
        serializedName: "protocol",
        type: {
          name: "String",
        },
      },
      certificateUrl: {
        serializedName: "certificateUrl",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const LinuxConfiguration: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LinuxConfiguration",
    modelProperties: {
      disablePasswordAuthentication: {
        serializedName: "disablePasswordAuthentication",
        type: {
          name: "Boolean",
        },
      },
      ssh: {
        serializedName: "ssh",
        type: {
          name: "Composite",
          className: "SshConfiguration",
        },
      },
      provisionVMAgent: {
        serializedName: "provisionVMAgent",
        type: {
          name: "Boolean",
        },
      },
      patchSettings: {
        serializedName: "patchSettings",
        type: {
          name: "Composite",
          className: "LinuxPatchSettings",
        },
      },
      enableVMAgentPlatformUpdates: {
        serializedName: "enableVMAgentPlatformUpdates",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const SshConfiguration: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SshConfiguration",
    modelProperties: {
      publicKeys: {
        serializedName: "publicKeys",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "SshPublicKey",
            },
          },
        },
      },
    },
  },
};

export const SshPublicKey: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SshPublicKey",
    modelProperties: {
      path: {
        serializedName: "path",
        type: {
          name: "String",
        },
      },
      keyData: {
        serializedName: "keyData",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const LinuxPatchSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "LinuxPatchSettings",
    modelProperties: {
      patchMode: {
        serializedName: "patchMode",
        type: {
          name: "String",
        },
      },
      assessmentMode: {
        serializedName: "assessmentMode",
        type: {
          name: "String",
        },
      },
      automaticByPlatformSettings: {
        serializedName: "automaticByPlatformSettings",
        type: {
          name: "Composite",
          className: "LinuxVMGuestPatchAutomaticByPlatformSettings",
        },
      },
    },
  },
};

export const LinuxVMGuestPatchAutomaticByPlatformSettings: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "LinuxVMGuestPatchAutomaticByPlatformSettings",
      modelProperties: {
        rebootSetting: {
          serializedName: "rebootSetting",
          type: {
            name: "String",
          },
        },
        bypassPlatformSafetyChecksOnUserSchedule: {
          serializedName: "bypassPlatformSafetyChecksOnUserSchedule",
          type: {
            name: "Boolean",
          },
        },
      },
    },
  };

export const VaultSecretGroup: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VaultSecretGroup",
    modelProperties: {
      sourceVault: {
        serializedName: "sourceVault",
        type: {
          name: "Composite",
          className: "SubResource",
        },
      },
      vaultCertificates: {
        serializedName: "vaultCertificates",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VaultCertificate",
            },
          },
        },
      },
    },
  },
};

export const SubResource: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SubResource",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VaultCertificate: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VaultCertificate",
    modelProperties: {
      certificateUrl: {
        serializedName: "certificateUrl",
        type: {
          name: "String",
        },
      },
      certificateStore: {
        serializedName: "certificateStore",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetStorageProfile: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetStorageProfile",
      modelProperties: {
        imageReference: {
          serializedName: "imageReference",
          type: {
            name: "Composite",
            className: "ImageReference",
          },
        },
        osDisk: {
          serializedName: "osDisk",
          type: {
            name: "Composite",
            className: "VirtualMachineScaleSetOSDisk",
          },
        },
        dataDisks: {
          serializedName: "dataDisks",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "VirtualMachineScaleSetDataDisk",
              },
            },
          },
        },
        diskControllerType: {
          serializedName: "diskControllerType",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const ImageReference: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ImageReference",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
      publisher: {
        serializedName: "publisher",
        type: {
          name: "String",
        },
      },
      offer: {
        serializedName: "offer",
        type: {
          name: "String",
        },
      },
      sku: {
        serializedName: "sku",
        type: {
          name: "String",
        },
      },
      version: {
        serializedName: "version",
        type: {
          name: "String",
        },
      },
      exactVersion: {
        serializedName: "exactVersion",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      sharedGalleryImageId: {
        serializedName: "sharedGalleryImageId",
        type: {
          name: "String",
        },
      },
      communityGalleryImageId: {
        serializedName: "communityGalleryImageId",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetOSDisk: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetOSDisk",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String",
        },
      },
      caching: {
        serializedName: "caching",
        type: {
          name: "String",
        },
      },
      writeAcceleratorEnabled: {
        serializedName: "writeAcceleratorEnabled",
        type: {
          name: "Boolean",
        },
      },
      createOption: {
        serializedName: "createOption",
        required: true,
        type: {
          name: "String",
        },
      },
      diffDiskSettings: {
        serializedName: "diffDiskSettings",
        type: {
          name: "Composite",
          className: "DiffDiskSettings",
        },
      },
      diskSizeGB: {
        serializedName: "diskSizeGB",
        type: {
          name: "Number",
        },
      },
      osType: {
        serializedName: "osType",
        type: {
          name: "String",
        },
      },
      image: {
        serializedName: "image",
        type: {
          name: "Composite",
          className: "VirtualHardDisk",
        },
      },
      vhdContainers: {
        serializedName: "vhdContainers",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      managedDisk: {
        serializedName: "managedDisk",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetManagedDiskParameters",
        },
      },
      deleteOption: {
        serializedName: "deleteOption",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const DiffDiskSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "DiffDiskSettings",
    modelProperties: {
      option: {
        serializedName: "option",
        type: {
          name: "String",
        },
      },
      placement: {
        serializedName: "placement",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualHardDisk: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualHardDisk",
    modelProperties: {
      uri: {
        serializedName: "uri",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetManagedDiskParameters: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetManagedDiskParameters",
      modelProperties: {
        storageAccountType: {
          serializedName: "storageAccountType",
          type: {
            name: "String",
          },
        },
        diskEncryptionSet: {
          serializedName: "diskEncryptionSet",
          type: {
            name: "Composite",
            className: "DiskEncryptionSetParameters",
          },
        },
        securityProfile: {
          serializedName: "securityProfile",
          type: {
            name: "Composite",
            className: "VMDiskSecurityProfile",
          },
        },
      },
    },
  };

export const DiskEncryptionSetParameters: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "DiskEncryptionSetParameters",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VMDiskSecurityProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMDiskSecurityProfile",
    modelProperties: {
      securityEncryptionType: {
        serializedName: "securityEncryptionType",
        type: {
          name: "String",
        },
      },
      diskEncryptionSet: {
        serializedName: "diskEncryptionSet",
        type: {
          name: "Composite",
          className: "DiskEncryptionSetParameters",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetDataDisk: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetDataDisk",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String",
        },
      },
      lun: {
        serializedName: "lun",
        required: true,
        type: {
          name: "Number",
        },
      },
      caching: {
        serializedName: "caching",
        type: {
          name: "String",
        },
      },
      writeAcceleratorEnabled: {
        serializedName: "writeAcceleratorEnabled",
        type: {
          name: "Boolean",
        },
      },
      createOption: {
        serializedName: "createOption",
        required: true,
        type: {
          name: "String",
        },
      },
      diskSizeGB: {
        serializedName: "diskSizeGB",
        type: {
          name: "Number",
        },
      },
      managedDisk: {
        serializedName: "managedDisk",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetManagedDiskParameters",
        },
      },
      diskIopsReadWrite: {
        serializedName: "diskIOPSReadWrite",
        type: {
          name: "Number",
        },
      },
      diskMBpsReadWrite: {
        serializedName: "diskMBpsReadWrite",
        type: {
          name: "Number",
        },
      },
      deleteOption: {
        serializedName: "deleteOption",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetNetworkProfile: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetNetworkProfile",
      modelProperties: {
        healthProbe: {
          serializedName: "healthProbe",
          type: {
            name: "Composite",
            className: "ApiEntityReference",
          },
        },
        networkInterfaceConfigurations: {
          serializedName: "networkInterfaceConfigurations",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "VirtualMachineScaleSetNetworkConfiguration",
              },
            },
          },
        },
        networkApiVersion: {
          serializedName: "networkApiVersion",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const ApiEntityReference: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApiEntityReference",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetNetworkConfiguration: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetNetworkConfiguration",
      modelProperties: {
        name: {
          serializedName: "name",
          required: true,
          type: {
            name: "String",
          },
        },
        properties: {
          serializedName: "properties",
          type: {
            name: "Composite",
            className: "VirtualMachineScaleSetNetworkConfigurationProperties",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetNetworkConfigurationProperties: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetNetworkConfigurationProperties",
      modelProperties: {
        primary: {
          serializedName: "primary",
          type: {
            name: "Boolean",
          },
        },
        enableAcceleratedNetworking: {
          serializedName: "enableAcceleratedNetworking",
          type: {
            name: "Boolean",
          },
        },
        disableTcpStateTracking: {
          serializedName: "disableTcpStateTracking",
          type: {
            name: "Boolean",
          },
        },
        enableFpga: {
          serializedName: "enableFpga",
          type: {
            name: "Boolean",
          },
        },
        networkSecurityGroup: {
          serializedName: "networkSecurityGroup",
          type: {
            name: "Composite",
            className: "SubResource",
          },
        },
        dnsSettings: {
          serializedName: "dnsSettings",
          type: {
            name: "Composite",
            className: "VirtualMachineScaleSetNetworkConfigurationDnsSettings",
          },
        },
        ipConfigurations: {
          serializedName: "ipConfigurations",
          required: true,
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "VirtualMachineScaleSetIPConfiguration",
              },
            },
          },
        },
        enableIPForwarding: {
          serializedName: "enableIPForwarding",
          type: {
            name: "Boolean",
          },
        },
        deleteOption: {
          serializedName: "deleteOption",
          type: {
            name: "String",
          },
        },
        auxiliaryMode: {
          serializedName: "auxiliaryMode",
          type: {
            name: "String",
          },
        },
        auxiliarySku: {
          serializedName: "auxiliarySku",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetNetworkConfigurationDnsSettings: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetNetworkConfigurationDnsSettings",
      modelProperties: {
        dnsServers: {
          serializedName: "dnsServers",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "String",
              },
            },
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetIPConfiguration: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetIPConfiguration",
      modelProperties: {
        name: {
          serializedName: "name",
          required: true,
          type: {
            name: "String",
          },
        },
        properties: {
          serializedName: "properties",
          type: {
            name: "Composite",
            className: "VirtualMachineScaleSetIPConfigurationProperties",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetIPConfigurationProperties: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetIPConfigurationProperties",
      modelProperties: {
        subnet: {
          serializedName: "subnet",
          type: {
            name: "Composite",
            className: "ApiEntityReference",
          },
        },
        primary: {
          serializedName: "primary",
          type: {
            name: "Boolean",
          },
        },
        publicIPAddressConfiguration: {
          serializedName: "publicIPAddressConfiguration",
          type: {
            name: "Composite",
            className: "VirtualMachineScaleSetPublicIPAddressConfiguration",
          },
        },
        privateIPAddressVersion: {
          serializedName: "privateIPAddressVersion",
          type: {
            name: "String",
          },
        },
        applicationGatewayBackendAddressPools: {
          serializedName: "applicationGatewayBackendAddressPools",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "SubResource",
              },
            },
          },
        },
        applicationSecurityGroups: {
          serializedName: "applicationSecurityGroups",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "SubResource",
              },
            },
          },
        },
        loadBalancerBackendAddressPools: {
          serializedName: "loadBalancerBackendAddressPools",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "SubResource",
              },
            },
          },
        },
        loadBalancerInboundNatPools: {
          serializedName: "loadBalancerInboundNatPools",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "SubResource",
              },
            },
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetPublicIPAddressConfiguration: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetPublicIPAddressConfiguration",
      modelProperties: {
        name: {
          serializedName: "name",
          required: true,
          type: {
            name: "String",
          },
        },
        properties: {
          serializedName: "properties",
          type: {
            name: "Composite",
            className:
              "VirtualMachineScaleSetPublicIPAddressConfigurationProperties",
          },
        },
        sku: {
          serializedName: "sku",
          type: {
            name: "Composite",
            className: "PublicIPAddressSku",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetPublicIPAddressConfigurationProperties: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetPublicIPAddressConfigurationProperties",
      modelProperties: {
        idleTimeoutInMinutes: {
          serializedName: "idleTimeoutInMinutes",
          type: {
            name: "Number",
          },
        },
        dnsSettings: {
          serializedName: "dnsSettings",
          type: {
            name: "Composite",
            className:
              "VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings",
          },
        },
        ipTags: {
          serializedName: "ipTags",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "VirtualMachineScaleSetIpTag",
              },
            },
          },
        },
        publicIPPrefix: {
          serializedName: "publicIPPrefix",
          type: {
            name: "Composite",
            className: "SubResource",
          },
        },
        publicIPAddressVersion: {
          serializedName: "publicIPAddressVersion",
          type: {
            name: "String",
          },
        },
        deleteOption: {
          serializedName: "deleteOption",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className:
        "VirtualMachineScaleSetPublicIPAddressConfigurationDnsSettings",
      modelProperties: {
        domainNameLabel: {
          serializedName: "domainNameLabel",
          required: true,
          type: {
            name: "String",
          },
        },
        domainNameLabelScope: {
          serializedName: "domainNameLabelScope",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetIpTag: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetIpTag",
    modelProperties: {
      ipTagType: {
        serializedName: "ipTagType",
        type: {
          name: "String",
        },
      },
      tag: {
        serializedName: "tag",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const PublicIPAddressSku: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "PublicIPAddressSku",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String",
        },
      },
      tier: {
        serializedName: "tier",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const SecurityProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SecurityProfile",
    modelProperties: {
      uefiSettings: {
        serializedName: "uefiSettings",
        type: {
          name: "Composite",
          className: "UefiSettings",
        },
      },
      encryptionAtHost: {
        serializedName: "encryptionAtHost",
        type: {
          name: "Boolean",
        },
      },
      securityType: {
        serializedName: "securityType",
        type: {
          name: "String",
        },
      },
      encryptionIdentity: {
        serializedName: "encryptionIdentity",
        type: {
          name: "Composite",
          className: "EncryptionIdentity",
        },
      },
      proxyAgentSettings: {
        serializedName: "proxyAgentSettings",
        type: {
          name: "Composite",
          className: "ProxyAgentSettings",
        },
      },
    },
  },
};

export const UefiSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "UefiSettings",
    modelProperties: {
      secureBootEnabled: {
        serializedName: "secureBootEnabled",
        type: {
          name: "Boolean",
        },
      },
      vTpmEnabled: {
        serializedName: "vTpmEnabled",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const EncryptionIdentity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "EncryptionIdentity",
    modelProperties: {
      userAssignedIdentityResourceId: {
        serializedName: "userAssignedIdentityResourceId",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const ProxyAgentSettings: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ProxyAgentSettings",
    modelProperties: {
      enabled: {
        serializedName: "enabled",
        type: {
          name: "Boolean",
        },
      },
      mode: {
        serializedName: "mode",
        type: {
          name: "String",
        },
      },
      keyIncarnationId: {
        serializedName: "keyIncarnationId",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const DiagnosticsProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "DiagnosticsProfile",
    modelProperties: {
      bootDiagnostics: {
        serializedName: "bootDiagnostics",
        type: {
          name: "Composite",
          className: "BootDiagnostics",
        },
      },
    },
  },
};

export const BootDiagnostics: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "BootDiagnostics",
    modelProperties: {
      enabled: {
        serializedName: "enabled",
        type: {
          name: "Boolean",
        },
      },
      storageUri: {
        serializedName: "storageUri",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetExtensionProfile: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetExtensionProfile",
      modelProperties: {
        extensions: {
          serializedName: "extensions",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "Composite",
                className: "VirtualMachineScaleSetExtension",
              },
            },
          },
        },
        extensionsTimeBudget: {
          serializedName: "extensionsTimeBudget",
          type: {
            name: "String",
          },
        },
      },
    },
  };

export const VirtualMachineScaleSetExtension: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetExtension",
    modelProperties: {
      id: {
        serializedName: "id",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      name: {
        serializedName: "name",
        type: {
          name: "String",
        },
      },
      type: {
        serializedName: "type",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      properties: {
        serializedName: "properties",
        type: {
          name: "Composite",
          className: "VirtualMachineScaleSetExtensionProperties",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetExtensionProperties: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetExtensionProperties",
      modelProperties: {
        forceUpdateTag: {
          serializedName: "forceUpdateTag",
          type: {
            name: "String",
          },
        },
        publisher: {
          serializedName: "publisher",
          type: {
            name: "String",
          },
        },
        type: {
          serializedName: "type",
          type: {
            name: "String",
          },
        },
        typeHandlerVersion: {
          serializedName: "typeHandlerVersion",
          type: {
            name: "String",
          },
        },
        autoUpgradeMinorVersion: {
          serializedName: "autoUpgradeMinorVersion",
          type: {
            name: "Boolean",
          },
        },
        enableAutomaticUpgrade: {
          serializedName: "enableAutomaticUpgrade",
          type: {
            name: "Boolean",
          },
        },
        settings: {
          serializedName: "settings",
          type: {
            name: "Dictionary",
            value: { type: { name: "any" } },
          },
        },
        protectedSettings: {
          serializedName: "protectedSettings",
          type: {
            name: "Dictionary",
            value: { type: { name: "any" } },
          },
        },
        provisioningState: {
          serializedName: "provisioningState",
          readOnly: true,
          type: {
            name: "String",
          },
        },
        provisionAfterExtensions: {
          serializedName: "provisionAfterExtensions",
          type: {
            name: "Sequence",
            element: {
              type: {
                name: "String",
              },
            },
          },
        },
        suppressFailures: {
          serializedName: "suppressFailures",
          type: {
            name: "Boolean",
          },
        },
        protectedSettingsFromKeyVault: {
          serializedName: "protectedSettingsFromKeyVault",
          type: {
            name: "Composite",
            className: "KeyVaultSecretReference",
          },
        },
      },
    },
  };

export const KeyVaultSecretReference: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "KeyVaultSecretReference",
    modelProperties: {
      secretUrl: {
        serializedName: "secretUrl",
        required: true,
        type: {
          name: "String",
        },
      },
      sourceVault: {
        serializedName: "sourceVault",
        type: {
          name: "Composite",
          className: "SubResource",
        },
      },
    },
  },
};

export const ScheduledEventsProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ScheduledEventsProfile",
    modelProperties: {
      terminateNotificationProfile: {
        serializedName: "terminateNotificationProfile",
        type: {
          name: "Composite",
          className: "TerminateNotificationProfile",
        },
      },
      osImageNotificationProfile: {
        serializedName: "osImageNotificationProfile",
        type: {
          name: "Composite",
          className: "OSImageNotificationProfile",
        },
      },
    },
  },
};

export const TerminateNotificationProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "TerminateNotificationProfile",
    modelProperties: {
      notBeforeTimeout: {
        serializedName: "notBeforeTimeout",
        type: {
          name: "String",
        },
      },
      enable: {
        serializedName: "enable",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const OSImageNotificationProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "OSImageNotificationProfile",
    modelProperties: {
      notBeforeTimeout: {
        serializedName: "notBeforeTimeout",
        type: {
          name: "String",
        },
      },
      enable: {
        serializedName: "enable",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const CapacityReservationProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "CapacityReservationProfile",
    modelProperties: {
      capacityReservationGroup: {
        serializedName: "capacityReservationGroup",
        type: {
          name: "Composite",
          className: "SubResource",
        },
      },
    },
  },
};

export const ApplicationProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApplicationProfile",
    modelProperties: {
      galleryApplications: {
        serializedName: "galleryApplications",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VMGalleryApplication",
            },
          },
        },
      },
    },
  },
};

export const VMGalleryApplication: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMGalleryApplication",
    modelProperties: {
      tags: {
        serializedName: "tags",
        type: {
          name: "String",
        },
      },
      order: {
        serializedName: "order",
        type: {
          name: "Number",
        },
      },
      packageReferenceId: {
        serializedName: "packageReferenceId",
        required: true,
        type: {
          name: "String",
        },
      },
      configurationReference: {
        serializedName: "configurationReference",
        type: {
          name: "String",
        },
      },
      treatFailureAsDeploymentFailure: {
        serializedName: "treatFailureAsDeploymentFailure",
        type: {
          name: "Boolean",
        },
      },
      enableAutomaticUpgrade: {
        serializedName: "enableAutomaticUpgrade",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetHardwareProfile: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className: "VirtualMachineScaleSetHardwareProfile",
      modelProperties: {
        vmSizeProperties: {
          serializedName: "vmSizeProperties",
          type: {
            name: "Composite",
            className: "VMSizeProperties",
          },
        },
      },
    },
  };

export const VMSizeProperties: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMSizeProperties",
    modelProperties: {
      vCPUsAvailable: {
        serializedName: "vCPUsAvailable",
        type: {
          name: "Number",
        },
      },
      vCPUsPerCore: {
        serializedName: "vCPUsPerCore",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const ServiceArtifactReference: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ServiceArtifactReference",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const SecurityPostureReference: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SecurityPostureReference",
    modelProperties: {
      id: {
        serializedName: "id",
        type: {
          name: "String",
        },
      },
      excludeExtensions: {
        serializedName: "excludeExtensions",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      isOverridable: {
        serializedName: "isOverridable",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const ComputeProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ComputeProfile",
    modelProperties: {
      baseVirtualMachineProfile: {
        serializedName: "baseVirtualMachineProfile",
        type: {
          name: "Composite",
          className: "BaseVirtualMachineProfile",
        },
      },
      computeApiVersion: {
        serializedName: "computeApiVersion",
        type: {
          name: "String",
        },
      },
      platformFaultDomainCount: {
        serializedName: "platformFaultDomainCount",
        type: {
          name: "Number",
        },
      },
      additionalVirtualMachineCapabilities: {
        serializedName: "additionalVirtualMachineCapabilities",
        type: {
          name: "Composite",
          className: "AdditionalCapabilities",
        },
      },
    },
  },
};

export const AdditionalCapabilities: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "AdditionalCapabilities",
    modelProperties: {
      ultraSSDEnabled: {
        serializedName: "ultraSSDEnabled",
        type: {
          name: "Boolean",
        },
      },
      hibernationEnabled: {
        serializedName: "hibernationEnabled",
        type: {
          name: "Boolean",
        },
      },
    },
  },
};

export const ManagedServiceIdentity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ManagedServiceIdentity",
    modelProperties: {
      principalId: {
        serializedName: "principalId",
        readOnly: true,
        type: {
          name: "Uuid",
        },
      },
      tenantId: {
        serializedName: "tenantId",
        readOnly: true,
        type: {
          name: "Uuid",
        },
      },
      type: {
        serializedName: "type",
        required: true,
        type: {
          name: "String",
        },
      },
      userAssignedIdentities: {
        serializedName: "userAssignedIdentities",
        type: {
          name: "Dictionary",
          value: {
            type: { name: "Composite", className: "UserAssignedIdentity" },
          },
        },
      },
    },
  },
};

export const UserAssignedIdentity: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "UserAssignedIdentity",
    modelProperties: {
      principalId: {
        serializedName: "principalId",
        readOnly: true,
        type: {
          name: "Uuid",
        },
      },
      clientId: {
        serializedName: "clientId",
        readOnly: true,
        type: {
          name: "Uuid",
        },
      },
    },
  },
};

export const Plan: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "Plan",
    modelProperties: {
      name: {
        serializedName: "name",
        required: true,
        type: {
          name: "String",
        },
      },
      publisher: {
        serializedName: "publisher",
        required: true,
        type: {
          name: "String",
        },
      },
      product: {
        serializedName: "product",
        required: true,
        type: {
          name: "String",
        },
      },
      promotionCode: {
        serializedName: "promotionCode",
        type: {
          name: "String",
        },
      },
      version: {
        serializedName: "version",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const Resource: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "Resource",
    modelProperties: {
      id: {
        serializedName: "id",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      name: {
        serializedName: "name",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      type: {
        serializedName: "type",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      systemData: {
        serializedName: "systemData",
        type: {
          name: "Composite",
          className: "SystemData",
        },
      },
    },
  },
};

export const SystemData: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SystemData",
    modelProperties: {
      createdBy: {
        serializedName: "createdBy",
        type: {
          name: "String",
        },
      },
      createdByType: {
        serializedName: "createdByType",
        type: {
          name: "String",
        },
      },
      createdAt: {
        serializedName: "createdAt",
        type: {
          name: "DateTime",
        },
      },
      lastModifiedBy: {
        serializedName: "lastModifiedBy",
        type: {
          name: "String",
        },
      },
      lastModifiedByType: {
        serializedName: "lastModifiedByType",
        type: {
          name: "String",
        },
      },
      lastModifiedAt: {
        serializedName: "lastModifiedAt",
        type: {
          name: "DateTime",
        },
      },
    },
  },
};

export const FleetUpdate: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetUpdate",
    modelProperties: {
      tags: {
        serializedName: "tags",
        type: {
          name: "Dictionary",
          value: { type: { name: "String" } },
        },
      },
      identity: {
        serializedName: "identity",
        type: {
          name: "Composite",
          className: "ManagedServiceIdentityUpdate",
        },
      },
      plan: {
        serializedName: "plan",
        type: {
          name: "Composite",
          className: "ResourcePlanUpdate",
        },
      },
      properties: {
        serializedName: "properties",
        type: {
          name: "Composite",
          className: "FleetProperties",
        },
      },
    },
  },
};

export const ManagedServiceIdentityUpdate: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ManagedServiceIdentityUpdate",
    modelProperties: {
      type: {
        serializedName: "type",
        type: {
          name: "String",
        },
      },
      userAssignedIdentities: {
        serializedName: "userAssignedIdentities",
        type: {
          name: "Dictionary",
          value: {
            type: {
              name: "Composite",
              className:
                "ComponentsQjfoe3SchemasManagedserviceidentityupdatePropertiesUserassignedidentitiesAdditionalproperties",
            },
          },
        },
      },
    },
  },
};

export const ResourcePlanUpdate: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ResourcePlanUpdate",
    modelProperties: {
      name: {
        serializedName: "name",
        type: {
          name: "String",
        },
      },
      publisher: {
        serializedName: "publisher",
        type: {
          name: "String",
        },
      },
      product: {
        serializedName: "product",
        type: {
          name: "String",
        },
      },
      promotionCode: {
        serializedName: "promotionCode",
        type: {
          name: "String",
        },
      },
      version: {
        serializedName: "version",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSetListResult: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSetListResult",
    modelProperties: {
      value: {
        serializedName: "value",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VirtualMachineScaleSet",
            },
          },
        },
      },
      nextLink: {
        serializedName: "nextLink",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VirtualMachineScaleSet: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VirtualMachineScaleSet",
    modelProperties: {
      name: {
        serializedName: "name",
        required: true,
        readOnly: true,
        type: {
          name: "String",
        },
      },
      id: {
        serializedName: "id",
        required: true,
        readOnly: true,
        type: {
          name: "String",
        },
      },
      type: {
        serializedName: "type",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      operationStatus: {
        serializedName: "operationStatus",
        required: true,
        readOnly: true,
        type: {
          name: "String",
        },
      },
      error: {
        serializedName: "error",
        type: {
          name: "Composite",
          className: "ApiError",
        },
      },
    },
  },
};

export const ApiError: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApiError",
    modelProperties: {
      code: {
        serializedName: "code",
        type: {
          name: "String",
        },
      },
      target: {
        serializedName: "target",
        type: {
          name: "String",
        },
      },
      message: {
        serializedName: "message",
        type: {
          name: "String",
        },
      },
      details: {
        serializedName: "details",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "ApiErrorBase",
            },
          },
        },
      },
      innererror: {
        serializedName: "innererror",
        type: {
          name: "Composite",
          className: "InnerError",
        },
      },
    },
  },
};

export const ApiErrorBase: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "ApiErrorBase",
    modelProperties: {
      code: {
        serializedName: "code",
        type: {
          name: "String",
        },
      },
      target: {
        serializedName: "target",
        type: {
          name: "String",
        },
      },
      message: {
        serializedName: "message",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const InnerError: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "InnerError",
    modelProperties: {
      exceptionType: {
        serializedName: "exceptionType",
        type: {
          name: "String",
        },
      },
      errorDetail: {
        serializedName: "errorDetail",
        type: {
          name: "String",
        },
      },
    },
  },
};

export const BasePriorityProfile: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "BasePriorityProfile",
    modelProperties: {
      capacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "capacity",
        type: {
          name: "Number",
        },
      },
      minCapacity: {
        constraints: {
          InclusiveMinimum: 0,
        },
        serializedName: "minCapacity",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const SubResourceReadOnly: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "SubResourceReadOnly",
    modelProperties: {
      id: {
        serializedName: "id",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const VMAttributesList: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "VMAttributesList",
    modelProperties: {
      vmAttributes: {
        serializedName: "vmAttributes",
        required: true,
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VMAttributes",
            },
          },
        },
      },
    },
  },
};

export const ComponentsQjfoe3SchemasManagedserviceidentityupdatePropertiesUserassignedidentitiesAdditionalproperties: coreClient.CompositeMapper =
  {
    type: {
      name: "Composite",
      className:
        "ComponentsQjfoe3SchemasManagedserviceidentityupdatePropertiesUserassignedidentitiesAdditionalproperties",
      modelProperties: {
        ...UserAssignedIdentity.type.modelProperties,
      },
    },
  };

export const TrackedResource: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "TrackedResource",
    modelProperties: {
      ...Resource.type.modelProperties,
      tags: {
        serializedName: "tags",
        type: {
          name: "Dictionary",
          value: { type: { name: "String" } },
        },
      },
      location: {
        serializedName: "location",
        required: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const Fleet: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "Fleet",
    modelProperties: {
      ...TrackedResource.type.modelProperties,
      zones: {
        serializedName: "zones",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "String",
            },
          },
        },
      },
      identity: {
        serializedName: "identity",
        type: {
          name: "Composite",
          className: "ManagedServiceIdentity",
        },
      },
      plan: {
        serializedName: "plan",
        type: {
          name: "Composite",
          className: "Plan",
        },
      },
      provisioningState: {
        serializedName: "properties.provisioningState",
        readOnly: true,
        type: {
          name: "String",
        },
      },
      spotPriorityProfile: {
        serializedName: "properties.spotPriorityProfile",
        type: {
          name: "Composite",
          className: "SpotPriorityProfile",
        },
      },
      regularPriorityProfile: {
        serializedName: "properties.regularPriorityProfile",
        type: {
          name: "Composite",
          className: "RegularPriorityProfile",
        },
      },
      vmSizesProfile: {
        serializedName: "properties.vmSizesProfile",
        type: {
          name: "Sequence",
          element: {
            type: {
              name: "Composite",
              className: "VmSizeProfile",
            },
          },
        },
      },
      vmAttributes: {
        serializedName: "properties.vmAttributes",
        type: {
          name: "Composite",
          className: "VMAttributes",
        },
      },
      additionalLocationsProfile: {
        serializedName: "properties.additionalLocationsProfile",
        type: {
          name: "Composite",
          className: "AdditionalLocationsProfile",
        },
      },
      computeProfile: {
        serializedName: "properties.computeProfile",
        type: {
          name: "Composite",
          className: "ComputeProfile",
        },
      },
      timeCreated: {
        serializedName: "properties.timeCreated",
        readOnly: true,
        type: {
          name: "DateTime",
        },
      },
      uniqueId: {
        serializedName: "properties.uniqueId",
        readOnly: true,
        type: {
          name: "String",
        },
      },
    },
  },
};

export const FleetsCreateOrUpdateHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetsCreateOrUpdateHeaders",
    modelProperties: {
      retryAfter: {
        serializedName: "retry-after",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const FleetsUpdateHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetsUpdateHeaders",
    modelProperties: {
      location: {
        serializedName: "location",
        type: {
          name: "String",
        },
      },
      retryAfter: {
        serializedName: "retry-after",
        type: {
          name: "Number",
        },
      },
    },
  },
};

export const FleetsDeleteHeaders: coreClient.CompositeMapper = {
  type: {
    name: "Composite",
    className: "FleetsDeleteHeaders",
    modelProperties: {
      location: {
        serializedName: "location",
        type: {
          name: "String",
        },
      },
      retryAfter: {
        serializedName: "retry-after",
        type: {
          name: "Number",
        },
      },
    },
  },
};
