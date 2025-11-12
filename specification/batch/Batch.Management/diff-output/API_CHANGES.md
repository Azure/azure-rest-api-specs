## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationPackageReference.description__added` | added | `Link to an application package inside the batch account` |
| `definitions.ApplicationPackageReference.properties.id.description__added` | added | `The ID of the application package to install. This must be inside the same batch account as the pool. This can either be a reference to a specific version or the default version if one exists.` |
| `definitions.AutoScaleRun.description__added` | added | `The results and errors from an execution of a pool autoscale formula.` |
| `definitions.AutoScaleRun.properties.error.description__added` | added | `An error that occurred when autoscaling a pool.` |
| `definitions.AutoScaleRun.properties.evaluationTime.description__added` | added | `The time at which the autoscale formula was last evaluated.` |
| `definitions.AutoScaleRunError.description__added` | added | `An error that occurred when autoscaling a pool.` |
| `definitions.AutoScaleRunError.properties.details.description__added` | added | `Additional details about the error.` |
| `definitions.AutoScaleSettings.description__added` | added | `AutoScale settings for the pool.` |
| `definitions.AutoScaleSettings.properties.formula.description__added` | added | `A formula for the desired number of compute nodes in the pool.` |
| `definitions.AutoUserSpecification.description__added` | added | `Specifies the parameters for the auto user that runs a task on the Batch service.` |
| `definitions.AzureBlobFileSystemConfiguration.description__added` | added | `Information used to connect to an Azure Storage Container using Blobfuse.` |
| `definitions.AzureBlobFileSystemConfiguration.properties.accountName.description__added` | added | `The Azure Storage Account name.` |
| `definitions.AzureBlobFileSystemConfiguration.properties.containerName.description__added` | added | `The Azure Blob Storage Container name.` |
| `definitions.AzureFileShareConfiguration.description__added` | added | `Information used to connect to an Azure Fileshare.` |
| `definitions.AzureFileShareConfiguration.properties.accountKey.description__added` | added | `The Azure Storage account key.` |
| `definitions.AzureFileShareConfiguration.properties.accountName.description__added` | added | `The Azure Storage account name.` |
| `definitions.BatchAccountProperties.properties.activeJobAndJobScheduleQuota.description__added` | added | `The active job and job schedule quota for the Batch account.` |
| `definitions.BatchAccountProperties.properties.autoStorage.description__added` | added | `Contains information about the auto-storage account associated with a Batch account.` |
| `definitions.BatchAccountProperties.properties.keyVaultReference.description__added` | added | `Identifies the Azure key vault associated with a Batch account.` |
| `definitions.BatchAccountProperties.properties.poolQuota.description__added` | added | `The pool quota for the Batch account.` |
| `definitions.CertificateProperties.properties.previousProvisioningStateTransitionTime.description__added` | added | `The time at which the certificate entered its previous state.` |
| `definitions.CertificateProperties.properties.provisioningStateTransitionTime.description__added` | added | `The time at which the certificate entered its current state.` |
| `definitions.CertificateReference.properties.id.description__added` | added | `The fully qualified ID of the certificate to install on the pool. This must be inside the same batch account as the pool.` |
| `definitions.CertificateReference.properties.visibility.description__added` | added | `Which user accounts on the compute node should have access to the private data of the certificate.` |
| `definitions.ContainerConfiguration.description__added` | added | `The configuration for container-enabled pools.` |
| `definitions.ContainerConfiguration.properties.type.description__added` | added | `The container technology to be used.` |
| `definitions.ContainerHostBatchBindMountEntry.description__added` | added | `The entry of path and mount mode you want to mount into task container.` |
| `definitions.ContainerHostBatchBindMountEntry.properties.source.description__added` | added | `The paths which will be mounted to container task's container.` |
| `definitions.ContainerRegistry.description__added` | added | `A private container registry.` |
| `definitions.ContainerRegistry.properties.identityReference.description__added` | added | `The reference to a user assigned identity associated with the Batch pool which a compute node will use.` |
| `definitions.ContainerRegistry.properties.password.description__added` | added | `The password to log into the registry server.` |
| `definitions.ContainerRegistry.properties.username.description__added` | added | `The user name to log into the registry server.` |
| `definitions.DataDisk.properties.diskSizeGB.description__added` | added | `The initial disk size in GB when creating new data disk.` |
| `definitions.DeploymentConfiguration.description__added` | added | `Deployment configuration properties.` |
| `definitions.DiffDiskSettings.description__added` | added | `Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.` |
| `definitions.EnvironmentSetting.description__added` | added | `An environment variable to be set on a task process.` |
| `definitions.EnvironmentSetting.properties.name.description__added` | added | `The name of the environment variable.` |
| `definitions.EnvironmentSetting.properties.value.description__added` | added | `The value of the environment variable.` |
| `definitions.FixedScaleSettings.description__added` | added | `Fixed scale settings for the pool.` |
| `definitions.ImageReference.description__added` | added | `A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.` |
| `definitions.InboundNatPool.description__added` | added | `A inbound NAT pool that can be used to address specific ports on compute nodes in a Batch pool externally.` |
| `definitions.InboundNatPool.properties.protocol.description__added` | added | `The protocol of the endpoint.` |
| `definitions.LinuxUserConfiguration.description__added` | added | `Properties used to create a user account on a Linux node.` |
| `definitions.ManagedDisk.properties.securityProfile.description__added` | added | `Specifies the security profile settings for the managed disk. **Note**: It can only be set for Confidential VMs and is required when using Confidential VMs.` |
| `definitions.ManagedDisk.properties.storageAccountType.description__added` | added | `The storage account type for use in creating data disks or OS disk.` |
| `definitions.MetadataItem.properties.name.description__added` | added | `The name of the metadata item.` |
| `definitions.MetadataItem.properties.value.description__added` | added | `The value of the metadata item.` |
| `definitions.MountConfiguration.description__added` | added | `The file system to mount on each node.` |
| `definitions.NetworkConfiguration.properties.dynamicVnetAssignmentScope.description__added` | added | `The scope of dynamic vnet assignment.` |
| `definitions.NetworkConfiguration.properties.endpointConfiguration.description__added` | added | `The endpoint configuration for a pool.` |
| `definitions.NetworkConfiguration.properties.publicIPAddressConfiguration.description__added` | added | `The public IP Address configuration of the networking configuration of a Pool.` |
| `definitions.NetworkSecurityGroupRule.description__added` | added | `A network security group rule to apply to an inbound endpoint.` |
| `definitions.NetworkSecurityGroupRule.properties.access.description__added` | added | `The action that should be taken for a specified IP address, subnet range or tag.` |
| `definitions.NFSMountConfiguration.description__added` | added | `Information used to connect to an NFS file system.` |
| `definitions.NFSMountConfiguration.properties.source.description__added` | added | `The URI of the file system to mount.` |
| `definitions.Operation.description__added` | added | `A REST API operation` |
| `definitions.Operation.properties.display.description__added` | added | `The object that describes the operation.` |
| `definitions.Operation.properties.origin.description__added` | added | `The intended executor of the operation.` |
| `definitions.Operation.properties.properties.description__added` | added | `Properties of the operation.` |
| `definitions.OSDisk.description__added` | added | `Settings for the operating system disk of the virtual machine.` |
| `definitions.OSDisk.properties.caching.description__added` | added | `The type of caching to enable for the disk.` |
| `definitions.OSDisk.properties.diskSizeGB.description__added` | added | `The initial disk size in GB when creating new OS disk.` |
| `definitions.OSDisk.properties.ephemeralOSDiskSettings.description__added` | added | `Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.` |
| `definitions.OSDisk.properties.writeAcceleratorEnabled.description__added` | added | `Specifies whether writeAccelerator should be enabled or disabled on the disk.` |
| `definitions.PoolEndpointConfiguration.description__added` | added | `The endpoint configuration for a pool.` |
| `definitions.PoolProperties.properties.allocationState.description__added` | added | `Whether the pool is resizing.` |
| `definitions.PoolProperties.properties.allocationStateTransitionTime.description__added` | added | `The time at which the pool entered its current allocation state.` |
| `definitions.PoolProperties.properties.creationTime.description__added` | added | `The creation time of the pool.` |
| `definitions.PoolProperties.properties.currentDedicatedNodes.description__added` | added | `The number of dedicated compute nodes currently in the pool.` |
| `definitions.PoolProperties.properties.currentLowPriorityNodes.description__added` | added | `The number of Spot/low-priority compute nodes currently in the pool.` |
| `definitions.PoolProperties.properties.currentNodeCommunicationMode.description__added` | added | `Determines how a pool communicates with the Batch service.` |
| `definitions.PoolProperties.properties.deploymentConfiguration.description__added` | added | `Deployment configuration properties.` |
| `definitions.PoolProperties.properties.networkConfiguration.description__added` | added | `The network configuration for a pool.` |
| `definitions.PoolProperties.properties.provisioningState.description__added` | added | `The current state of the pool.` |
| `definitions.PoolProperties.properties.provisioningStateTransitionTime.description__added` | added | `The time at which the pool entered its current state.` |
| `definitions.PoolProperties.properties.resizeOperationStatus.description__added` | added | `Describes either the current operation (if the pool AllocationState is Resizing) or the previously completed operation (if the AllocationState is Steady).` |
| `definitions.PoolProperties.properties.scaleSettings.description__added` | added | `Defines the desired size of the pool. This can either be 'fixedScale' where the requested targetDedicatedNodes is specified, or 'autoScale' which defines a formula which is periodically reevaluated. If this property is not specified, the pool will have a fixed scale with 0 targetDedicatedNodes.` |
| `definitions.PoolProperties.properties.upgradePolicy.description__added` | added | `Describes an upgrade policy - automatic, manual, or rolling.` |
| `definitions.PoolProperties.properties.userAccounts.description__added` | added | `The list of user accounts to be created on each node in the pool.` |
| `definitions.PrivateEndpoint.properties.id.description__added` | added | `The ARM resource identifier of the private endpoint. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/privateEndpoints/{privateEndpoint}.` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateEndpoint.description__added` | added | `The private endpoint of the private endpoint connection.` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateLinkServiceConnectionState.description__added` | added | `The private link service connection state of the private endpoint connection` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.description__added` | added | `The provisioning state of the private endpoint connection.` |
| `definitions.PrivateLinkResourceProperties.properties.requiredMembers.description__added` | added | `The list of required members that are used to establish the private link connection.` |
| `definitions.PrivateLinkResourceProperties.properties.requiredZoneNames.description__added` | added | `The list of required zone names for the private DNS resource name` |
| `definitions.PrivateLinkServiceConnectionState.properties.actionsRequired.description__added` | added | `Action required on the private connection state` |
| `definitions.PrivateLinkServiceConnectionState.properties.description.description__added` | added | `Description of the private Connection state` |
| `definitions.PrivateLinkServiceConnectionState.properties.status.description__added` | added | `The status of the Batch private endpoint connection` |
| `definitions.ResizeError.description__added` | added | `An error that occurred when resizing a pool.` |
| `definitions.ResizeError.properties.details.description__added` | added | `Additional details about the error.` |
| `definitions.ResizeOperationStatus.properties.startTime.description__added` | added | `The time when this resize operation was started.` |
| `definitions.ResizeOperationStatus.properties.targetDedicatedNodes.description__added` | added | `The desired number of dedicated compute nodes in the pool.` |
| `definitions.ResizeOperationStatus.properties.targetLowPriorityNodes.description__added` | added | `The desired number of Spot/low-priority compute nodes in the pool.` |
| `definitions.ResourceFile.description__added` | added | `A single file or multiple files to be downloaded to a compute node.` |
| `definitions.ResourceFile.properties.identityReference.description__added` | added | `The reference to a user assigned identity associated with the Batch pool which a compute node will use.` |
| `definitions.SecurityProfile.properties.securityType.description__added` | added | `Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings.` |
| `definitions.StartTask.properties.environmentSettings.description__added` | added | `A list of environment variable settings for the start task.` |
| `definitions.StartTask.properties.resourceFiles.description__added` | added | `A list of files that the Batch service will download to the compute node before running the command line.` |
| `definitions.TaskContainerSettings.description__added` | added | `The container settings for a task.` |
| `definitions.TaskContainerSettings.properties.workingDirectory.description__added` | added | `A flag to indicate where the container task working directory is. The default is 'taskWorkingDirectory'.` |
| `definitions.TaskSchedulingPolicy.description__added` | added | `Specifies how tasks should be distributed across compute nodes.` |
| `definitions.TaskSchedulingPolicy.properties.nodeFillType.description__added` | added | `How tasks should be distributed across compute nodes.` |
| `definitions.UpgradePolicy.properties.mode.description__added` | added | `Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are automatically updated at the same time.<br /><br /> **Rolling** - Scale set performs updates in batches with an optional pause time in between.` |
| `definitions.UpgradePolicy.properties.rollingUpgradePolicy.description__added` | added | `The configuration parameters used while performing a rolling upgrade.` |
| `definitions.UserAccount.description__added` | added | `Properties used to create a user on an Azure Batch node.` |
| `definitions.UserAccount.properties.name.description__added` | added | `The name of the user account. Names can contain any Unicode characters up to a maximum length of 20.` |
| `definitions.UserAccount.properties.password.description__added` | added | `The password for the user account.` |
| `definitions.VirtualMachineConfiguration.description__added` | added | `The configuration for compute nodes in a pool based on the Azure Virtual Machines infrastructure.` |
| `definitions.VirtualMachineConfiguration.properties.imageReference.description__added` | added | `A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.` |
| `definitions.VirtualMachineConfiguration.properties.securityProfile.description__added` | added | `Specifies the security profile settings for the virtual machine or virtual machine scale set.` |
| `definitions.VMDiskSecurityProfile.properties.securityEncryptionType.description__added` | added | `Specifies the EncryptionType of the managed disk. It is set to VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob. **Note**: It can be set for only Confidential VMs and required when using Confidential VMs.` |
| `definitions.VMExtension.description__added` | added | `The configuration for virtual machine extensions.` |
| `definitions.VMExtension.properties.name.description__added` | added | `The name of the virtual machine extension.` |
| `definitions.VMExtension.properties.publisher.description__added` | added | `The name of the extension handler publisher.` |
| `definitions.VMExtension.properties.settings.description__added` | added | `JSON formatted public settings for the extension.` |
| `definitions.VMExtension.properties.type.description__added` | added | `The type of the extensions.` |
| `definitions.VMExtension.properties.typeHandlerVersion.description__added` | added | `The version of script handler.` |
| `definitions.WindowsConfiguration.description__added` | added | `Windows operating system settings to apply to the virtual machine.` |
| `definitions.WindowsUserConfiguration.description__added` | added | `Properties used to create a user account on a Windows node.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}'].get.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}'].patch.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}'].put.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}/cancelDelete'].post.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}'].get.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}'].patch.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}'].put.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}/disableAutoScale'].post.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}/stopResize'].post.responses.200.headers.ETag.description__deleted` | deleted | `The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers.` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.$ref__added` | added | `#/definitions/OperationDisplay` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].$ref__deleted` | deleted | `./BatchManagement.json#/parameters/AccountNameParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchAccountProperties.properties.publicNetworkAccess['x-ms-enum'].name__deleted` | deleted | `PublicNetworkAccessType` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].name__added` | added | `accountName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchAccountListResult.required__added` | added | `["value"]` |
| `definitions.DetectorListResult.required__added` | added | `["value"]` |
| `definitions.ListApplicationPackagesResult.required__added` | added | `["value"]` |
| `definitions.ListApplicationsResult.required__added` | added | `["value"]` |
| `definitions.ListCertificatesResult.required__added` | added | `["value"]` |
| `definitions.ListPoolsResult.required__added` | added | `["value"]` |
| `definitions.ListPrivateEndpointConnectionsResult.required__added` | added | `["value"]` |
| `definitions.ListPrivateLinkResourcesResult.required__added` | added | `["value"]` |
| `definitions.OperationListResult.required__added` | added | `["value"]` |
| `definitions.OutboundEnvironmentEndpointCollection.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.type__deleted` | deleted | `object` |
| `definitions.Operation.properties.properties.type__deleted` | deleted | `object` |
| `definitions.VMExtension.properties.protectedSettings.type__deleted` | deleted | `object` |
| `definitions.VMExtension.properties.settings.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].type__added` | added | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].minLength__added` | added | `3` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].maxLength__added` | added | `24` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+$` |

### Changes for `x-ms-error-response`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}/reconcile'].post.responses.default['x-ms-error-response__deleted']` | deleted | `true` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].patch.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateEndpointConnection` |

### Changes for `AzureResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureResource__deleted` | deleted | `{"type":"object","description":"A definition of an Azure resource.","properties":{"id":{"type":"stri...` |

### Changes for `CIFSMountConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CIFSMountConfiguration__deleted` | deleted | `{"type":"object","title":"Information used to connect to a CIFS file system.","properties":{"userNam...` |

### Changes for `AccessRulePropertiesSubscriptionsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AccessRulePropertiesSubscriptionsItem__added` | added | `{"type":"object","description":"Subscription identifiers","properties":{"id":{"type":"string","forma...` |

### Changes for `CifsMountConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CifsMountConfiguration__added` | added | `{"type":"object","description":"Information used to connect to a CIFS file system.","properties":{"u...` |

### Changes for `NetworkSecurityPerimeter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeter__added` | added | `{"type":"object","description":"NetworkSecurityPerimeter related information","properties":{"id":{"t...` |

### Changes for `NetworkSecurityPerimeterConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfiguration__added` | added | `{"type":"object","description":"Network security perimeter (NSP) configuration resource","properties...` |

### Changes for `NetworkSecurityPerimeterConfigurationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NetworkSecurityPerimeterConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationProperties__added` | added | `{"type":"object","description":"Properties of NetworkSecurityPerimeterConfiguration","properties":{"...` |

### Changes for `NetworkSecurityPerimeterConfigurationPropertiesProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationPropertiesProfile__added` | added | `{"type":"object","description":"Information about current network profile","properties":{"name":{"ty...` |

### Changes for `NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation__added` | added | `{"type":"object","description":"Information about resource association","properties":{"name":{"type"...` |

### Changes for `NspAccessRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRule__added` | added | `{"type":"object","description":"Network security perimeter access rule","properties":{"name":{"type"...` |

### Changes for `NspAccessRuleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleProperties__added` | added | `{"type":"object","description":"Properties of NSP access rule","properties":{"direction":{"type":"st...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__added` | added | `{"type":"object","description":"The object that describes the operation.","properties":{"provider":{...` |

### Changes for `ProvisioningIssue`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProvisioningIssue__added` | added | `{"type":"object","description":"Describes Provisioning issue for given NetworkSecurityPerimeterConfi...` |

### Changes for `ProvisioningIssueProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProvisioningIssueProperties__added` | added | `{"type":"object","description":"Properties of Provisioning Issue","properties":{"issueType":{"type":...` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Application.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |
| `definitions.ApplicationPackage.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements."}` |
| `definitions.Certificate.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |
| `definitions.DetectorResponse.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |
| `definitions.Pool.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |
| `definitions.PrivateEndpointConnection.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |
| `definitions.PrivateLinkResource.properties.etag__added` | added | `{"type":"string","description":"*\\nThe ETag of the resource, used for concurrency statements.","read...` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Application.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.ApplicationPackage.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.Certificate.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.DetectorResponse.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.Pool.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.PrivateEndpointConnection.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |
| `definitions.PrivateLinkResource.properties.tags__added` | added | `{"type":"object","description":"The tags of the certificate.","additionalProperties":{"type":"string...` |

### Changes for `externalDocs`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AutoScaleSettings.properties.formula.externalDocs__deleted` | deleted | `{"description":"Create an automatic scaling formula for scaling compute nodes in a Batch pool","url"...` |
| `definitions.NetworkConfiguration.properties.enableAcceleratedNetworking.externalDocs__deleted` | deleted | `{"description":"Create a VM with Accelerated Networking.","url":"https://learn.microsoft.com/azure/v...` |
| `definitions.NetworkConfiguration.properties.subnetId.externalDocs__deleted` | deleted | `{"description":"Create an Azure Batch pool in a virtual network","url":"https://learn.microsoft.com/...` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureBlobFileSystemConfiguration.properties.accountKey.format__added` | added | `password` |
| `definitions.AzureBlobFileSystemConfiguration.properties.sasKey.format__added` | added | `password` |
| `definitions.AzureFileShareConfiguration.properties.accountKey.format__added` | added | `password` |
| `definitions.CertificateCreateOrUpdateProperties.properties.password.format__added` | added | `password` |
| `definitions.ContainerRegistry.properties.password.format__added` | added | `password` |
| `definitions.LinuxUserConfiguration.properties.sshPrivateKey.format__added` | added | `password` |
| `definitions.UserAccount.properties.password.format__added` | added | `password` |
| `definitions.VMExtension.properties.protectedSettings.format__added` | added | `password` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BatchAccountProperties.properties.activeJobAndJobScheduleQuota['x-nullable__deleted']` | deleted | `false` |
| `definitions.BatchAccountProperties.properties.dedicatedCoreQuotaPerVMFamilyEnforced['x-nullable__deleted']` | deleted | `false` |
| `definitions.BatchAccountProperties.properties.poolAllocationMode['x-nullable__deleted']` | deleted | `false` |
| `definitions.BatchAccountProperties.properties.poolQuota['x-nullable__deleted']` | deleted | `false` |
| `definitions.BatchAccountProperties.properties.provisioningState['x-nullable__deleted']` | deleted | `false` |
| `definitions.CertificateBaseProperties.properties.format['x-nullable__deleted']` | deleted | `false` |
| `definitions.CertificateProperties.properties.previousProvisioningState['x-nullable__deleted']` | deleted | `false` |
| `definitions.CertificateProperties.properties.provisioningState['x-nullable__deleted']` | deleted | `false` |
| `definitions.CertificateReference.properties.visibility.items['x-nullable__deleted']` | deleted | `false` |
| `definitions.DiskEncryptionConfiguration.properties.targets.items['x-nullable__deleted']` | deleted | `false` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState['x-nullable__deleted']` | deleted | `false` |
| `definitions.VirtualMachineFamilyCoreQuota.properties.coreQuota['x-nullable__deleted']` | deleted | `false` |
| `definitions.VirtualMachineFamilyCoreQuota.properties.name['x-nullable__deleted']` | deleted | `false` |

### Changes for `virtualMachineConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentConfiguration.properties.virtualMachineConfiguration__deleted` | deleted | `{"$ref":"#/definitions/VirtualMachineConfiguration","title":"The virtual machine configuration for t...` |

### Changes for `virtualMachineConfiugration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeploymentConfiguration.properties.virtualMachineConfiugration__added` | added | `{"$ref":"#/definitions/VirtualMachineConfiguration","title":"The virtual machine configuration for t...` |

### Changes for `title`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DiskEncryptionConfiguration.properties.targets.items.title__deleted` | deleted | `The disks to encrypt on each compute node.` |
| `definitions.Pool.properties.identity.title__deleted` | deleted | `The type of identity used for the Batch Pool.` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateLinkServiceConnectionState.title__deleted` | deleted | `The private link service connection state of the private endpoint connection.` |
| `definitions.VMDiskSecurityProfile.properties.securityEncryptionType.title__deleted` | deleted | `Specifies the EncryptionType of the managed disk. It is set to VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob. **Note**: It can be set for only Confidential VMs and required when using Confidential VMs.` |
| `definitions.VMDiskSecurityProfile.title__added` | added | `Specifies the security profile settings for the managed disk. **Note**: It can only be set for Confidential VMs and is required when using Confidential VMs.` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.display.properties__deleted` | deleted | `{"provider":{"type":"string","title":"Friendly name of the resource provider."},"operation":{"type":...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Application.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.ApplicationPackage.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.AutoUserSpecification.properties.elevationLevel.description` | `The default value is nonAdmin.` | `The elevation level of the user.` |
| `definitions.AutoUserSpecification.properties.elevationLevel.title` | `The elevation level of the user.` | `The elevation level of the auto user.` |
| `definitions.AutoUserSpecification.properties.scope.title` | `The scope for the auto user` | `The scope of the auto user.` |
| `definitions.BatchAccount.allOf[0].$ref` | `#/definitions/AzureResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.BatchAccountProperties.properties.poolAllocationMode.title` | `The allocation mode to use for creating pools in the Batch account.` | `The allocation mode used for creating pools in the Batch account.` |
| `definitions.Certificate.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.CheckNameAvailabilityParameters.properties.type.description` | `The resource type.` | `The result of the request to list operations.` |
| `definitions.CheckNameAvailabilityParameters.properties.type['x-ms-enum'].modelAsString` | `false` | `true` |
| `definitions.DataDisk.properties.caching.description` | `Values are:

 none - The caching mode for the disk is not enabled.
 readOnly - The caching mode for the disk is read only.
 readWrite - The caching mode for the disk is read and write.

 The default value for caching is none. For information about the caching options see: https://blogs.msdn.microsoft.com/windowsazurestorage/2012/06/27/exploring-windows-azure-drives-disks-and-images/.` | `The type of caching to enable for the disk.` |
| `definitions.DataDisk.properties.storageAccountType.description` | `If omitted, the default is "Standard_LRS". Values are:

 Standard_LRS - The data disk should use standard locally redundant storage.
 Premium_LRS - The data disk should use premium locally redundant storage.` | `The storage account type for use in creating data disks or OS disk.` |
| `definitions.DetectorResponse.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.DiffDiskSettings.properties.placement.description` | `This property can be used by user in the request to choose which location the operating system should be in. e.g., cache disk space for Ephemeral OS disk provisioning. For more information on Ephemeral OS disk size requirements, please refer to Ephemeral OS disk size requirements for Windows VMs at https://learn.microsoft.com/azure/virtual-machines/windows/ephemeral-os-disks#size-requirements and Linux VMs at https://learn.microsoft.com/azure/virtual-machines/linux/ephemeral-os-disks#size-requirements` | `The location where the OS disk should be placed.` |
| `definitions.FixedScaleSettings.properties.nodeDeallocationOption.description` | `If omitted, the default value is Requeue.` | `Determines what to do with a node and its running task(s) after it has been selected for deallocation.` |
| `definitions.IPRule.properties.action.description` | `Action when client IP address is matched.` | `The action when client IP address is matched.` |
| `definitions.KeyVaultProperties.properties.keyIdentifier.description` | `Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:

 The Batch Account has a System Assigned identity
 The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
 The KeyVault has soft-delete and purge protection enabled` | `Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:

The Batch Account has a System Assigned identity
The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
The KeyVault has soft-delete and purge protection enabled` |
| `definitions.MountConfiguration.properties.cifsMountConfiguration.$ref` | `#/definitions/CIFSMountConfiguration` | `#/definitions/CifsMountConfiguration` |
| `definitions.Operation.properties.origin.title` | `The intended executor of the operation.` | `The operation type.` |
| `definitions.Pool.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PoolProperties.properties.targetNodeCommunicationMode.description` | `If omitted, the default value is Default.` | `Determines how a pool communicates with the Batch service.` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PrivateLinkResource.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PrivateLinkResourceProperties.properties.requiredZoneNames.title` | `The list of required zone names for the private DNS resource name` | `The list of required zone names for the private DNS resource name.` |
| `definitions.PublicIPAddressConfiguration.properties.provision.description` | `The default value is BatchManaged` | `The provisioning type for Public IP Addresses for the Batch Pool.` |
| `definitions.ResizeOperationStatus.properties.nodeDeallocationOption.description` | `The default value is requeue.` | `Determines what to do with a node and its running task(s) after it has been selected for deallocation.` |
| `definitions.TaskContainerSettings.properties.imageName.title` | `The image to use to create the container in which the task will run.` | `The private registry which contains the container image.` |
| `definitions.UserAccount.properties.elevationLevel.description` | `nonAdmin - The auto user is a standard user without elevated access. admin - The auto user is a user with elevated access and operates with full Administrator permissions. The default value is nonAdmin.` | `The elevation level of the user.` |
| `definitions.UserAccount.properties.elevationLevel.title` | `The elevation level of the user.` | `The elevation level for the user.` |
| `definitions.UserIdentity.properties.userName.title` | `The name of the user identity under which the task is run.` | `The name of the user under which the task is run.` |
| `definitions.VirtualMachineConfiguration.properties.dataDisks.title` | `The configuration for data disks attached to the compute nodes in the pool.` | `The data disks to be attached to each compute node in the pool.` |
| `definitions.VirtualMachineConfiguration.properties.licenseType.description` | `This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:

 Windows_Server - The on-premises license is for Windows Server.
 Windows_Client - The on-premises license is for Windows Client.
` | `This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:

Windows_Server - The on-premises license is for Windows Server.
Windows_Client - The on-premises license is for Windows Client.` |
| `definitions.VMExtension.properties.protectedSettings.description` | `The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all. ` | `The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}'].put.parameters[0].pattern` | `^[a-z0-9]+$` | `^[a-zA-Z0-9]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}'].put.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/certificates/{certificateName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfigurationListResult` | `#/definitions/NetworkSecurityPerimeterConfigurationListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.responses.default.schema.$ref` | `./BatchManagement.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfiguration` | `#/definitions/NetworkSecurityPerimeterConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}'].get.responses.default.schema.$ref` | `./BatchManagement.json#/definitions/CloudError` | `#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}/reconcile'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/pools/{poolName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}'].patch.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |

