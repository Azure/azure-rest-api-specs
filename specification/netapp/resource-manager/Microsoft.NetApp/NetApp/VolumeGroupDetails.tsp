import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;
/**
 * Volume group resource for create
 */
@parentResource(NetAppAccount)
model VolumeGroupDetails
  is Azure.ResourceManager.ProxyResource<VolumeGroupProperties> {
  ...ResourceNameParameter<
    Resource = VolumeGroupDetails,
    KeyName = "volumeGroupName",
    SegmentName = "volumeGroups",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;

  /**
   * Resource location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * List of volume group resources
 */
model VolumeGroupList is Azure.Core.Page<VolumeGroup>;

/**
 * Volume group resource
 */
model VolumeGroup {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Volume group properties
   */
  properties?: VolumeGroupListProperties;
}

/**
 * Volume group properties
 */
model VolumeGroupListProperties {
  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Volume group details
   */
  groupMetaData?: VolumeGroupMetaData;
}

/**
 * Volume group properties
 */
model VolumeGroupMetaData {
  /**
   * Group Description
   */
  groupDescription?: string;

  /**
   * Application Type
   */
  applicationType?: ApplicationType;

  /**
   * Application specific identifier
   */
  applicationIdentifier?: string;

  /**
   * Application specific placement rules for the volume group
   */
  @identifiers(#["key"])
  globalPlacementRules?: PlacementKeyValuePairs[];

  /**
   * Number of volumes in volume group
   */
  @visibility(Lifecycle.Read)
  volumesCount?: int64;
}

/**
 * Application Type
 */
@clientName("NetAppApplicationType", "csharp")
union ApplicationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SAP-HANA`: "SAP-HANA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ORACLE: "ORACLE",
}

/**
 * Volume group properties
 */
model VolumeGroupProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Volume group details
   */
  groupMetaData?: VolumeGroupMetaData;

  /**
   * List of volumes from group
   */
  volumes?: VolumeGroupVolumeProperties[];
}

/**
 * Volume resource
 */
model VolumeGroupVolumeProperties {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Availability Zone
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zones?: string[];

  /**
   * Volume properties
   */
  properties: VolumeProperties;
}

@armResourceOperations
interface VolumeGroups {
  /**
   * Get details of the specified volume group
   */
  get is ArmResourceRead<VolumeGroupDetails>;

  /**
   * Create a volume group along with specified volumes
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    VolumeGroupDetails,
    Response = ArmResourceCreatedResponse<
      VolumeGroupDetails,
      ArmLroLocationHeader<FinalResult = VolumeGroupDetails> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete the specified volume group only if there are no volumes under volume group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    VolumeGroupDetails,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@maxLength(VolumeGroupDetails.name, 64);
@@minLength(VolumeGroupDetails.name, 1);
@@doc(VolumeGroupDetails.name, "The name of the volumeGroup");
@@doc(VolumeGroupDetails.properties, "Volume group properties");
@@doc(VolumeGroups.create::parameters.resource,
  "Volume Group object supplied in the body of the operation."
);
