import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-12-01-preview`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@doc("A Microsoft.GCPConnector resource")
@singleton
model ComputeInstance is ExtensionResource<InstanceProperties> {
  @doc("Name of ComputeInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("computeInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of ComputeInstance")
model InstanceProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpComputeInstanceProperties;

  ...GcpCommonProperties;
}

/**
 * A specification of the type and number of accelerator cards attached to the instance.
 */
model AcceleratorConfig {
  /**
   * The number of the guest accelerator cards exposed to this instance.
   */
  acceleratorCount?: int32;

  /**
   * Full or partial URL of the accelerator type resource to attach to this instance. For example: projects/my-project/zones/us-central1-c/acceleratorTypes/nvidia-tesla-p100 If you are creating an instance template, specify only the accelerator name. See GPUs on Compute Engine for a full list of accelerator types.
   */
  acceleratorType?: string;
}

/**
 * Specifies options for controlling advanced machine features. Options that would traditionally be configured in a BIOS belong here. Features that require operating system support may have corresponding entries in the GuestOsFeatures of an Image (e.g., whether or not the OS in the Image supports nested virtualization being enabled or disabled).
 */
model AdvancedMachineFeatures {
  /**
   * Whether to enable nested virtualization or not (default is false).
   */
  enableNestedVirtualization?: boolean;

  /**
   * Whether to enable UEFI networking for instance creation.
   */
  enableUefiNetworking?: boolean;

  /**
   * The number of threads per physical core. To disable simultaneous multithreading (SMT) set this to 1. If unset, the maximum number of threads supported per core by the underlying processor is assumed.
   */
  threadsPerCore?: int32;

  /**
   * The number of physical cores to expose to an instance. Multiply by the number of threads per core to compute the total number of virtual CPUs to expose to the instance. If unset, the number of cores is inferred from the instance's nominal CPU count and the underlying platform's SMT width.
   */
  visibleCoreCount?: int32;
}

/**
 * An alias IP range attached to an instance's network interface.
 */
model AliasIpRange {
  /**
   * The IP alias ranges to allocate for this interface. This IP CIDR range must belong to the specified subnetwork and cannot contain IP addresses reserved by system or used by other network interfaces. This range may be a single IP address (such as 10.2.3.4), a netmask (such as /24) or a CIDR-formatted string (such as 10.1.2.0/24).
   */
  ipCidrRange?: string;

  /**
   * The name of a subnetwork secondary IP range from which to allocate an IP alias range. If not specified, the primary range of the subnetwork is used.
   */
  subnetworkRangeName?: string;
}

/**
 * This reservation type is specified by total resource amounts (e.g. total count of CPUs) and can account for multiple instance SKUs. In other words, one can create instances of varying shapes against this reservation.
 */
model AllocationAggregateReservation {
  /**
   * [Output only] List of resources currently in use.
   */
  @extension("x-ms-identifiers", #[])
  inUseResources?: AllocationAggregateReservationReservedResourceInfo[];

  /**
   * List of reserved resources (CPUs, memory, accelerators).
   */
  @extension("x-ms-identifiers", #[])
  reservedResources?: AllocationAggregateReservationReservedResourceInfo[];

  /**
   * The VM family that all instances scheduled against this reservation must belong to.
   */
  vmFamily?:
    | "VM_FAMILY_CLOUD_TPU_LITE_DEVICE_CT5L"
    | "VM_FAMILY_CLOUD_TPU_LITE_POD_SLICE_CT5LP"
    | "VM_FAMILY_CLOUD_TPU_POD_SLICE_CT4P"
    | string;

  /**
   * The workload type of the instances that will target this reservation.
   */
  workloadType?: "BATCH" | "SERVING" | "UNSPECIFIED" | string;
}

/**
 * Allocation Aggregate Reservation Reserved Resource Info.
 */
model AllocationAggregateReservationReservedResourceInfo {
  /**
   * Properties of accelerator resources in this reservation.
   */
  accelerator?: AllocationAggregateReservationReservedResourceInfoAccelerator;
}

/**
 * Allocation Aggregate Reservation Reserved Resource Info Accelerator.
 */
model AllocationAggregateReservationReservedResourceInfoAccelerator {
  /**
   * Number of accelerators of specified type.
   */
  acceleratorCount?: int32;

  /**
   * Full or partial URL to accelerator type. e.g. "projects/{PROJECT}/zones/{ZONE}/acceleratorTypes/ct4l"
   */
  acceleratorType?: string;
}

/**
 * [Output Only] Contains output only fields.
 */
model AllocationResourceStatus {
  /**
   * Allocation Properties of this reservation.
   */
  specificSkuAllocation?: AllocationResourceStatusSpecificSKUAllocation;
}

/**
 * Contains Properties set for the reservation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
model AllocationResourceStatusSpecificSKUAllocation {
  /**
   * ID of the instance template used to populate reservation properties.
   */
  sourceInstanceTemplateId?: string;
}

/**
 * Allocation Specific SKU Allocation Allocated InstanceP roperties Reserved Disk.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
model AllocationSpecificSKUAllocationAllocatedInstancePropertiesReservedDisk {
  /**
   * Specifies the size of the disk in base-2 GB.
   */
  diskSizeGb?: string;

  /**
   * Specifies the disk interface to use for attaching this disk, which is either SCSI or NVME. The default is SCSI. For performance characteristics of SCSI over NVMe, see Local SSD performance.
   */
  `interface`?: "NVME" | "SCSI" | string;
}

/**
 * An instance-attached disk resource.
 */
model AttachedDisk {
  /**
   * [Output Only] The architecture of the attached disk. Valid values are ARM64 or X86_64.
   */
  architecture?: "ARCHITECTURE_UNSPECIFIED" | "ARM64" | "X86_64" | string;

  /**
   * Specifies whether the disk will be auto-deleted when the instance is deleted (but not when the disk is detached from the instance).
   */
  autoDelete?: boolean;

  /**
   * Indicates that this is a boot disk. The virtual machine will use the first partition of the disk for its root filesystem.
   */
  boot?: boolean;

  /**
   * Specifies a unique device name of your choice that is reflected into the /dev/disk/by-id/google-* tree of a Linux operating system running within the instance. This name can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, the server chooses a default device name to apply to this disk, in the form persistent-disk-x, where x is a number assigned by Google Compute Engine. This field is only applicable for persistent disks.
   */
  deviceName?: string;

  /**
   * Encrypts or decrypts a disk using a customer-supplied encryption key. If you are creating a new disk, this field encrypts the new disk using an encryption key that you provide. If you are attaching an existing disk that is already encrypted, this field decrypts the disk using the customer-supplied encryption key. If you encrypt a disk using a customer-supplied key, you must provide the same key again when you attempt to use this resource at a later time. For example, you must provide the key when you create a snapshot or an image from the disk or when you attach the disk to a virtual machine instance. If you do not provide an encryption key, then the disk will be encrypted using an automatically generated key and you do not need to provide a key to use the disk later. Instance templates do not store customer-supplied encryption keys, so you cannot use your own keys to encrypt disks in a managed instance group.
   */
  diskEncryptionKey?: CustomerEncryptionKey;

  /**
   * The size of the disk in GB.
   */
  diskSizeGb?: string;

  /**
   * [Input Only] Whether to force attach the regional disk even if it's currently attached to another instance. If you try to force attach a zonal disk to an instance, you will receive an error.
   */
  forceAttach?: boolean;

  /**
   * A list of features to enable on the guest operating system. Applicable only for bootable images. Read Enabling guest operating system features to see a list of available options.
   */
  @extension("x-ms-identifiers", #[])
  guestOsFeatures?: GuestOsFeature[];

  /**
   * [Output Only] A zero-based index to this disk, where 0 is reserved for the boot disk. If you have many disks attached to an instance, each disk would have a unique index number.
   */
  index?: int32;

  /**
   * [Input Only] Specifies the parameters for a new disk that will be created alongside the new instance. Use initialization parameters to create boot disks or local SSDs attached to the new instance. This property is mutually exclusive with the source property; you can only define one or the other, but not both.
   */
  initializeParams?: AttachedDiskInitializeParams;

  /**
   * Specifies the disk interface to use for attaching this disk, which is either SCSI or NVME. For most machine types, the default is SCSI. Local SSDs can use either NVME or SCSI. In certain configurations, persistent disks can use NVMe. For more information, see About persistent disks.
   */
  `interface`?: "NVME" | "SCSI" | string;

  /**
   * [Output Only] Type of the resource. Always compute#attachedDisk for attached disks.
   */
  kind?: string = "compute#attachedDisk";

  /**
   * [Output Only] Any valid publicly visible licenses.
   */
  licenses?: string[];

  /**
   * The mode in which to attach this disk, either READ_WRITE or READ_ONLY. If not specified, the default is to attach the disk in READ_WRITE mode.
   */
  mode?: "READ_ONLY" | "READ_WRITE" | string;

  /**
   * For LocalSSD disks on VM Instances in STOPPED or SUSPENDED state, this field is set to PRESERVED if the LocalSSD data has been saved to a persistent location by customer request. (see the discard_local_ssd option on Stop/Suspend). Read-only in the api.
   */
  savedState?: "DISK_SAVED_STATE_UNSPECIFIED" | "PRESERVED" | string;

  /**
   * [Output Only] shielded vm initial state stored on disk
   */
  shieldedInstanceInitialState?: InitialStateConfig;

  /**
   * Specifies a valid partial or full URL to an existing Persistent Disk resource. When creating a new instance, one of initializeParams.sourceImage or initializeParams.sourceSnapshot or disks.source is required except for local SSD. If desired, you can also attach existing non-root persistent disks using this property. This field is only applicable for persistent disks. Note that for InstanceTemplate, specify the disk name for zonal disk, and the URL for regional disk.
   */
  source?: string;

  /**
   * Specifies the type of the disk, either SCRATCH or PERSISTENT. If not specified, the default is PERSISTENT.
   */
  type?: "PERSISTENT" | "SCRATCH" | string;
}

/**
 * [Input Only] Specifies the parameters for a new disk that will be created alongside the new instance. Use initialization parameters to create boot disks or local SSDs attached to the new instance. This field is persisted and returned for instanceTemplate and not returned in the context of instance. This property is mutually exclusive with the source property; you can only define one or the other, but not both.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model AttachedDiskInitializeParams {
  /**
   * The architecture of the attached disk. Valid values are arm64 or x86_64.
   */
  architecture?: "ARCHITECTURE_UNSPECIFIED" | "ARM64" | "X86_64" | string;

  /**
   * An optional description. Provide this property when creating the disk.
   */
  description?: string;

  /**
   * Specifies the disk name. If not specified, the default is to use the name of the instance. If a disk with the same name already exists in the given region, the existing disk is attached to the new instance and the new disk is not created.
   */
  diskName?: string;

  /**
   * Specifies the size of the disk in base-2 GB. The size must be at least 10 GB. If you specify a sourceImage, which is required for boot disks, the default size is the size of the sourceImage. If you do not specify a sourceImage, the default disk size is 500 GB.
   */
  diskSizeGb?: string;

  /**
   * Specifies the disk type to use to create the instance. If not specified, the default is pd-standard, specified using the full URL. For example: https://www.googleapis.com/compute/v1/projects/project/zones/zone /diskTypes/pd-standard For a full list of acceptable values, see Persistent disk types. If you specify this field when creating a VM, you can provide either the full or partial URL. For example, the following values are valid: - https://www.googleapis.com/compute/v1/projects/project/zones/zone /diskTypes/diskType - projects/project/zones/zone/diskTypes/diskType - zones/zone/diskTypes/diskType If you specify this field when creating or updating an instance template or all-instances configuration, specify the type of the disk, not the URL. For example: pd-standard.
   */
  diskType?: string;

  /**
   * Whether this disk is using confidential compute mode.
   */
  enableConfidentialCompute?: boolean;

  /**
   * Labels to apply to this disk. These can be later modified by the disks.setLabels method. This field is only applicable for persistent disks.
   */
  labels?: Record<string>;

  /**
   * A list of publicly visible licenses. Reserved for Google's use.
   */
  licenses?: string[];

  /**
   * Specifies which action to take on instance update with this disk. Default is to use the existing disk.
   */
  onUpdateAction?:
    | "RECREATE_DISK"
    | "RECREATE_DISK_IF_SOURCE_CHANGED"
    | "USE_EXISTING_DISK"
    | string;

  /**
   * Indicates how many IOPS to provision for the disk. This sets the number of I/O operations per second that the disk can handle. Values must be between 10,000 and 120,000. For more details, see the Extreme persistent disk documentation.
   */
  provisionedIops?: string;

  /**
   * Indicates how much throughput to provision for the disk. This sets the number of throughput mb per second that the disk can handle. Values must greater than or equal to 1.
   */
  provisionedThroughput?: string;

  /**
   * Required for each regional disk associated with the instance. Specify the URLs of the zones where the disk should be replicated to. You must provide exactly two replica zones, and one zone must be the same as the instance zone.
   */
  replicaZones?: string[];

  /**
   * Resource manager tags to be bound to the disk. Tag keys and values have the same definition as resource manager tags. Keys must be in the format `tagKeys/{tag_key_id}`, and values are in the format `tagValues/456`. The field is ignored (both PUT & PATCH) when empty.
   */
  resourceManagerTags?: Record<string>;

  /**
   * Resource policies applied to this disk for automatic snapshot creations. Specified using the full or partial URL. For instance template, specify only the resource policy name.
   */
  resourcePolicies?: string[];

  /**
   * The source image to create this disk. When creating a new instance, one of initializeParams.sourceImage or initializeParams.sourceSnapshot or disks.source is required except for local SSD. To create a disk with one of the public operating system images, specify the image by its family name. For example, specify family/debian-9 to use the latest Debian 9 image: projects/debian-cloud/global/images/family/debian-9 Alternatively, use a specific version of a public operating system image: projects/debian-cloud/global/images/debian-9-stretch-vYYYYMMDD To create a disk with a custom image that you created, specify the image name in the following format: global/images/my-custom-image You can also specify a custom image by its image family, which returns the latest version of the image in that family. Replace the image name with family/family-name: global/images/family/my-image-family If the source image is deleted later, this field will not be set.
   */
  sourceImage?: string;

  /**
   * The customer-supplied encryption key of the source image. Required if the source image is protected by a customer-supplied encryption key. InstanceTemplate and InstancePropertiesPatch do not store customer-supplied encryption keys, so you cannot create disks for instances in a managed instance group if the source images are encrypted with your own keys.
   */
  sourceImageEncryptionKey?: CustomerEncryptionKey;

  /**
   * The source snapshot to create this disk. When creating a new instance, one of initializeParams.sourceSnapshot or initializeParams.sourceImage or disks.source is required except for local SSD. To create a disk with a snapshot that you created, specify the snapshot name in the following format: global/snapshots/my-backup If the source snapshot is deleted later, this field will not be set.
   */
  sourceSnapshot?: string;

  /**
   * The customer-supplied encryption key of the source snapshot.
   */
  sourceSnapshotEncryptionKey?: CustomerEncryptionKey;
}

/**
 * Customer Encryption Key.
 */
model CustomerEncryptionKey {
  /**
   * The name of the encryption key that is stored in Google Cloud KMS. For example: "kmsKeyName": "projects/kms_project_id/locations/region/keyRings/ key_region/cryptoKeys/key The fully-qualifed key name may be returned for resource GET requests. For example: "kmsKeyName": "projects/kms_project_id/locations/region/keyRings/ key_region/cryptoKeys/key /cryptoKeyVersions/1
   */
  kmsKeyName?: string;

  @doc("The service account being used for the encryption request for the given KMS key. If absent, the Compute Engine default service account is used. For example: \"kmsKeyServiceAccount\": \"name@project_id.iam.gserviceaccount.com/ ")
  kmsKeyServiceAccount?: string;

  /**
   * Specifies a 256-bit customer-supplied encryption key, encoded in RFC 4648 base64 to either encrypt or decrypt this resource. You can provide either the rawKey or the rsaEncryptedKey. For example: "rawKey": "SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0="
   */
  @secret
  rawKey?: string;

  /**
   * Specifies an RFC 4648 base64 encoded, RSA-wrapped 2048-bit customer-supplied encryption key to either encrypt or decrypt this resource. You can provide either the rawKey or the rsaEncryptedKey. For example: "rsaEncryptedKey": "ieCx/NcW06PcT7Ep1X6LUTc/hLvUDYyzSZPPVCVPTVEohpeHASqC8uw5TzyO9U+Fka9JFH z0mBibXUInrC/jEk014kCK/NPjYgEMOyssZ4ZINPKxlUh2zn1bV+MCaTICrdmuSBTWlUUiFoD D6PYznLwh8ZNdaheCeZ8ewEXgFQ8V+sDroLaN3Xs3MDTXQEMMoNUXMCZEIpg9Vtp9x2oe==" The key must meet the following requirements before you can provide it to Compute Engine: 1. The key is wrapped using a RSA public key certificate provided by Google. 2. After being wrapped, the key must be encoded in RFC 4648 base64 encoding. Gets the RSA public key certificate provided by Google at: https://cloud-certs.storage.googleapis.com/google-cloud-csek-ingress.pem
   */
  @secret
  rsaEncryptedKey?: string;

  /**
   * [Output only] The RFC 4648 base64 encoded SHA-256 hash of the customer-supplied encryption key that protects this resource.
   */
  @secret
  sha256?: string;
}

/**
 * Contains output only fields. Use this sub-message for actual values set on Instance attributes as compared to the value requested by the user (intent) in their instance CRUD calls.
 */
model ResourceStatus {
  /**
   * [Output Only] An opaque ID of the host on which the VM is running.
   */
  physicalHost?: string;

  /**
   * Upcoming Maintenance.
   */
  upcomingMaintenance?: UpcomingMaintenance;
}

/**
 * Specifies the reservations that this instance can consume from.
 */
model ReservationAffinity {
  /**
   * Specifies the type of reservation from which this instance can consume resources: ANY_RESERVATION (default), SPECIFIC_RESERVATION, or NO_RESERVATION. See Consuming reserved instances for examples.
   */
  consumeReservationType?:
    | "ANY_RESERVATION"
    | "NO_RESERVATION"
    | "SPECIFIC_RESERVATION"
    | "UNSPECIFIED"
    | string;

  /**
   * Corresponds to the label key of a reservation resource. To target a SPECIFIC_RESERVATION by name, specify googleapis.com/reservation-name as the key and specify the name of your reservation as its value.
   */
  key?: string;

  /**
   * Corresponds to the label values of a reservation resource. This can be either a name to a reservation in the same project or "projects/different-project/reservations/some-reservation-name" to target a shared reservation in the same zone but in a different project.
   */
  values?: string[];
}

/**
 * A Duration represents a fixed-length span of time represented as a count of seconds and fractions of seconds at nanosecond resolution. It is independent of any calendar and concepts like "day" or "month". Range is approximately 10,000 years.
 */
model Duration {
  /**
   * Span of time that's a fraction of a second at nanosecond resolution. Durations less than one second are represented with a 0 `seconds` field and a positive `nanos` field. Must be from 0 to 999,999,999 inclusive.
   */
  nanos?: int32;

  /**
   * Span of time at a resolution of a second. Must be from 0 to 315,576,000,000 inclusive. Note: these bounds are computed from: 60 sec/min * 60 min/hr * 24 hr/day * 365.25 days/year * 10000 years
   */
  seconds?: string;
}

/**
 * Node Affinity: the configuration of desired nodes onto which this Instance could be scheduled.
 */
model SchedulingNodeAffinity {
  /**
   * Corresponds to the label key of Node resource.
   */
  key?: string;

  /**
   * Defines the operation of node selection. Valid operators are IN for affinity and NOT_IN for anti-affinity.
   */
  operator?: "IN" | "NOT_IN" | "OPERATOR_UNSPECIFIED" | string;

  /**
   * Corresponds to the label values of Node resource.
   */
  values?: string[];
}

/**
 * A set of instance tags.
 */
model Tags {
  /**
   * Specifies a fingerprint for this request, which is essentially a hash of the tags' contents and used for optimistic locking. The fingerprint is initially generated by Compute Engine and changes after every request to modify or update tags. You must always provide an up-to-date fingerprint hash in order to update or change tags. To see the latest fingerprint, make get() request to the instance.
   */
  fingerprint?: bytes;

  /**
   * An array of tags. Each tag must be 1-63 characters long, and comply with RFC1035.
   */
  items?: string[];
}

/**
 * Sets the scheduling options for an Instance.
 */
model Scheduling {
  /**
   * Specifies whether the instance should be automatically restarted if it is terminated by Compute Engine (not terminated by a user). You can only set the automatic restart option for standard instances. Preemptible instances cannot be automatically restarted. By default, this is set to true so an instance is automatically restarted if it is terminated by Compute Engine.
   */
  automaticRestart?: boolean;

  /**
   * Specifies the termination action for the instance.
   */
  instanceTerminationAction?:
    | "DELETE"
    | "INSTANCE_TERMINATION_ACTION_UNSPECIFIED"
    | "STOP"
    | string;

  /**
   * Specifies the maximum amount of time a Local Ssd Vm should wait while recovery of the Local Ssd state is attempted. Its value should be in between 0 and 168 hours with hour granularity and the default value being 1 hour.
   */
  localSsdRecoveryTimeout?: Duration;

  /**
   * An opaque location hint used to place the instance close to other resources. This field is for use by internal tools that use the public API.
   */
  locationHint?: string;

  /**
   * The minimum number of virtual CPUs this instance will consume when running on a sole-tenant node.
   */
  minNodeCpus?: int32;

  /**
   * A set of node affinity and anti-affinity configurations. Refer to Configuring node affinity for more information. Overrides reservationAffinity.
   */
  @extension("x-ms-identifiers", #[])
  nodeAffinities?: SchedulingNodeAffinity[];

  /**
   * Defines the maintenance behavior for this instance. For standard instances, the default behavior is MIGRATE. For preemptible instances, the default and only possible behavior is TERMINATE. For more information, see Set VM host maintenance policy.
   */
  onHostMaintenance?: "MIGRATE" | "TERMINATE" | string;

  /**
   * Defines whether the instance is preemptible. This can only be set during instance creation or while the instance is stopped and therefore, in a `TERMINATED` state. See Instance Life Cycle for more information on the possible instance states.
   */
  preemptible?: boolean;

  /**
   * Specifies the provisioning model of the instance.
   */
  provisioningModel?: "SPOT" | "STANDARD" | string;
}

/**
 * Bulk Insert Operation Status.
 */
model BulkInsertOperationStatus {
  /**
   * [Output Only] Count of VMs successfully created so far.
   */
  createdVmCount?: int32;

  /**
   * [Output Only] Count of VMs that got deleted during rollback.
   */
  deletedVmCount?: int32;

  /**
   * [Output Only] Count of VMs that started creating but encountered an error.
   */
  failedToCreateVmCount?: int32;

  /**
   * [Output Only] Creation status of BulkInsert operation - information if the flow is rolling forward or rolling back.
   */
  status?: "CREATING" | "DONE" | "ROLLING_BACK" | "STATUS_UNSPECIFIED" | string;

  /**
   * [Output Only] Count of VMs originally planned to be created.
   */
  targetVmCount?: int32;
}

/**
 * A set of Shielded Instance options.
 */
model ShieldedInstanceConfig {
  /**
   * Defines whether the instance has integrity monitoring enabled. Enabled by default.
   */
  enableIntegrityMonitoring?: boolean;

  /**
   * Defines whether the instance has Secure Boot enabled. Disabled by default.
   */
  enableSecureBoot?: boolean;

  /**
   * Defines whether the instance has the vTPM enabled. Enabled by default.
   */
  enableVtpm?: boolean;
}

/**
 * Upcoming Maintenance notification information.
 */
model UpcomingMaintenance {
  /**
   * Indicates if the maintenance can be customer triggered.
   */
  canReschedule?: boolean;

  /**
   * The latest time for the planned maintenance window to start. This timestamp value is in RFC3339 text format.
   */
  latestWindowStartTime?: string;

  /**
   * Maintenance Status.
   */
  maintenanceStatus?: "ONGOING" | "PENDING" | "UNKNOWN" | string;

  /**
   * Defines the type of maintenance.
   */
  type?: "SCHEDULED" | "UNKNOWN_TYPE" | "UNSCHEDULED" | string;

  /**
   * The time by which the maintenance disruption will be completed. This timestamp value is in RFC3339 text format.
   */
  windowEndTime?: string;

  /**
   * The current start time of the maintenance window. This timestamp value is in RFC3339 text format.
   */
  windowStartTime?: string;
}

/**
 * Additional instance params.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model InstanceParams {
  /**
   * Resource manager tags to be bound to the instance. Tag keys and values have the same definition as resource manager tags. Keys must be in the format `tagKeys/{tag_key_id}`, and values are in the format `tagValues/456`. The field is ignored (both PUT & PATCH) when empty.
   */
  resourceManagerTags?: Record<string>;
}

/**
 * The `Status` type defines a logical error model that is suitable for different programming environments, including REST APIs and RPC APIs. It is used by [gRPC](https://github.com/grpc). Each `Status` message contains three pieces of data: error code, error message, and error details. You can find out more about this error model and how to work with it in the [API Design Guide](https://cloud.google.com/apis/design/errors).
 */
model Status {
  /**
   * The status code, which should be an enum value of google.rpc.Code.
   */
  code?: int32;

  /**
   * A list of messages that carry the error details. There is a common set of message types for APIs to use.
   */
  @extension("x-ms-identifiers", #[])
  details?: Record<unknown>[];

  /**
   * A developer-facing error message, which should be in English. Any user-facing error message should be localized and sent in the google.rpc.Status.details field, or localized by the client.
   */
  message?: string;
}

/**
 * An access configuration attached to an instance's network interface. Only one access config per instance is supported.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
model AccessConfig {
  /**
   * Applies to ipv6AccessConfigs only. The first IPv6 address of the external IPv6 range associated with this instance, prefix length is stored in externalIpv6PrefixLength in ipv6AccessConfig. To use a static external IP address, it must be unused and in the same region as the instance's zone. If not specified, Google Cloud will automatically assign an external IPv6 address from the instance's subnetwork.
   */
  externalIpv6?: string;

  /**
   * Applies to ipv6AccessConfigs only. The prefix length of the external IPv6 range.
   */
  externalIpv6PrefixLength?: int32;

  /**
   * [Output Only] Type of the resource. Always compute#accessConfig for access configs.
   */
  kind?: string = "compute#accessConfig";

  /**
   * The name of this access configuration. In accessConfigs (IPv4), the default and recommended name is External NAT, but you can use any arbitrary string, such as My external IP or Network Access. In ipv6AccessConfigs, the recommend name is External IPv6.
   */
  name?: string;

  /**
   * Applies to accessConfigs (IPv4) only. An external IP address associated with this instance. Specify an unused static external IP address available to the project or leave this field undefined to use an IP from a shared ephemeral IP address pool. If you specify a static external IP address, it must live in the same region as the zone of the instance.
   */
  natIP?: string;

  /**
   * This signifies the networking tier used for configuring this access configuration and can only take the following values: PREMIUM, STANDARD. If an AccessConfig is specified without a valid external IP address, an ephemeral IP will be created with this networkTier. If an AccessConfig with a valid external IP address is specified, it must match that of the networkTier associated with the Address resource owning that IP.
   */
  networkTier?:
    | "FIXED_STANDARD"
    | "PREMIUM"
    | "STANDARD"
    | "STANDARD_OVERRIDES_FIXED_STANDARD"
    | string;

  /**
   * The DNS domain name for the public PTR record. You can set this field only if the `setPublicPtr` field is enabled in accessConfig. If this field is unspecified in ipv6AccessConfig, a default PTR record will be createc for first IP in associated external IPv6 range.
   */
  publicPtrDomainName?: string;

  /**
   * [Output Only] The resource URL for the security policy associated with this access config.
   */
  securityPolicy?: string;

  /**
   * Specifies whether a public DNS 'PTR' record should be created to map the external IP address of the instance to a DNS domain name. This field is not used in ipv6AccessConfig. A default PTR record will be created if the VM has external IPv6 range associated.
   */
  setPublicPtr?: boolean;

  /**
   * The type of configuration. In accessConfigs (IPv4), the default and only option is ONE_TO_ONE_NAT. In ipv6AccessConfigs, the default and only option is DIRECT_IPV6.
   */
  type?: "DIRECT_IPV6" | "ONE_TO_ONE_NAT" | string;
}

/**
 * Guest OS features.
 */
model GuestOsFeature {
  /**
   * The ID of a supported feature. To add multiple values, use commas to separate values. Set to one or more of the following values: - VIRTIO_SCSI_MULTIQUEUE - WINDOWS - MULTI_IP_SUBNET - UEFI_COMPATIBLE - GVNIC - SEV_CAPABLE - SUSPEND_RESUME_COMPATIBLE - SEV_LIVE_MIGRATABLE - SEV_SNP_CAPABLE - TDX_CAPABLE - IDPF For more information, see Enabling guest operating system features.
   */
  type?:
    | "FEATURE_TYPE_UNSPECIFIED"
    | "GVNIC"
    | "IDPF"
    | "MULTI_IP_SUBNET"
    | "SECURE_BOOT"
    | "SEV_CAPABLE"
    | "SEV_LIVE_MIGRATABLE"
    | "SEV_LIVE_MIGRATABLE_V2"
    | "SEV_SNP_CAPABLE"
    | "UEFI_COMPATIBLE"
    | "VIRTIO_SCSI_MULTIQUEUE"
    | "WINDOWS"
    | string;
}

/**
 * Initial State for shielded instance, these are public keys which are safe to store in public
 */
model InitialStateConfig {
  /**
   * The Key Database (db).
   */
  @extension("x-ms-identifiers", #[])
  dbs?: FileContentBuffer[];

  /**
   * The forbidden key database (dbx).
   */
  @extension("x-ms-identifiers", #[])
  dbxs?: FileContentBuffer[];

  /**
   * The Key Exchange Key (KEK).
   */
  @extension("x-ms-identifiers", #[])
  keks?: FileContentBuffer[];

  /**
   * The Platform Key (PK).
   */
  pk?: FileContentBuffer;
}

/**
 * Represents an Instance resource. An instance is a virtual machine that is hosted on Google Cloud Platform. For more information, read Virtual Machine Instances.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model GcpComputeInstanceProperties {
  /**
   * Controls for advanced machine-related behavior features.
   */
  advancedMachineFeatures?: AdvancedMachineFeatures;

  /**
   * Allows this instance to send and receive packets with non-matching destination or source IPs. This is required if you plan to use this instance to forward routes. For more information, see Enabling IP Forwarding .
   */
  canIpForward?: boolean;

  /**
   * Confidential Instance Config.
   */
  confidentialInstanceConfig?: ConfidentialInstanceConfig;

  /**
   * [Output Only] The CPU platform used by this instance.
   */
  cpuPlatform?: string;

  /**
   * [Output Only] Creation timestamp in RFC3339 text format.
   */
  creationTimestamp?: string;

  /**
   * Whether the resource should be protected against deletion.
   */
  deletionProtection?: boolean;

  /**
   * An optional description of this resource. Provide this property when you create the resource.
   */
  description?: string;

  /**
   * Array of disks associated with this instance. Persistent disks must be created before you can assign them.
   */
  @extension("x-ms-identifiers", #[])
  disks?: AttachedDisk[];

  /**
   * Enables display device for the instance.
   */
  displayDevice?: DisplayDevice;

  /**
   * Specifies a fingerprint for this resource, which is essentially a hash of the instance's contents and used for optimistic locking. The fingerprint is initially generated by Compute Engine and changes after every request to modify or update the instance. You must always provide an up-to-date fingerprint hash in order to update the instance. To see the latest fingerprint, make get() request to the instance.
   */
  fingerprint?: bytes;

  /**
   * A list of the type and count of accelerator cards attached to the instance.
   */
  @extension("x-ms-identifiers", #[])
  guestAccelerators?: AcceleratorConfig[];

  /**
   * Specifies the hostname of the instance. The specified hostname must be RFC1035 compliant. If hostname is not specified, the default hostname is [INSTANCE_NAME].c.[PROJECT_ID].internal when using the global DNS, and [INSTANCE_NAME].[ZONE].c.[PROJECT_ID].internal when using zonal DNS.
   */
  hostname?: string;

  /**
   * [Output Only] The unique identifier for the resource. This identifier is defined by the server.
   */
  id?: string;

  /**
   * Encrypts suspended data for an instance with a customer-managed encryption key. If you are creating a new instance, this field will encrypt the local SSD and in-memory contents of the instance during the suspend operation. If you do not provide an encryption key when creating the instance, then the local SSD and in-memory contents will be encrypted using an automatically generated key during the suspend operation.
   */
  instanceEncryptionKey?: CustomerEncryptionKey;

  /**
   * KeyRevocationActionType of the instance. Supported options are "STOP" and "NONE". The default value is "NONE" if it is not specified.
   */
  keyRevocationActionType?:
    | "KEY_REVOCATION_ACTION_TYPE_UNSPECIFIED"
    | "NONE"
    | "STOP"
    | string;

  /**
   * [Output Only] Type of the resource. Always compute#instance for instances.
   */
  kind?: string = "compute#instance";

  /**
   * A fingerprint for this request, which is essentially a hash of the label's contents and used for optimistic locking. The fingerprint is initially generated by Compute Engine and changes after every request to modify or update labels. You must always provide an up-to-date fingerprint hash in order to update or change labels. To see the latest fingerprint, make get() request to the instance.
   */
  labelFingerprint?: bytes;

  /**
   * Labels to apply to this instance. These can be later modified by the setLabels method.
   */
  labels?: Record<string>;

  /**
   * [Output Only] Last start timestamp in RFC3339 text format.
   */
  lastStartTimestamp?: string;

  /**
   * [Output Only] Last stop timestamp in RFC3339 text format.
   */
  lastStopTimestamp?: string;

  /**
   * [Output Only] Last suspended timestamp in RFC3339 text format.
   */
  lastSuspendedTimestamp?: string;

  /**
   * Full or partial URL of the machine type resource to use for this instance, in the format: zones/zone/machineTypes/machine-type. This is provided by the client when the instance is created. For example, the following is a valid partial url to a predefined machine type: zones/us-central1-f/machineTypes/n1-standard-1 To create a custom machine type, provide a URL to a machine type in the following format, where CPUS is 1 or an even number up to 32 (2, 4, 6, ... 24, etc), and MEMORY is the total memory for this instance. Memory must be a multiple of 256 MB and must be supplied in MB (e.g. 5 GB of memory is 5120 MB): zones/zone/machineTypes/custom-CPUS-MEMORY For example: zones/us-central1-f/machineTypes/custom-4-5120 For a full list of restrictions, read the Specifications for custom machine types.
   */
  machineType?: string;

  /**
   * The metadata key/value pairs assigned to this instance. This includes custom metadata and predefined keys.
   */
  metadata?: Metadata;

  /**
   * Specifies a minimum CPU platform for the VM instance. Applicable values are the friendly names of CPU platforms, such as minCpuPlatform: "Intel Haswell" or minCpuPlatform: "Intel Sandy Bridge".
   */
  minCpuPlatform?: string;

  /**
   * The name of the resource, provided by the client when initially creating the resource. The resource name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.
   */
  @pattern("[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?") name?: string;

  /**
   * An array of network configurations for this instance. These specify how interfaces are configured to interact with other network services, such as connecting to the internet. Multiple interfaces are supported per instance.
   */
  networkInterfaces?: NetworkInterface[];

  /**
   * The network performance configuration for the instance.
   */
  networkPerformanceConfig?: NetworkPerformanceConfig;

  /**
   * Input only. [Input Only] Additional params passed with the request, but not persisted as part of resource payload.
   */
  params?: InstanceParams;

  /**
   * The private IPv6 google access type for the VM. If not specified, use INHERIT_FROM_SUBNETWORK as default.
   */
  privateIpv6GoogleAccess?:
    | "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"
    | "ENABLE_OUTBOUND_VM_ACCESS_TO_GOOGLE"
    | "INHERIT_FROM_SUBNETWORK"
    | string;

  /**
   * Specifies the reservations that this instance can consume from.
   */
  reservationAffinity?: ReservationAffinity;

  /**
   * Resource policies applied to this instance.
   */
  resourcePolicies?: string[];

  /**
   * [Output Only] Specifies values set for instance attributes as compared to the values requested by user in the corresponding input only field.
   */
  resourceStatus?: ResourceStatus;

  /**
   * [Output Only] Reserved for future use.
   */
  satisfiesPzi?: boolean;

  /**
   * [Output Only] Reserved for future use.
   */
  satisfiesPzs?: boolean;

  /**
   * Sets the scheduling options for this instance.
   */
  scheduling?: Scheduling;

  /**
   * [Output Only] Server-defined URL for this resource.
   */
  selfLink?: string;

  /**
   * A list of service accounts, with their specified scopes, authorized for this instance. Only one service account per VM instance is supported. Service accounts generate access tokens that can be accessed through the metadata server and used to authenticate applications on the instance. See Service Accounts for more information.
   */
  @extension("x-ms-identifiers", #[])
  serviceAccounts?: ServiceAccount[];

  /**
   * Shielded Instance Config.
   */
  shieldedInstanceConfig?: ShieldedInstanceConfig;

  /**
   * ShieldedInstance Integrity Policy.
   */
  shieldedInstanceIntegrityPolicy?: ShieldedInstanceIntegrityPolicy;

  /**
   * Source machine image
   */
  sourceMachineImage?: string;

  /**
   * Source machine image encryption key when creating an instance from a machine image.
   */
  sourceMachineImageEncryptionKey?: CustomerEncryptionKey;

  /**
   * [Output Only] Whether a VM has been restricted for start because Compute Engine has detected suspicious activity.
   */
  startRestricted?: boolean;

  /**
   * [Output Only] The status of the instance. One of the following values: PROVISIONING, STAGING, RUNNING, STOPPING, SUSPENDING, SUSPENDED, REPAIRING, and TERMINATED. For more information about the status of the instance, see Instance life cycle.
   */
  status?:
    | "DEPROVISIONING"
    | "PROVISIONING"
    | "REPAIRING"
    | "RUNNING"
    | "STAGING"
    | "STOPPED"
    | "STOPPING"
    | "SUSPENDED"
    | "SUSPENDING"
    | "TERMINATED"
    | string;

  /**
   * [Output Only] An optional, human-readable explanation of the status.
   */
  statusMessage?: string;

  /**
   * Tags to apply to this instance. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during instance creation. The tags can be later modified by the setTags method. Each tag within the list must comply with RFC1035. Multiple tags can be specified via the 'tags.items' field.
   */
  tags?: Tags;

  /**
   * [Output Only] URL of the zone where the instance resides. You must specify this field as part of the HTTP request URL. It is not settable as a field in the request body.
   */
  zone?: string;
}

/**
 * A set of Display Device options
 */
model DisplayDevice {
  /**
   * Defines whether the instance has Display enabled.
   */
  enableDisplay?: boolean;
}

/**
 * A metadata key/value entry.
 */
model Metadata {
  /**
   * Specifies a fingerprint for this request, which is essentially a hash of the metadata's contents and used for optimistic locking. The fingerprint is initially generated by Compute Engine and changes after every request to modify or update metadata. You must always provide an up-to-date fingerprint hash in order to update or change metadata, otherwise the request will fail with error 412 conditionNotMet. To see the latest fingerprint, make a get() request to retrieve the resource.
   */
  fingerprint?: bytes;

  /**
   * Array of key/value pairs. The total size of all keys and values must be less than 512 KB.
   */
  @extension("x-ms-identifiers", #[])
  items?: {
    @pattern("[a-zA-Z0-9-_]{1,128}")
    key?: string;

    value?: string;
  }[];

  /**
   * [Output Only] Type of the resource. Always compute#metadata for metadata.
   */
  kind?: string = "compute#metadata";
}

/**
 * A network interface resource attached to an instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
model NetworkInterface {
  /**
   * An array of configurations for this interface. Currently, only one access config, ONE_TO_ONE_NAT, is supported. If there are no accessConfigs specified, then this instance will have no external internet access.
   */
  @extension("x-ms-identifiers", #[])
  accessConfigs?: AccessConfig[];

  /**
   * An array of alias IP ranges for this network interface. You can only specify this field for network interfaces in VPC networks.
   */
  @extension("x-ms-identifiers", #[])
  aliasIpRanges?: AliasIpRange[];

  /**
   * Fingerprint hash of contents stored in this network interface. This field will be ignored when inserting an Instance or adding a NetworkInterface. An up-to-date fingerprint must be provided in order to update the NetworkInterface. The request will fail with error 400 Bad Request if the fingerprint is not provided, or 412 Precondition Failed if the fingerprint is out of date.
   */
  fingerprint?: string;

  /**
   * The prefix length of the primary internal IPv6 range.
   */
  internalIpv6PrefixLength?: int32;

  /**
   * An array of IPv6 access configurations for this interface. Currently, only one IPv6 access config, DIRECT_IPV6, is supported. If there is no ipv6AccessConfig specified, then this instance will have no external IPv6 Internet access.
   */
  @extension("x-ms-identifiers", #[])
  ipv6AccessConfigs?: AccessConfig[];

  /**
   * [Output Only] One of EXTERNAL, INTERNAL to indicate whether the IP can be accessed from the Internet. This field is always inherited from its subnetwork. Valid only if stackType is IPV4_IPV6.
   */
  ipv6AccessType?: "EXTERNAL" | "INTERNAL" | string;

  /**
   * An IPv6 internal network address for this network interface. To use a static internal IP address, it must be unused and in the same region as the instance's zone. If not specified, Google Cloud will automatically assign an internal IPv6 address from the instance's subnetwork.
   */
  ipv6Address?: string;

  /**
   * [Output Only] Type of the resource. Always compute#networkInterface for network interfaces.
   */
  kind?: string = "compute#networkInterface";

  /**
   * [Output Only] The name of the network interface, which is generated by the server. For a VM, the network interface uses the nicN naming format. Where N is a value between 0 and 7. The default interface value is nic0.
   */
  name?: string;

  /**
   * URL of the VPC network resource for this instance. When creating an instance, if neither the network nor the subnetwork is specified, the default network global/networks/default is used. If the selected project doesn't have the default network, you must specify a network or subnet. If the network is not specified but the subnetwork is specified, the network is inferred. If you specify this property, you can specify the network as a full or partial URL. For example, the following are all valid URLs: - https://www.googleapis.com/compute/v1/projects/project/global/networks/ network - projects/project/global/networks/network - global/networks/default
   */
  network?: string;

  /**
   * The URL of the network attachment that this interface should connect to in the following format: projects/{project_number}/regions/{region_name}/networkAttachments/{network_attachment_name}.
   */
  networkAttachment?: string;

  /**
   * An IPv4 internal IP address to assign to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.
   */
  networkIP?: string;

  /**
   * The type of vNIC to be used on this interface. This may be gVNIC or VirtioNet.
   */
  nicType?: "GVNIC" | "UNSPECIFIED_NIC_TYPE" | "VIRTIO_NET" | string;

  /**
   * The networking queue count that's specified by users for the network interface. Both Rx and Tx queues will be set to this number. It'll be empty if not specified by the users.
   */
  queueCount?: int32;

  /**
   * The stack type for this network interface. To assign only IPv4 addresses, use IPV4_ONLY. To assign both IPv4 and IPv6 addresses, use IPV4_IPV6. If not specified, IPV4_ONLY is used. This field can be both set at instance creation and update network interface operations.
   */
  stackType?: "IPV4_IPV6" | "IPV4_ONLY" | string;

  /**
   * The URL of the Subnetwork resource for this instance. If the network resource is in legacy mode, do not specify this field. If the network is in auto subnet mode, specifying the subnetwork is optional. If the network is in custom subnet mode, specifying the subnetwork is required. If you specify this field, you can specify the subnetwork as a full or partial URL. For example, the following are all valid URLs: - https://www.googleapis.com/compute/v1/projects/project/regions/region /subnetworks/subnetwork - regions/region/subnetworks/subnetwork
   */
  subnetwork?: string;
}

/**
 * Describes the cause of the error with structured details. Example of an error when contacting the "pubsub.googleapis.com" API when it is not enabled: { "reason": "API_DISABLED" "domain": "googleapis.com" "metadata": { "resource": "projects/123", "service": "pubsub.googleapis.com" } } This response indicates that the pubsub.googleapis.com API is not enabled. Example of an error that is returned when attempting to create a Spanner instance in a region that is out of stock: { "reason": "STOCKOUT" "domain": "spanner.googleapis.com", "metadata": { "availableRegions": "us-central1,us-east2" } }
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model ErrorInfo {
  /**
   * The logical grouping to which the "reason" belongs. The error domain is typically the registered service name of the tool or product that generates the error. Example: "pubsub.googleapis.com". If the error is generated by some common infrastructure, the error domain must be a globally unique value that identifies the infrastructure. For Google API infrastructure, the error domain is "googleapis.com".
   */
  domain?: string;

  /**
   * Additional structured details about this error. Keys should match /[a-zA-Z0-9-_]/ and be limited to 64 characters in length. When identifying the current value of an exceeded limit, the units should be contained in the key, not the value. For example, rather than {"instanceLimit": "100/request"}, should be returned as, {"instanceLimitPerRequest": "100"}, if the client exceeds the number of instances that can be created in a single (batch) request.
   */
  metadatas?: Record<string>;

  /**
   * The reason of the error. This is a constant value that identifies the proximate cause of the error. Error reasons are unique within a particular domain of errors. This should be at most 63 characters and match a regular expression of `A-Z+[A-Z0-9]`, which represents UPPER_SNAKE_CASE.
   */
  reason?: string;
}

/**
 * Provides links to documentation or for performing an out of band action. For example, if a quota check failed with an error indicating the calling project hasn't enabled the accessed service, this can contain a URL pointing directly to the right place in the developer console to flip the bit.
 */
model Help {
  /**
   * URL(s) pointing to additional information on handling the current error.
   */
  @extension("x-ms-identifiers", #[])
  links?: HelpLink[];
}

/**
 * Provides a localized error message that is safe to return to the user which can be attached to an RPC error.
 */
model LocalizedMessage {
  /**
   * The locale used following the specification defined at https://www.rfc-editor.org/rfc/bcp/bcp47.txt. Examples are: "en-US", "fr-CH", "es-MX"
   */
  locale?: string;

  /**
   * The localized error message in the above locale.
   */
  message?: string;
}

/**
 * The policy describes the baseline against which Instance boot integrity is measured.
 */
model ShieldedInstanceIntegrityPolicy {
  /**
   * Updates the integrity policy baseline using the measurements from the VM instance's most recent boot.
   */
  updateAutoLearnPolicy?: boolean;
}

/**
 * A service account.
 */
model ServiceAccount {
  /**
   * Email address of the service account.
   */
  email?: string;

  /**
   * The list of scopes to be made available for this service account.
   */
  scopes?: string[];
}

/**
 * Describes a URL link.
 */
model HelpLink {
  /**
   * Describes what the link offers.
   */
  description?: string;

  /**
   * The URL of the link.
   */
  url?: string;
}

/**
 * Network Performance Config.
 */
model NetworkPerformanceConfig {
  /**
   * Total Egress Bandwidth Tier.
   */
  totalEgressBandwidthTier?: "DEFAULT" | "TIER_1" | string;
}

/**
 * Set Common Instance Metadata Operation Metadata.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model SetCommonInstanceMetadataOperationMetadata {
  /**
   * [Output Only] The client operation id.
   */
  clientOperationId?: string;

  /**
   * [Output Only] Status information per location (location name is key). Example key: zones/us-central1-a
   */
  perLocationOperations?: Record<SetCommonInstanceMetadataOperationMetadataPerLocationOperationInfo>;
}

/**
 * Set Common Instance Metadata Operation Metadata Per Location Operation Info.
 */
model SetCommonInstanceMetadataOperationMetadataPerLocationOperationInfo {
  /**
   * [Output Only] If state is `ABANDONED` or `FAILED`, this field is populated.
   */
  error?: Status;

  /**
   * [Output Only] Status of the action, which can be one of the following: `PROPAGATING`, `PROPAGATED`, `ABANDONED`, `FAILED`, or `DONE`.
   */
  state?:
    | "ABANDONED"
    | "DONE"
    | "FAILED"
    | "PROPAGATED"
    | "PROPAGATING"
    | "UNSPECIFIED"
    | string;
}

/**
 * File Content Buffer.
 */
model FileContentBuffer {
  /**
   * The raw content in the secure keys file.
   */
  content?: bytes;

  /**
   * The file type of source file.
   */
  fileType?: "BIN" | "UNDEFINED" | "X509" | string;
}

/**
 * A set of Confidential Instance options.
 */
model ConfidentialInstanceConfig {
  /**
   * Defines whether the instance should have confidential compute enabled.
   */
  enableConfidentialCompute?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface ComputeInstances {
  get is ArmResourceRead<ComputeInstance>;
  @doc("Create a ComputeInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ComputeInstance>;
  delete is ArmResourceDeleteWithoutOkAsync<ComputeInstance>;
  list is ArmResourceListByParent<ComputeInstance>;
}
