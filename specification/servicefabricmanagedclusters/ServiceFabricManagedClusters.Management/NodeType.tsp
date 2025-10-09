import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;
/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
@parentResource(ManagedCluster)
model NodeType is Azure.ResourceManager.ProxyResource<NodeTypeProperties> {
  ...ResourceNameParameter<
    Resource = NodeType,
    KeyName = "nodeTypeName",
    SegmentName = "nodeTypes",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The node type sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  sku?: NodeTypeSku;
}

@armResourceOperations
interface NodeTypes {
  /**
   * Get a Service Fabric node type of a given managed cluster.
   */
  get is ArmResourceRead<NodeType>;

  /**
   * Create or update a Service Fabric node type of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NodeType,
    Response = ArmResourceUpdatedResponse<NodeType> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = NodeType>> & {
      @bodyRoot
      _: NodeType;
    })
  >;

  /**
   * Update the configuration of a node type of a given managed cluster, only updating tags.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NodeType,
    PatchModel = NodeTypeUpdateParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = NodeType>
  >;

  /**
   * Delete a Service Fabric node type of a given managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeType,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Gets all Node types of the specified managed cluster.
   */
  listByManagedClusters is ArmResourceListByParent<NodeType>;

  /**
   * Deallocates one or more nodes on the node type. It will disable the fabric nodes, trigger a shutdown on the VMs and release them from the cluster.
   */
  deallocate is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Deletes one or more nodes on the node type. It will disable the fabric nodes, trigger a delete on the VMs and removes the state from the cluster.
   */
  deleteNode is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Redeploys one or more nodes on the node type. It will disable the fabric nodes, trigger a shut down on the VMs, move them to a new node, and power them back on.
   */
  redeploy is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Reimages one or more nodes on the node type. It will disable the fabric nodes, trigger a reimage on the VMs and activate the nodes back again.
   */
  reimage is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Restarts one or more nodes on the node type. It will disable the fabric nodes, trigger a restart on the VMs and activate the nodes back again.
   */
  restart is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Starts one or more nodes on the node type. It will trigger an allocation of the fabric node if needed and activate them.
   */
  start is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    never,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Starts a fault simulation on the node type.
   */
  @tag("FaultSimulation")
  startFaultSimulation is ArmResourceActionAsync<
    NodeType,
    FaultSimulationContentWrapper,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;

  /**
   * Stops a fault simulation on the node type.
   */
  @tag("FaultSimulation")
  stopFaultSimulation is ArmResourceActionAsync<
    NodeType,
    FaultSimulationIdContent,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;

  /**
   * Gets a fault simulation by the simulationId.
   */
  @tag("FaultSimulation")
  getFaultSimulation is ArmResourceActionSync<
    NodeType,
    FaultSimulationIdContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Gets the list of recent fault simulations for the node type.
   */
  @tag("FaultSimulation")
  listFaultSimulation is ArmResourceActionSync<
    NodeType,
    void,
    ArmResponse<FaultSimulationListResult>
  >;
}

@armResourceOperations
interface NodeTypeSkus {
  /**
   * Get a Service Fabric node type supported SKUs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @get
  @action("skus")
  @operationId("NodeTypeSkus_List")
  list is ArmResourceActionSync<
    NodeType,
    void,
    ArmResponse<NodeTypeListSkuResult>
  >;
}

@@doc(NodeType.name, "The name of the node type.");
@@doc(NodeType.properties, "The node type properties");
@@doc(NodeTypes.createOrUpdate::parameters.resource, "The node type resource.");
@@doc(NodeTypes.update::parameters.properties,
  "The parameters to update the node type configuration."
);
@@doc(NodeTypes.deallocate::parameters.body,
  "parameters for deallocate action."
);
@@doc(NodeTypes.deleteNode::parameters.body, "parameters for delete action.");
@@doc(NodeTypes.getFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
@@doc(NodeTypes.redeploy::parameters.body, "parameters for redeploy action.");
@@doc(NodeTypes.reimage::parameters.body, "parameters for reimage action.");
@@doc(NodeTypes.restart::parameters.body, "parameters for restart action.");
@@doc(NodeTypes.start::parameters.body, "parameters for start action.");
@@doc(NodeTypes.startFaultSimulation::parameters.body,
  "parameters describing the fault simulation."
);
@@doc(NodeTypes.stopFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);

/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
model NodeTypeProperties {
  /**
   * Indicates the Service Fabric system services for the cluster will run on this node type. This setting cannot be changed once the node type is created.
   */
  isPrimary: boolean;

  /**
   * The number of nodes in the node type. **Values:** -1 - Use when auto scale rules are configured or sku.capacity is defined 0 - Not supported >0 - Use for manual scale.
   */
  @maxValue(2147483647)
  @minValue(-1)
  vmInstanceCount: int32;

  /**
   * Disk size for the managed disk attached to the vms on the node type in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is a well known abbreviation"
  dataDiskSizeGB?: int32;

  /**
   * Managed data disk type. Specifies the storage account type for the managed disk
   */
  dataDiskType?: DiskType = DiskType.StandardSSD_LRS;

  /**
   * Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.
   */
  @pattern("^[a-zA-Z]{1}$")
  dataDiskLetter?: string;

  /**
   * The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  capacities?: Record<string>;

  /**
   * The range of ports from which cluster assigned port to Service Fabric applications.
   */
  applicationPorts?: EndpointRangeDescription;

  /**
   * The range of ephemeral ports that nodes in this node type should be configured with.
   */
  ephemeralPorts?: EndpointRangeDescription;

  /**
   * The size of virtual machines in the pool. All virtual machines in a pool are the same size. For example, Standard_D3.
   */
  vmSize?: string;

  /**
   * The publisher of the Azure Virtual Machines Marketplace image. For example, Canonical or MicrosoftWindowsServer.
   */
  vmImagePublisher?: string;

  /**
   * The offer type of the Azure Virtual Machines Marketplace image. For example, UbuntuServer or WindowsServer.
   */
  vmImageOffer?: string;

  /**
   * The SKU of the Azure Virtual Machines Marketplace image. For example, 14.04.0-LTS or 2012-R2-Datacenter.
   */
  vmImageSku?: string;

  /**
   * The version of the Azure Virtual Machines Marketplace image. A value of 'latest' can be specified to select the latest version of an image. If omitted, the default is 'latest'.
   */
  vmImageVersion?: string;

  /**
   * The secrets to install in the virtual machines.
   */
  @identifiers(#["sourceVault"])
  vmSecrets?: VaultSecretGroup[];

  /**
   * Set of extensions that should be installed onto the virtual machines.
   */
  @identifiers(#["name"])
  vmExtensions?: VMSSExtension[];

  /**
   * Identities to assign to the virtual machine scale set under the node type.
   */
  vmManagedIdentity?: VmManagedIdentity;

  /**
   * Indicates if the node type can only host Stateless workloads.
   */
  isStateless?: boolean = false;

  /**
   * Indicates if scale set associated with the node type can be composed of multiple placement groups.
   */
  multiplePlacementGroups?: boolean = false;

  /**
   * Indicates the node type uses its own frontend configurations instead of the default one for the cluster. This setting can only be specified for non-primary node types and can not be added or removed after the node type is created.
   */
  @identifiers(#[])
  frontendConfigurations?: FrontendConfiguration[];

  /**
   * The Network Security Rules for this node type. This setting can only be specified for node types that are configured with frontend configurations.
   */
  @identifiers(#[])
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Additional managed data disks.
   */
  @identifiers(#["lun"])
  additionalDataDisks?: VmssDataDisk[];

  /**
   * Enable or disable the Host Encryption for the virtual machines on the node type. This will enable the encryption for all the disks including Resource/Temp disk at host itself. Default: The Encryption at host will be disabled unless this property is set to true for the resource.
   */
  enableEncryptionAtHost?: boolean = false;

  /**
   * The provisioning state of the node type resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedResourceProvisioningState;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies whether the use public load balancer. If not specified and the node type doesn't have its own frontend configuration, it will be attached to the default load balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is true, then the frontend has to be an Internal Load Balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is false or not set, then the custom load balancer must include a public load balancer to provide outbound connectivity.
   */
  useDefaultPublicLoadBalancer?: boolean;

  /**
   * Specifies whether to use the temporary disk for the service fabric data root, in which case no managed data disk will be attached and the temporary disk will be used. It is only allowed for stateless node types.
   */
  useTempDataDisk?: boolean;

  /**
   * Specifies whether the node type should be overprovisioned. It is only allowed for stateless node types.
   */
  enableOverProvisioning?: boolean;

  /**
   * Specifies the availability zones where the node type would span across. If the cluster is not spanning across availability zones, initiates az migration for the cluster.
   */
  zones?: string[];

  /**
   * Indicates whether the node type will be Spot Virtual Machines. Azure will allocate the VMs if there is capacity available and the VMs can be evicted at any time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known abbreviation"
  isSpotVM?: boolean;

  /**
   * Specifies the full host group resource Id. This property is used for deploying on azure dedicated hosts.
   */
  hostGroupId?: string;

  /**
   * Indicates whether to use ephemeral os disk. The sku selected on the vmSize property needs to support this feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OS is a well known abbreviation"
  useEphemeralOSDisk?: boolean;

  /**
   * Indicates the time duration after which the platform will not try to restore the VMSS SPOT instances specified as ISO 8601.
   */
  spotRestoreTimeout?: string;

  /**
   * Specifies the eviction policy for virtual machines in a SPOT node type. Default is Delete.
   */
  evictionPolicy?: EvictionPolicyType;

  /**
   * Indicates the resource id of the vm image. This parameter is used for custom vm image.
   */
  vmImageResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/images";
    },
    {
      type: "Microsoft.Compute/galleries/images";
    },
    {
      type: "Microsoft.Compute/galleries/images/versions";
    }
  ]>;

  /**
   * Indicates the resource id of the subnet for the node type.
   */
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Specifies the actions to be performed on the vms before bootstrapping the service fabric runtime.
   */
  vmSetupActions?: VmSetupAction[];

  /**
   * Specifies the security type of the nodeType. Supported values include Standard, TrustedLaunch and ConfidentialVM.
   */
  securityType?: SecurityType;

  /**
   * Specifies the EncryptionType of the managed disk. It is set to DiskWithVMGuestState for encryption of the managed disk along with VMGuestState blob and VMGuestStateOnly for encryption of just the VMGuestState blob. Note: It can be set for only Confidential VMs.
   */
  securityEncryptionType?: SecurityEncryptionType;

  /**
   * Specifies whether secure boot should be enabled on the nodeType. Can only be used with TrustedLaunch and ConfidentialVM SecurityType.
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether each node is allocated its own public IPv4 address. This is only supported on secondary node types with custom Load Balancers.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableNodePublicIP?: boolean;

  /**
   * Specifies whether each node is allocated its own public IPv6 address. This is only supported on secondary node types with custom Load Balancers.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableNodePublicIPv6?: boolean;

  /**
   * Indicates the resource id of the vm shared galleries image. This parameter is used for custom vm image.
   */
  vmSharedGalleryImageId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/sharedGalleries/images";
    },
    {
      type: "Microsoft.Compute/sharedGalleries/images/versions";
    }
  ]>;

  /**
   * Specifies the resource id of a NAT Gateway to attach to the subnet of this node type. Node type must use custom load balancer.
   */
  natGatewayId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/natGateways";
    }
  ]>;

  /**
   * Specifies the NAT configuration on default public Load Balancer for the node type. This is only supported for node types use the default public Load Balancer.
   */
  @identifiers(#[])
  natConfigurations?: NodeTypeNatConfig[];

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.
   */
  vmImagePlan?: VmImagePlan;

  /**
   * Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.
   */
  serviceArtifactReferenceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/galleries/serviceArtifacts/vmArtifactsProfiles";
    }
  ]>;

  /**
   * Specifies the resource id of the DSCP configuration to apply to the node type network interface.
   */
  dscpConfigurationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/dscpConfigurations";
    }
  ]>;

  /**
   * Specifies the settings for any additional secondary network interfaces to attach to the node type.
   */
  @identifiers(#["name"])
  additionalNetworkInterfaceConfigurations?: AdditionalNetworkInterfaceConfiguration[];

  /**
   * Specifies the computer name prefix. Limited to 9 characters. If specified, allows for a longer name to be specified for the node type name.
   */
  computerNamePrefix?: string;

  /**
   * Specifies the gallery applications that should be made available to the underlying VMSS.
   */
  @identifiers(#[])
  vmApplications?: VmApplication[];

  /**
   * 	Setting this to true allows stateless node types to scale out without equal distribution across zones.
   */
  @added(Versions.v2025_03_01_preview)
  zoneBalance?: boolean;
}

/**
 * Specifies the settings for a network interface to attach to the node type.
 */
model AdditionalNetworkInterfaceConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies the DSCP configuration to apply to the network interface.
   */
  dscpConfiguration?: SubResource;

  /**
   * Specifies the IP configurations of the network interface.
   */
  @identifiers(#["name"])
  ipConfigurations: IpConfiguration[];
}

/**
 * Specifies an IP configuration of the network interface.
 */
model IpConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies an array of references to backend address pools of application gateways. A node type can reference backend address pools of multiple application gateways. Multiple node types cannot use the same application gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A node type can reference backend address pools of one public and one internal load balancer. Multiple node types cannot use the same basic sku load balancer.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to inbound Nat pools of the load balancers. A node type can reference inbound nat pools of one public and one internal load balancer. Multiple node types cannot use the same basic sku load balancer.
   */
  loadBalancerInboundNatPools?: SubResource[];

  /**
   * Specifies the subnet of the network interface.
   */
  subnet?: SubResource;

  /**
   * Specifies whether the IP configuration's private IP is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  privateIPAddressVersion?: PrivateIPAddressVersion = PrivateIPAddressVersion.IPv4;

  /**
   * The public IP address configuration of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPAddressConfiguration?: PublicIPAddressConfiguration;
}

/**
 * The public IP address configuration of the network interface.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
model PublicIPAddressConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies the list of IP tags associated with the public IP address.
   */
  @identifiers(#[])
  ipTags?: IpTag[];

  /**
   * Specifies whether the IP configuration's public IP is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPAddressVersion?: PublicIPAddressVersion = PublicIPAddressVersion.IPv4;
}

/**
 * Specifies the gallery application that should be made available to the underlying VMSS.
 */
model VmApplication {
  /**
   * Optional, Specifies the uri to an azure blob that will replace the default configuration for the package if provided.
   */
  configurationReference?: url;

  /**
   * If set to true, when a new Gallery Application version is available in PIR/SIG, it will be automatically updated for the underlying VMSS.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Optional, Specifies the order in which the packages have to be installed.
   */
  order?: int32;

  /**
   * Specifies the GalleryApplicationVersion resource id on the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}.
   */
  packageReferenceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/galleries/applications/versions";
    }
  ]>;

  /**
   * Optional, Specifies a passthrough value for more generic context. Accepts a JSON-formatted string e.g. '{"Tag1":"Value1","Tag2":"Value2"}'.
   */
  vmGalleryTags?: string;

  /**
   * Optional, If true, any failure for any operation in the VmApplication will fail the deployment.
   */
  treatFailureAsDeploymentFailure?: boolean;
}

/**
 * Describes a node type sku.
 */
model NodeTypeSku {
  /**
   * The sku name. Name is internally generated and is used in auto-scale scenarios. Property does not allow to be changed to other values than generated. To avoid deployment errors please omit the property.
   */
  name?: string;

  /**
   * Specifies the tier of the node type. Possible Values: **Standard**
   */
  tier?: string;

  /**
   * The number of nodes in the node type. If present in request it will override properties.vmInstanceCount.
   */
  @maxValue(2147483647)
  @minValue(1)
  capacity: int32;
}

/**
 * Node type update request
 */
model NodeTypeUpdateParameters {
  /**
   * Node type update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;

  /**
   * The node type sku.
   */
  sku?: NodeTypeSku;
}

/**
 * Parameters for Node type action. If nodes are not specified on the parameters, the operation will be performed in all nodes of the node type one upgrade domain at a time.
 */
model NodeTypeActionParameters {
  /**
   * List of node names from the node type.
   */
  nodes?: string[];

  /**
   * Force the action to go through.
   */
  force?: boolean;

  /**
   * Specifies the way the operation will be performed.
   */
  updateType?: UpdateType;
}

/**
 * Node type available sku list results
 */
model NodeTypeListSkuResult is Azure.Core.Page<NodeTypeAvailableSku>;

/**
 * Defines the type of sku available for a node type
 */
model NodeTypeAvailableSku {
  /**
   * The type of resource the sku applies to. Value: Microsoft.ServiceFabric/managedClusters/nodeTypes.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The supported SKU for a for node type.
   */
  @visibility(Lifecycle.Read)
  sku?: NodeTypeSupportedSku;

  /**
   * Provides information about how the node count can be scaled.
   */
  @visibility(Lifecycle.Read)
  capacity?: NodeTypeSkuCapacity;
}

/**
 * Describes a node type supported sku.
 */
model NodeTypeSupportedSku {
  /**
   * The sku name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Specifies the tier of the node type. Possible Values: **Standard**
   */
  @visibility(Lifecycle.Read)
  tier?: string;
}

/**
 * Provides information about how node type can be scaled.
 */
model NodeTypeSkuCapacity {
  /**
   * Lowest permitted node count in a node type.
   */
  @visibility(Lifecycle.Read)
  minimum?: int32;

  /**
   * Highest permitted node count in a node type.
   */
  @visibility(Lifecycle.Read)
  maximum?: int32;

  /**
   * Default node count in a node type.
   */
  @visibility(Lifecycle.Read)
  default?: int32;

  /**
   * Node type capacity scale type.
   */
  @visibility(Lifecycle.Read)
  scaleType?: NodeTypeSkuScaleType = NodeTypeSkuScaleType.None;
}

/**
 * Port range details
 */
model EndpointRangeDescription {
  /**
   * Starting port of a range of ports
   */
  startPort: int32;

  /**
   * End port of a range of ports
   */
  endPort: int32;
}

/**
 * Specifies set of certificates that should be installed onto the virtual machines.
 */
model VaultSecretGroup {
  /**
   * The relative URL of the Key Vault containing all of the certificates in VaultCertificates.
   */
  sourceVault: SubResource;

  /**
   * The list of key vault references in SourceVault which contain certificates.
   */
  @identifiers(#[])
  vaultCertificates: VaultCertificate[];
}

/**
 * Azure resource identifier.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "backwards compatibility to match existing spec"
@OpenAPI.extension("x-ms-azure-resource", true)
model SubResource {
  /**
   * Azure resource identifier.
   */
  id?: string;
}

/**
 * Describes a single certificate reference in a Key Vault, and where the certificate should reside on the VM.
 */
model VaultCertificate {
  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   */
  certificateUrl: string;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name {UppercaseThumbprint}.crt for the X509 certificate file and {UppercaseThumbprint}.prv for private key. Both of these files are .pem formatted.
   */
  certificateStore: string;
}

/**
 * Specifies set of extensions that should be installed onto the virtual machines.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Backwards compatibility, VMSS is a well-known acronym"
model VMSSExtension {
  /**
   * The name of the extension.
   */
  name: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Backwards compatibility with existing flatten"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: VMSSExtensionProperties;
}
/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Backwards compatibility, VMSS is a well-known acronym"
model VMSSExtensionProperties {
  /**
   * The name of the extension handler publisher.
   */
  publisher: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Day 0 property"
  settings?: unknown;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Day 0 property"
  protectedSettings?: unknown;

  /**
   * If a value is provided and is different from the previous value, the extension handler will be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * Collection of extension names after which this extension needs to be provisioned.
   */
  provisionAfterExtensions?: string[];

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates the setup order for the extension.
   */
  setupOrder?: VmssExtensionSetupOrder[];
}

/**
 * Identities for the virtual machine scale set under the node type.
 */
model VmManagedIdentity {
  /**
   * The list of user identities associated with the virtual machine scale set under the node type. Each entry will be an ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: string[];
}

/**
 * Describes the frontend configurations for the node type.
 */
model FrontendConfiguration {
  /**
   * The IP address type of this frontend configuration. If omitted the default value is IPv4.
   */
  ipAddressType?: IPAddressType = IPAddressType.IPv4;

  /**
   * The resource Id of the Load Balancer backend address pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'.
   */
  loadBalancerBackendAddressPoolId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource Id of the Load Balancer inbound NAT pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatPools/{inboundNatPoolName}'.
   */
  loadBalancerInboundNatPoolId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource Id of application gateway backend address pool. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/backendAddressPools/{backendAddressPoolName}'.
   */
  applicationGatewayBackendAddressPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationGateways/backendAddressPools";
    }
  ]>;
}

/**
 * Managed data disk description.
 */
model VmssDataDisk {
  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM. Lun 0 is reserved for the service fabric data disk.
   */
  @minValue(1)
  lun: int32;

  /**
   * Disk size for each vm in the node type in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is a well known abbreviation"
  diskSizeGB: int32;

  /**
   * Managed data disk type. Specifies the storage account type for the managed disk
   */
  diskType: DiskType = DiskType.StandardSSD_LRS;

  /**
   * Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.
   */
  @pattern("^[a-zA-Z]{1}$")
  diskLetter: string;
}

/**
 * Provides information about NAT configuration on the default public Load Balancer for the node type.
 */
model NodeTypeNatConfig {
  /**
   * The internal port for the NAT configuration.
   */
  @maxValue(65535)
  @minValue(1)
  backendPort?: int32;

  /**
   * The port range start for the external endpoint.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPortRangeStart?: int32;

  /**
   * The port range end for the external endpoint.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPortRangeEnd?: int32;
}

/**
 * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started. Enter any required information and then click Save.
 */
model VmImagePlan {
  /**
   * The plan ID.
   */
  name?: string;

  /**
   * Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;
}

/**
 * Managed data disk type. IOPS and throughput are given by the disk size, to see more information go to https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types.
 *
 */
union DiskType {
  string,

  /**
   * Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.
   */
  StandardSSD_LRS: "StandardSSD_LRS",

  /**
   * Premium SSD locally redundant storage. Best for production and performance sensitive workloads.
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Premium SSD V2 locally redundant storage. Best for production and performance sensitive workloads that consistently require low latency and high IOPS and throughput.
   */
  PremiumV2_LRS: "PremiumV2_LRS",

  /**
   * Standard SSD zone redundant storage. Best for web servers, lightly used enterprise applications and dev/test that need storage resiliency against zone failures.
   */
  StandardSSD_ZRS: "StandardSSD_ZRS",

  /**
   * Premium SSD zone redundant storage. Best for production workloads that need storage resiliency against zone failures.
   */
  Premium_ZRS: "Premium_ZRS",
}

/**
 * Vm extension setup order.
 *
 */
union VmssExtensionSetupOrder {
  string,

  /**
   * Indicates that the vm extension should run before the service fabric runtime starts.
   */
  BeforeSFRuntime: "BeforeSFRuntime",
}

/**
 * The IP address type.
 *
 */
union IPAddressType {
  string,

  /**
   * IPv4 address type.
   */
  IPv4: "IPv4",

  /**
   * IPv6 address type.
   */
  IPv6: "IPv6",
}

/**
 * Specifies the eviction policy for virtual machines in a SPOT node type.
 */
union EvictionPolicyType {
  string,

  /**
   * Eviction policy will be Delete for SPOT vms.
   */
  Delete: "Delete",

  /**
   * Eviction policy will be Deallocate for SPOT vms.
   */
  Deallocate: "Deallocate",
}

/**
 * action to be performed on the vms before bootstrapping the service fabric runtime.
 */
union VmSetupAction {
  string,

  /**
   * Enable windows containers feature.
   */
  EnableContainers: "EnableContainers",

  /**
   * Enables windows HyperV feature.
   */
  EnableHyperV: "EnableHyperV",
}

/**
 * Specifies the security type of the nodeType. Only Standard and TrustedLaunch are currently supported
 */
union SecurityType {
  string,

  /**
   * Trusted Launch is a security type that secures generation 2 virtual machines.
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * Standard is the default security type for all machines.
   */
  Standard: "Standard",

  /**
   * ConfidentialVM provides hardware-based encryption, trusted execution environment (TEE) and isolation of the VM memory & CPU from host.
   */
  ConfidentialVM: "ConfidentialVM",
}

/**
 * Specifies the securityEncryptionType type of the nodeType. Only DiskWithVMGuestState and VMGuestStateOnly are currently supported
 */
union SecurityEncryptionType {
  string,

  /**
   * For encryption of the managed disk along with VMGuestState blob.
   */
  DiskWithVMGuestState: "DiskWithVMGuestState",

  /**
   * For encryption of just the VMGuestState blob.
   */
  VMGuestStateOnly: "VMGuestStateOnly",
}

/**
 * Specifies whether the IP configuration's private IP is IPv4 or IPv6. Default is IPv4.
 */
union PrivateIPAddressVersion {
  string,

  /**
   * The IP configuration's private IP is IPv4.
   */
  IPv4: "IPv4",

  /**
   * The IP configuration's private IP is IPv6.
   */
  IPv6: "IPv6",
}

/**
 * Specifies whether the IP configuration's public IP is IPv4 or IPv6. Default is IPv4.
 */
union PublicIPAddressVersion {
  string,

  /**
   * The IP configuration's public IP is IPv4.
   */
  IPv4: "IPv4",

  /**
   * The IP configuration's public IP is IPv6.
   */
  IPv6: "IPv6",
}

/**
 * Specifies the way the operation will be performed.
 */
union UpdateType {
  string,

  /**
   * The operation will proceed in all specified nodes at the same time.
   */
  Default: "Default",

  /**
   * The operation will proceed one upgrade domain at a time, checking the health in between each to continue.
   */
  ByUpgradeDomain: "ByUpgradeDomain",
}

/**
 * Node type capacity scale type.
 *
 */
union NodeTypeSkuScaleType {
  string,

  /**
   * Node count is not adjustable in any way (e.g. it is fixed).
   */
  None: "None",

  /**
   * The user must manually scale out/in.
   */
  Manual: "Manual",

  /**
   * Automatic scale is allowed.
   */
  Automatic: "Automatic",
}

@@identifiers(NodeTypeListSkuResult.value, #[]);
