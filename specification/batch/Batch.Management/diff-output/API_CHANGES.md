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
| `definitions.OutboundEnvironmentEndpointCollection.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Batch/batchAccounts/{accountName}/networkSecurityPerimeterConfigurations'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
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

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","title":"A REST API operation","properties":{"name":{"type":"string","title":"The o...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","title":"Result of the request to list REST API operations. It contains a list of o...` |

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
| `definitions.ApplicationPackage.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate."}` |
| `definitions.Certificate.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate.","readOnly":true}` |
| `definitions.DetectorResponse.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate.","readOnly":true}` |
| `definitions.Pool.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate."}` |
| `definitions.PrivateEndpointConnection.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate."}` |
| `definitions.PrivateLinkResource.properties.etag__added` | added | `{"type":"string","description":"*\\nThe entity tag for the certificate."}` |

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
| `definitions.EndpointAccessProfile.properties.defaultAction.title__deleted` | deleted | `The default action when there is no IPRule matched.` |
| `definitions.EnvironmentSetting.properties.name.title__deleted` | deleted | `The name of the environment variable.` |
| `definitions.EnvironmentSetting.properties.value.title__deleted` | deleted | `The value of the environment variable.` |
| `definitions.EnvironmentSetting.title__deleted` | deleted | `An environment variable to be set on a task process.` |
| `definitions.FixedScaleSettings.properties.nodeDeallocationOption.title__deleted` | deleted | `Determines what to do with a node and its running task(s) after it has been selected for deallocation.` |
| `definitions.FixedScaleSettings.properties.resizeTimeout.title__deleted` | deleted | `The timeout for allocation of compute nodes to the pool.` |
| `definitions.FixedScaleSettings.properties.targetDedicatedNodes.title__deleted` | deleted | `The desired number of dedicated compute nodes in the pool.` |
| `definitions.FixedScaleSettings.properties.targetLowPriorityNodes.title__deleted` | deleted | `The desired number of Spot/low-priority compute nodes in the pool.` |
| `definitions.FixedScaleSettings.title__deleted` | deleted | `Fixed scale settings for the pool.` |
| `definitions.ImageReference.properties.communityGalleryImageId.title__deleted` | deleted | `The community gallery image unique identifier` |
| `definitions.ImageReference.properties.id.title__deleted` | deleted | `The ARM resource identifier of the Azure Compute Gallery Image. Compute Nodes in the Pool will be created using this Image Id. This is of the form /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/galleries/{galleryName}/images/{imageDefinitionName}/versions/{versionId}.` |
| `definitions.ImageReference.properties.offer.title__deleted` | deleted | `The offer type of the Azure Virtual Machines Marketplace image.` |
| `definitions.ImageReference.properties.publisher.title__deleted` | deleted | `The publisher of the Azure Virtual Machines Marketplace image.` |
| `definitions.ImageReference.properties.sharedGalleryImageId.title__deleted` | deleted | `The shared gallery image unique identifier` |
| `definitions.ImageReference.properties.sku.title__deleted` | deleted | `The SKU of the Azure Virtual Machines Marketplace image.` |
| `definitions.ImageReference.properties.version.title__deleted` | deleted | `The version of the Azure Virtual Machines Marketplace image.` |
| `definitions.ImageReference.title__deleted` | deleted | `A reference to an Azure Virtual Machines Marketplace image or the Azure Image resource of a custom Virtual Machine. To get the list of all imageReferences verified by Azure Batch, see the 'List supported node agent SKUs' operation.` |
| `definitions.InboundNatPool.properties.backendPort.title__deleted` | deleted | `The port number on the compute node.` |
| `definitions.InboundNatPool.properties.frontendPortRangeEnd.title__deleted` | deleted | `The last port number in the range of external ports that will be used to provide inbound access to the backendPort on individual compute nodes.` |
| `definitions.InboundNatPool.properties.frontendPortRangeStart.title__deleted` | deleted | `The first port number in the range of external ports that will be used to provide inbound access to the backendPort on individual compute nodes.` |
| `definitions.InboundNatPool.properties.name.title__deleted` | deleted | `The name of the endpoint.` |
| `definitions.InboundNatPool.properties.networkSecurityGroupRules.title__deleted` | deleted | `A list of network security group rules that will be applied to the endpoint.` |
| `definitions.InboundNatPool.properties.protocol.title__deleted` | deleted | `The protocol of the endpoint.` |
| `definitions.InboundNatPool.title__deleted` | deleted | `A inbound NAT pool that can be used to address specific ports on compute nodes in a Batch pool externally.` |
| `definitions.IPRule.properties.value.title__deleted` | deleted | `The IP address or IP address range to filter` |
| `definitions.LinuxUserConfiguration.properties.gid.title__deleted` | deleted | `The group ID for the user account.` |
| `definitions.LinuxUserConfiguration.properties.sshPrivateKey.title__deleted` | deleted | `The SSH private key for the user account.` |
| `definitions.LinuxUserConfiguration.properties.uid.title__deleted` | deleted | `The user ID of the user account.` |
| `definitions.LinuxUserConfiguration.title__deleted` | deleted | `Properties used to create a user account on a Linux node.` |
| `definitions.ManagedDisk.properties.securityProfile.title__deleted` | deleted | `Specifies the security profile for the managed disk.` |
| `definitions.ManagedDisk.properties.storageAccountType.title__deleted` | deleted | `The storage account type for use in creating data disks or OS disk.` |
| `definitions.MetadataItem.properties.name.title__deleted` | deleted | `The name of the metadata item.` |
| `definitions.MetadataItem.properties.value.title__deleted` | deleted | `The value of the metadata item.` |
| `definitions.MetadataItem.title__deleted` | deleted | `A name-value pair associated with a Batch service resource.` |
| `definitions.MountConfiguration.properties.azureBlobFileSystemConfiguration.title__deleted` | deleted | `The Azure Storage Container to mount using blob FUSE on each node.` |
| `definitions.MountConfiguration.properties.azureFileShareConfiguration.title__deleted` | deleted | `The Azure File Share to mount on each node.` |
| `definitions.MountConfiguration.properties.cifsMountConfiguration.title__deleted` | deleted | `The CIFS/SMB file system to mount on each node.` |
| `definitions.MountConfiguration.properties.nfsMountConfiguration.title__deleted` | deleted | `The NFS file system to mount on each node.` |
| `definitions.MountConfiguration.title__deleted` | deleted | `The file system to mount on each node.` |
| `definitions.NetworkConfiguration.properties.dynamicVnetAssignmentScope.title__deleted` | deleted | `The scope of dynamic vnet assignment.` |
| `definitions.NetworkConfiguration.properties.enableAcceleratedNetworking.title__deleted` | deleted | `Whether this pool should enable accelerated networking.` |
| `definitions.NetworkConfiguration.properties.endpointConfiguration.title__deleted` | deleted | `The configuration for endpoints on compute nodes in the Batch pool.` |
| `definitions.NetworkConfiguration.properties.publicIPAddressConfiguration.title__deleted` | deleted | `The Public IPAddress configuration for Compute Nodes in the Batch Pool.` |
| `definitions.NetworkConfiguration.properties.subnetId.title__deleted` | deleted | `The ARM resource identifier of the virtual network subnet which the compute nodes of the pool will join. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/{provider}/virtualNetworks/{network}/subnets/{subnet}.` |
| `definitions.NetworkSecurityGroupRule.properties.access.title__deleted` | deleted | `The action that should be taken for a specified IP address, subnet range or tag.` |
| `definitions.NetworkSecurityGroupRule.properties.priority.title__deleted` | deleted | `The priority for this rule.` |
| `definitions.NetworkSecurityGroupRule.properties.sourceAddressPrefix.title__deleted` | deleted | `The source address prefix or tag to match for the rule.` |
| `definitions.NetworkSecurityGroupRule.properties.sourcePortRanges.title__deleted` | deleted | `The source port ranges to match for the rule.` |
| `definitions.NetworkSecurityGroupRule.title__deleted` | deleted | `A network security group rule to apply to an inbound endpoint.` |
| `definitions.NFSMountConfiguration.properties.mountOptions.title__deleted` | deleted | `Additional command line options to pass to the mount command.` |
| `definitions.NFSMountConfiguration.properties.relativeMountPath.title__deleted` | deleted | `The relative path on the compute node where the file system will be mounted` |
| `definitions.NFSMountConfiguration.properties.source.title__deleted` | deleted | `The URI of the file system to mount.` |
| `definitions.NFSMountConfiguration.title__deleted` | deleted | `Information used to connect to an NFS file system.` |
| `definitions.NodePlacementConfiguration.properties.policy.title__deleted` | deleted | `The placement policy for allocating nodes in the pool.` |
| `definitions.NodePlacementConfiguration.title__deleted` | deleted | `Node placement configuration for batch pools.` |
| `definitions.OSDisk.properties.caching.title__deleted` | deleted | `The type of caching to enable for the disk.` |
| `definitions.OSDisk.properties.diskSizeGB.title__deleted` | deleted | `The initial disk size in GB when creating new OS disk.` |
| `definitions.OSDisk.properties.ephemeralOSDiskSettings.title__deleted` | deleted | `Specifies the ephemeral Disk Settings for the operating system disk used by the virtual machine.` |
| `definitions.OSDisk.properties.managedDisk.title__deleted` | deleted | `The managed disk parameters.` |
| `definitions.OSDisk.properties.writeAcceleratorEnabled.title__deleted` | deleted | `Specifies whether writeAccelerator should be enabled or disabled on the disk.` |
| `definitions.OSDisk.title__deleted` | deleted | `Settings for the operating system disk of the virtual machine.` |
| `definitions.Pool.properties.identity.title__deleted` | deleted | `The type of identity used for the Batch Pool.` |
| `definitions.PoolEndpointConfiguration.properties.inboundNatPools.title__deleted` | deleted | `A list of inbound NAT pools that can be used to address specific ports on an individual compute node externally.` |
| `definitions.PoolEndpointConfiguration.title__deleted` | deleted | `The endpoint configuration for a pool.` |
| `definitions.PoolProperties.properties.allocationState.title__deleted` | deleted | `Whether the pool is resizing.` |
| `definitions.PoolProperties.properties.allocationStateTransitionTime.title__deleted` | deleted | `The time at which the pool entered its current allocation state.` |
| `definitions.PoolProperties.properties.applicationLicenses.title__deleted` | deleted | `The list of application licenses the Batch service will make available on each compute node in the pool.` |
| `definitions.PoolProperties.properties.applicationPackages.title__deleted` | deleted | `The list of application packages to be installed on each compute node in the pool.` |
| `definitions.PoolProperties.properties.autoScaleRun.title__deleted` | deleted | `The results and errors from the last execution of the autoscale formula.` |
| `definitions.PoolProperties.properties.certificates.title__deleted` | deleted | `The list of certificates to be installed on each compute node in the pool.` |
| `definitions.PoolProperties.properties.creationTime.title__deleted` | deleted | `The creation time of the pool.` |
| `definitions.PoolProperties.properties.currentDedicatedNodes.title__deleted` | deleted | `The number of dedicated compute nodes currently in the pool.` |
| `definitions.PoolProperties.properties.currentLowPriorityNodes.title__deleted` | deleted | `The number of Spot/low-priority compute nodes currently in the pool.` |
| `definitions.PoolProperties.properties.currentNodeCommunicationMode.title__deleted` | deleted | `Determines how a pool communicates with the Batch service.` |
| `definitions.PoolProperties.properties.deploymentConfiguration.title__deleted` | deleted | `This property describes the virtual machines that the pool nodes will be deployed on.` |
| `definitions.PoolProperties.properties.displayName.title__deleted` | deleted | `The display name for the pool.` |
| `definitions.PoolProperties.properties.interNodeCommunication.title__deleted` | deleted | `Whether the pool permits direct communication between nodes.` |
| `definitions.PoolProperties.properties.lastModified.title__deleted` | deleted | `The last modified time of the pool.` |
| `definitions.PoolProperties.properties.metadata.title__deleted` | deleted | `A list of name-value pairs associated with the pool as metadata.` |
| `definitions.PoolProperties.properties.mountConfiguration.title__deleted` | deleted | `A list of file systems to mount on each node in the pool.` |
| `definitions.PoolProperties.properties.networkConfiguration.title__deleted` | deleted | `The network configuration for the pool.` |
| `definitions.PoolProperties.properties.provisioningState.title__deleted` | deleted | `The current state of the pool.` |
| `definitions.PoolProperties.properties.provisioningStateTransitionTime.title__deleted` | deleted | `The time at which the pool entered its current state.` |
| `definitions.PoolProperties.properties.resizeOperationStatus.title__deleted` | deleted | `Contains details about the current or last completed resize operation.` |
| `definitions.PoolProperties.properties.resourceTags.title__deleted` | deleted | `The user-specified tags associated with the pool.` |
| `definitions.PoolProperties.properties.scaleSettings.title__deleted` | deleted | `Settings which configure the number of nodes in the pool.` |
| `definitions.PoolProperties.properties.startTask.title__deleted` | deleted | `A task specified to run on each compute node as it joins the pool.` |
| `definitions.PoolProperties.properties.targetNodeCommunicationMode.title__deleted` | deleted | `Determines how a pool communicates with the Batch service.` |
| `definitions.PoolProperties.properties.taskSchedulingPolicy.title__deleted` | deleted | `How tasks are distributed across compute nodes in a pool.` |
| `definitions.PoolProperties.properties.taskSlotsPerNode.title__deleted` | deleted | `The number of task slots that can be used to run concurrent tasks on a single compute node in the pool.` |
| `definitions.PoolProperties.properties.upgradePolicy.title__deleted` | deleted | `The upgrade policy for the pool.` |
| `definitions.PoolProperties.properties.userAccounts.title__deleted` | deleted | `The list of user accounts to be created on each node in the pool.` |
| `definitions.PoolProperties.properties.vmSize.title__deleted` | deleted | `The size of virtual machines in the pool. All VMs in a pool are the same size.` |
| `definitions.PrivateEndpoint.properties.id.title__deleted` | deleted | `The ARM resource identifier of the private endpoint. This is of the form /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Network/privateEndpoints/{privateEndpoint}.` |
| `definitions.PrivateEndpointConnectionProperties.properties.groupIds.title__deleted` | deleted | `The group id of the private endpoint connection.` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateEndpoint.title__deleted` | deleted | `The ARM resource identifier of the private endpoint.` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateLinkServiceConnectionState.title__deleted` | deleted | `The private link service connection state of the private endpoint connection.` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.title__deleted` | deleted | `The provisioning state of the private endpoint connection.` |
| `definitions.PrivateLinkResourceProperties.properties.groupId.title__deleted` | deleted | `The group id of the private link resource.` |
| `definitions.PrivateLinkResourceProperties.properties.requiredMembers.title__deleted` | deleted | `The list of required members that are used to establish the private link connection.` |
| `definitions.PrivateLinkResourceProperties.properties.requiredZoneNames.title__deleted` | deleted | `The list of required zone names for the private DNS resource name` |
| `definitions.PrivateLinkServiceConnectionState.properties.actionsRequired.title__deleted` | deleted | `Action required on the private connection state` |
| `definitions.PrivateLinkServiceConnectionState.properties.description.title__deleted` | deleted | `Description of the private Connection state` |
| `definitions.PrivateLinkServiceConnectionState.properties.status.title__deleted` | deleted | `The status of the Batch private endpoint connection` |
| `definitions.PublicIPAddressConfiguration.properties.ipAddressIds.title__deleted` | deleted | `The list of public IPs which the Batch service will use when provisioning Compute Nodes.` |
| `definitions.PublicIPAddressConfiguration.properties.provision.title__deleted` | deleted | `The provisioning type for Public IP Addresses for the Batch Pool.` |
| `definitions.ResizeError.properties.details.title__deleted` | deleted | `Additional details about the error.` |
| `definitions.ResizeError.title__deleted` | deleted | `An error that occurred when resizing a pool.` |
| `definitions.ResizeOperationStatus.properties.errors.title__deleted` | deleted | `Details of any errors encountered while performing the last resize on the pool.` |
| `definitions.ResizeOperationStatus.properties.nodeDeallocationOption.title__deleted` | deleted | `Determines what to do with a node and its running task(s) after it has been selected for deallocation.` |
| `definitions.ResizeOperationStatus.properties.resizeTimeout.title__deleted` | deleted | `The timeout for allocation of compute nodes to the pool or removal of compute nodes from the pool.` |
| `definitions.ResizeOperationStatus.properties.startTime.title__deleted` | deleted | `The time when this resize operation was started.` |
| `definitions.ResizeOperationStatus.properties.targetDedicatedNodes.title__deleted` | deleted | `The desired number of dedicated compute nodes in the pool.` |
| `definitions.ResizeOperationStatus.properties.targetLowPriorityNodes.title__deleted` | deleted | `The desired number of Spot/low-priority compute nodes in the pool.` |
| `definitions.ResizeOperationStatus.title__deleted` | deleted | `Details about the current or last completed resize operation.` |
| `definitions.ResourceFile.properties.autoStorageContainerName.title__deleted` | deleted | `The storage container name in the auto storage account.` |
| `definitions.ResourceFile.properties.blobPrefix.title__deleted` | deleted | `The blob prefix to use when downloading blobs from an Azure Storage container. Only the blobs whose names begin with the specified prefix will be downloaded.` |
| `definitions.ResourceFile.properties.fileMode.title__deleted` | deleted | `The file permission mode attribute in octal format.` |
| `definitions.ResourceFile.properties.filePath.title__deleted` | deleted | `The location on the compute node to which to download the file, relative to the task's working directory.` |
| `definitions.ResourceFile.properties.httpUrl.title__deleted` | deleted | `The URL of the file to download.` |
| `definitions.ResourceFile.properties.identityReference.title__deleted` | deleted | `The reference to the user assigned identity to use to access Azure Blob Storage specified by storageContainerUrl or httpUrl` |
| `definitions.ResourceFile.properties.storageContainerUrl.title__deleted` | deleted | `The URL of the blob container within Azure Blob Storage.` |
| `definitions.ResourceFile.title__deleted` | deleted | `A single file or multiple files to be downloaded to a compute node.` |
| `definitions.ScaleSettings.properties.autoScale.title__deleted` | deleted | `AutoScale settings for the pool.` |
| `definitions.ScaleSettings.properties.fixedScale.title__deleted` | deleted | `Fixed scale settings for the pool.` |
| `definitions.ScaleSettings.title__deleted` | deleted | `Scale settings for the pool` |
| `definitions.SecurityProfile.properties.securityType.title__deleted` | deleted | `Specifies the SecurityType of the virtual machine. It has to be set to any specified value to enable UefiSettings.` |
| `definitions.SecurityProfile.properties.uefiSettings.title__deleted` | deleted | `Specifies the security settings like secure boot and vTPM used while creating the virtual machine.` |
| `definitions.ServiceArtifactReference.properties.id.title__deleted` | deleted | `The service artifact reference id of ServiceArtifactReference` |
| `definitions.StartTask.properties.commandLine.title__deleted` | deleted | `The command line of the start task.` |
| `definitions.StartTask.properties.containerSettings.title__deleted` | deleted | `The settings for the container under which the start task runs.` |
| `definitions.StartTask.properties.environmentSettings.title__deleted` | deleted | `A list of environment variable settings for the start task.` |
| `definitions.StartTask.properties.maxTaskRetryCount.title__deleted` | deleted | `The maximum number of times the task may be retried.` |
| `definitions.StartTask.properties.resourceFiles.title__deleted` | deleted | `A list of files that the Batch service will download to the compute node before running the command line.` |
| `definitions.StartTask.properties.userIdentity.title__deleted` | deleted | `The user identity under which the start task runs.` |
| `definitions.StartTask.properties.waitForSuccess.title__deleted` | deleted | `Whether the Batch service should wait for the start task to complete successfully (that is, to exit with exit code 0) before scheduling any tasks on the compute node.` |
| `definitions.StartTask.title__deleted` | deleted | `A task which is run when a compute node joins a pool in the Azure Batch service, or when the compute node is rebooted or reimaged.` |
| `definitions.TaskContainerSettings.properties.containerHostBatchBindMounts.title__deleted` | deleted | `The paths you want to mounted to container task.` |
| `definitions.TaskContainerSettings.properties.containerRunOptions.title__deleted` | deleted | `Additional options to the container create command.` |
| `definitions.TaskContainerSettings.properties.imageName.title__deleted` | deleted | `The image to use to create the container in which the task will run.` |
| `definitions.TaskContainerSettings.properties.registry.title__deleted` | deleted | `The private registry which contains the container image.` |
| `definitions.TaskContainerSettings.properties.workingDirectory.title__deleted` | deleted | `A flag to indicate where the container task working directory is. The default is 'taskWorkingDirectory'.` |
| `definitions.TaskContainerSettings.title__deleted` | deleted | `The container settings for a task.` |
| `definitions.TaskSchedulingPolicy.properties.nodeFillType.title__deleted` | deleted | `How tasks should be distributed across compute nodes.` |
| `definitions.TaskSchedulingPolicy.title__deleted` | deleted | `Specifies how tasks should be distributed across compute nodes.` |
| `definitions.UpgradePolicy.properties.automaticOSUpgradePolicy.title__deleted` | deleted | `Configuration parameters used for performing automatic OS Upgrade.` |
| `definitions.UpgradePolicy.properties.mode.title__deleted` | deleted | `Specifies the mode of an upgrade to virtual machines in the scale set.<br /><br /> Possible values are:<br /><br /> **Manual** - You  control the application of updates to virtual machines in the scale set. You do this by using the manualUpgrade action.<br /><br /> **Automatic** - All virtual machines in the scale set are automatically updated at the same time.<br /><br /> **Rolling** - Scale set performs updates in batches with an optional pause time in between.` |
| `definitions.UpgradePolicy.properties.rollingUpgradePolicy.title__deleted` | deleted | `The configuration parameters used while performing a rolling upgrade.` |
| `definitions.UserAccount.properties.elevationLevel.title__deleted` | deleted | `The elevation level of the user.` |
| `definitions.UserAccount.properties.linuxUserConfiguration.title__deleted` | deleted | `The Linux-specific user configuration for the user account.` |
| `definitions.UserAccount.properties.name.title__deleted` | deleted | `The name of the user account. Names can contain any Unicode characters up to a maximum length of 20.` |
| `definitions.UserAccount.properties.password.title__deleted` | deleted | `The password for the user account.` |
| `definitions.UserAccount.properties.windowsUserConfiguration.title__deleted` | deleted | `The Windows-specific user configuration for the user account.` |
| `definitions.UserAccount.title__deleted` | deleted | `Properties used to create a user on an Azure Batch node.` |
| `definitions.UserIdentity.properties.autoUser.title__deleted` | deleted | `The auto user under which the task is run.` |
| `definitions.UserIdentity.properties.userName.title__deleted` | deleted | `The name of the user identity under which the task is run.` |
| `definitions.UserIdentity.title__deleted` | deleted | `The definition of the user identity under which the task is run.` |
| `definitions.VirtualMachineConfiguration.properties.containerConfiguration.title__deleted` | deleted | `The container configuration for the pool.` |
| `definitions.VirtualMachineConfiguration.properties.dataDisks.title__deleted` | deleted | `The configuration for data disks attached to the compute nodes in the pool.` |
| `definitions.VirtualMachineConfiguration.properties.diskEncryptionConfiguration.title__deleted` | deleted | `The disk encryption configuration for the pool.` |
| `definitions.VirtualMachineConfiguration.properties.extensions.title__deleted` | deleted | `The virtual machine extension for the pool.` |
| `definitions.VirtualMachineConfiguration.properties.imageReference.title__deleted` | deleted | `A reference to the Azure Virtual Machines Marketplace Image or the custom Virtual Machine Image to use.` |
| `definitions.VirtualMachineConfiguration.properties.licenseType.title__deleted` | deleted | `The type of on-premises license to be used when deploying the operating system.` |
| `definitions.VirtualMachineConfiguration.properties.nodeAgentSkuId.title__deleted` | deleted | `The SKU of the Batch node agent to be provisioned on compute nodes in the pool.` |
| `definitions.VirtualMachineConfiguration.properties.nodePlacementConfiguration.title__deleted` | deleted | `The node placement configuration for the pool.` |
| `definitions.VirtualMachineConfiguration.properties.osDisk.title__deleted` | deleted | `Settings for the operating system disk of the Virtual Machine.` |
| `definitions.VirtualMachineConfiguration.properties.securityProfile.title__deleted` | deleted | `Specifies the security profile settings for the virtual machine or virtual machine scale set.` |
| `definitions.VirtualMachineConfiguration.properties.serviceArtifactReference.title__deleted` | deleted | `Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.` |
| `definitions.VirtualMachineConfiguration.properties.windowsConfiguration.title__deleted` | deleted | `Windows operating system settings on the virtual machine.` |
| `definitions.VirtualMachineConfiguration.title__deleted` | deleted | `The configuration for compute nodes in a pool based on the Azure Virtual Machines infrastructure.` |
| `definitions.VMDiskSecurityProfile.properties.securityEncryptionType.title__deleted` | deleted | `Specifies the EncryptionType of the managed disk. It is set to VMGuestStateOnly for encryption of just the VMGuestState blob, and NonPersistedTPM for not persisting firmware state in the VMGuestState blob. **Note**: It can be set for only Confidential VMs and required when using Confidential VMs.` |
| `definitions.VMExtension.properties.name.title__deleted` | deleted | `The name of the virtual machine extension.` |
| `definitions.VMExtension.properties.provisionAfterExtensions.title__deleted` | deleted | `The collection of extension names.` |
| `definitions.VMExtension.properties.publisher.title__deleted` | deleted | `The name of the extension handler publisher.` |
| `definitions.VMExtension.properties.settings.title__deleted` | deleted | `JSON formatted public settings for the extension.` |
| `definitions.VMExtension.properties.type.title__deleted` | deleted | `The type of the extensions.` |
| `definitions.VMExtension.properties.typeHandlerVersion.title__deleted` | deleted | `The version of script handler.` |
| `definitions.VMExtension.title__deleted` | deleted | `The configuration for virtual machine extensions.` |
| `definitions.WindowsConfiguration.properties.enableAutomaticUpdates.title__deleted` | deleted | `Whether automatic updates are enabled on the virtual machine.` |
| `definitions.WindowsConfiguration.title__deleted` | deleted | `Windows operating system settings to apply to the virtual machine.` |
| `definitions.WindowsUserConfiguration.properties.loginMode.title__deleted` | deleted | `Login mode for user` |
| `definitions.WindowsUserConfiguration.title__deleted` | deleted | `Properties used to create a user account on a Windows node.` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.FixedScaleSettings.properties.resizeTimeout.default__deleted` | deleted | `PT15M` |
| `definitions.IPRule.properties.action.default__added` | added | `Allow` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OutboundEnvironmentEndpointCollection.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SupportedSkusResult.properties.value['x-ms-identifiers__deleted']` | deleted | `["name"]` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VMExtension.properties.protectedSettings.additionalProperties__added` | added | `{}` |
| `definitions.VMExtension.properties.settings.additionalProperties__added` | added | `{}` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VMExtension.properties.protectedSettings['x-ms-secret__deleted']` | deleted | `true` |

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
| `definitions.IPRule.properties.action['x-ms-enum'].modelAsString` | `false` | `true` |
| `definitions.KeyVaultProperties.properties.keyIdentifier.description` | `Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:

 The Batch Account has a System Assigned identity
 The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
 The KeyVault has soft-delete and purge protection enabled` | `Full path to the secret with or without version. Example https://mykeyvault.vault.azure.net/keys/testkey/6e34a81fef704045975661e297a4c053. or https://mykeyvault.vault.azure.net/keys/testkey. To be usable the following prerequisites must be met:

The Batch Account has a System Assigned identity
The account identity has been granted Key/Get, Key/Unwrap and Key/Wrap permissions
The KeyVault has soft-delete and purge protection enabled` |
| `definitions.MountConfiguration.properties.cifsMountConfiguration.$ref` | `#/definitions/CIFSMountConfiguration` | `#/definitions/CifsMountConfiguration` |
| `definitions.Pool.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PoolProperties.properties.targetNodeCommunicationMode.description` | `If omitted, the default value is Default.` | `Determines how a pool communicates with the Batch service.` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PrivateLinkResource.allOf[0].$ref` | `#/definitions/AzureProxyResource` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.PublicIPAddressConfiguration.properties.provision.description` | `The default value is BatchManaged` | `The provisioning type for Public IP Addresses for the Batch Pool.` |
| `definitions.ResizeOperationStatus.properties.nodeDeallocationOption.description` | `The default value is requeue.` | `Determines what to do with a node and its running task(s) after it has been selected for deallocation.` |
| `definitions.UserAccount.properties.elevationLevel.description` | `nonAdmin - The auto user is a standard user without elevated access. admin - The auto user is a user with elevated access and operates with full Administrator permissions. The default value is nonAdmin.` | `The elevation level of the user.` |
| `definitions.VirtualMachineConfiguration.properties.licenseType.description` | `This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:

 Windows_Server - The on-premises license is for Windows Server.
 Windows_Client - The on-premises license is for Windows Client.
` | `This only applies to images that contain the Windows operating system, and should only be used when you hold valid on-premises licenses for the nodes which will be deployed. If omitted, no on-premises licensing discount is applied. Values are:

Windows_Server - The on-premises license is for Windows Server.
Windows_Client - The on-premises license is for Windows Client.` |
| `definitions.VMExtension.properties.protectedSettings.description` | `The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all. ` | `The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.` |
| `paths['/providers/microsoft.Batch/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |
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

