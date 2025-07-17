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
@about({
  displayNames: {
    singular: "Storage Bucket",
    plural: "Storage Buckets",
  },
  keywords: ["Microsoft.GcpConnector", "Storage", "Bucket"],
})
@doc("A Microsoft.GcpConnector resource")
model StorageBucket is TrackedResource<BucketProperties> {
  @doc("Name of StorageBucket")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("storageBuckets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of BucketProperties")
model BucketProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpBucketProperties;

  ...GcpCommonProperties;
}

/**
 * A bucket.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in gcp."
model GcpBucketProperties {
  /**
   * Access controls on the bucket.
   */
  acl?: BucketAccessControl[];

  /**
   * The bucket's Autoclass configuration.
   */
  autoclass?: {
    /** Whether or not Autoclass is enabled on this bucket */
    enabled?: boolean;

    /** The storage class that objects in the bucket eventually transition to if they are not read for a certain length of time. Valid values are NEARLINE and ARCHIVE. */
    terminalStorageClass?: string;

    /** A date and time in RFC 3339 format representing the time of the most recent update to \"terminalStorageClass\" */
    terminalStorageClassUpdateTime?: utcDateTime;

    /** A date and time in RFC 3339 format representing the instant at which \"enabled\" was last toggled. */
    toggleTime?: utcDateTime;
  };

  /**
   * The bucket's billing configuration.
   */
  billing?: {
    /** When set to true, Requester Pays is enabled for this bucket. */
    requesterPays?: boolean;
  };

  /**
   * The bucket's Cross-Origin Resource Sharing (CORS) configuration.
   */
  @extension("x-ms-identifiers", #[])
  cors?: {
    /** The value, in seconds, to return in the  Access-Control-Max-Age header used in preflight responses. */
    maxAgeSeconds?: int32;

    /** The list of HTTP methods on which to include CORS response headers, (GET, OPTIONS, POST, etc) Note: '*' is permitted in the list of methods, and means 'any method'. */
    method?: string[];

    /** The list of Origins eligible to receive CORS response headers. Note: '*' is permitted in the list of origins, and means 'any Origin'. */
    origin?: string[];

    /** The list of HTTP headers other than the simple response headers to give permission for the user-agent to share across domains. */
    responseHeader?: string[];
  }[];

  /**
   * The bucket's custom placement configuration for Custom Dual Regions.
   */
  customPlacementConfig?: {
    /** The list of regional locations in which data is placed. */
    dataLocations?: string[];
  };

  /**
   * The default value for event-based hold on newly created objects in this bucket. Event-based hold is a way to retain objects indefinitely until an event occurs, signified by the hold's release. After being released, such objects will be subject to bucket-level retention (if any). One sample use case of this flag is for banks to hold loan documents for at least 3 years after loan is paid in full. Here, bucket-level retention is 3 years and the event is loan being paid in full. In this example, these objects will be held intact for any number of years until the event has occurred (event-based hold on the object is released) and then 3 more years after that. That means retention duration of the objects begins from the moment event-based hold transitioned from true to false. Objects under event-based hold cannot be deleted, overwritten or archived until the hold is removed.
   */
  defaultEventBasedHold?: boolean;

  /**
   * Default access controls to apply to new objects when no ACL is provided.
   */
  defaultObjectAcl?: ObjectAccessControl[];

  /**
   * Encryption configuration for a bucket.
   */
  encryption?: {
    /** A Cloud KMS key that will be used to encrypt objects inserted into this bucket, if no encryption method is specified. */
    defaultKmsKeyName?: string;
  };

  /**
   * HTTP 1.1 Entity tag for the bucket.
   */
  etag?: string;

  /**
   * The bucket's hierarchical namespace configuration.
   */
  hierarchicalNamespace?: {
    /** When set to true, hierarchical namespace is enabled for this bucket. */
    enabled?: boolean;
  };

  /**
   * The bucket's IAM configuration.
   */
  iamConfiguration?: {
    /** The bucket's uniform bucket-level access configuration. The feature was formerly known as Bucket Policy Only. For backward compatibility, this field will be populated with identical information as the uniformBucketLevelAccess field. We recommend using the uniformBucketLevelAccess field to enable and disable the feature. */
    bucketPolicyOnly?: {
      /** If set, access is controlled only by bucket-level or above IAM policies. */
      enabled?: boolean;

      /** The deadline for changing iamConfiguration.bucketPolicyOnly.enabled from true to false in RFC 3339 format. iamConfiguration.bucketPolicyOnly.enabled may be changed from true to false until the locked time, after which the field is immutable. */
      lockedTime?: utcDateTime;
    };

    /** The bucket's Public Access Prevention configuration. Currently, 'inherited' and 'enforced' are supported. */
    publicAccessPrevention?: string;

    /** The bucket's uniform bucket-level access configuration. */
    uniformBucketLevelAccess?: {
      /** If set, access is controlled only by bucket-level or above IAM policies. */
      enabled?: boolean;

      /** The deadline for changing iamConfiguration.uniformBucketLevelAccess.enabled from true to false in RFC 3339  format. iamConfiguration.uniformBucketLevelAccess.enabled may be changed from true to false until the locked time, after which the field is immutable. */
      lockedTime?: utcDateTime;
    };
  };

  /**
   * The ID of the bucket. For buckets, the id and name properties are the same.
   */
  id?: string;

  /**
   * The content generation of this object. Used for object versioning..
   */
  generation?: string;

  /**
   * The kind of item this is. For buckets, this is always storage#bucket.
   */
  kind?: string = "storage#bucket";

  /**
   * User-provided labels, in key/value pairs.
   */
  labels?: Record<string>;

  /**
   * The bucket's lifecycle configuration. See lifecycle management for more information.
   */
  lifecycle?: {
    /** A lifecycle management rule, which is made of an action to take and the condition(s) under which the action will be taken. */
    @extension("x-ms-identifiers", #[])
    rule?: {
      /** The action to take. */
      action?: {
        /** Target storage class. Required iff the type of the action is SetStorageClass. */
        storageClass?: string;

        /** Type of the action. Currently, only Delete, SetStorageClass, and AbortIncompleteMultipartUpload are supported. */
        type?: string;
      };

      /** The condition(s) under which the action will be taken. */
      condition?: {
        /** Age of an object (in days). This condition is satisfied when an object reaches the specified age. */
        age?: int32;

        /** A date in RFC 3339 format with only the date part (for instance, "2013-01-15"). This condition is satisfied when an object is created before midnight of the specified date in UTC. */
        createdBefore?: plainDate;

        /** A date in RFC 3339 format with only the date part (for instance, "2013-01-15"). This condition is satisfied when the custom time on an object is before this date in UTC. */
        customTimeBefore?: plainDate;

        /** Number of days elapsed since the user-specified timestamp set on an object. The condition is satisfied if the days elapsed is at least this number. If no custom timestamp is specified on an object, the condition does not apply. */
        daysSinceCustomTime?: int32;

        /** Number of days elapsed since the noncurrent timestamp of an object. The condition is satisfied if the days elapsed is at least this number. This condition is relevant only for versioned objects. The value of the field must be a nonnegative integer. If it's zero, the object version will become eligible for Lifecycle action as soon as it becomes noncurrent. */
        daysSinceNoncurrentTime?: int32;

        /** Relevant only for versioned objects. If the value is true, this condition matches live objects; if the value is false, it matches archived objects. */
        isLive?: boolean;

        /** A regular expression that satisfies the RE2 syntax. This condition is satisfied when the name of the object matches the RE2 pattern. Note: This feature is currently in the "Early Access" launch stage and is only available to a whitelisted set of users; that means that this feature may be changed in backward-incompatible ways and that it is not guaranteed to be released. */
        matchesPattern?: string;

        /** List of object name prefixes. This condition will be satisfied when at least one of the prefixes exactly matches the beginning of the object name. */
        matchesPrefix?: string[];

        /** Objects having any of the storage classes specified by this condition will be matched. Values include MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, STANDARD, and DURABLE_REDUCED_AVAILABILITY. */
        matchesStorageClass?: string[];

        /** List of object name suffixes. This condition will be satisfied when at least one of the suffixes exactly matches the end of the object name. */
        matchesSuffix?: string[];

        /** A date in RFC 3339 format with only the date part (for instance, "2013-01-15"). This condition is satisfied when the noncurrent time on an object is before this date in UTC. This condition is relevant only for versioned objects. */
        noncurrentTimeBefore?: plainDate;

        /** Relevant only for versioned objects. If the value is N, this condition is satisfied when there are at least N versions (including the live version) newer than this version of the object. */
        numNewerVersions?: int32;
      };
    }[];
  };

  /**
   * The location of the bucket. Object data for objects in the bucket resides in physical storage within this region. Defaults to US. See the developer's guide for the authoritative list.
   */
  location?: string;

  /**
   * The type of the bucket location.
   */
  locationType?: string;

  /**
   * The bucket's logging configuration, which defines the destination bucket and optional name prefix for the current bucket's logs.
   */
  logging?: {
    /** The destination bucket where the current bucket's logs should be placed. */
    logBucket?: string;

    /** A prefix for log object names. */
    logObjectPrefix?: string;
  };

  /**
   * The metadata generation of this bucket.
   */
  metageneration?: string;

  /**
   * The name of the bucket.
   */
  name?: string;

  /**
   * The bucket's object retention config.
   */
  objectRetention?: {
    /** The bucket's object retention mode. Can be Enabled. */
    mode?: string;
  };

  /**
   * The owner of the bucket. This is always the project team's owner group.
   */
  owner?: {
    /** The entity, in the form project-owner-projectId. */
    entity?: string;

    /** The ID for the entity. */
    entityId?: string;
  };

  /**
   * The project number of the project the bucket belongs to.
   */
  projectNumber?: string;

  /**
   * The bucket's retention policy. The retention policy enforces a minimum retention time for all objects contained in the bucket, based on their creation time. Any attempt to overwrite or delete objects younger than the retention period will result in a PERMISSION_DENIED error. An unlocked retention policy can be modified or removed from the bucket via a storage.buckets.update operation. A locked retention policy cannot be removed or shortened in duration for the lifetime of the bucket. Attempting to remove or decrease period of a locked retention policy will result in a PERMISSION_DENIED error.
   */
  retentionPolicy?: {
    /** Server-determined value that indicates the time from which policy was enforced and effective. This value is in RFC 3339 format. */
    effectiveTime?: utcDateTime;

    /** Once locked, an object retention policy cannot be modified. */
    isLocked?: boolean;

    /** The duration in seconds that objects need to be retained. Retention duration must be greater than zero and less than 100 years. Note that enforcement of retention periods less than a day is not guaranteed. Such periods should only be used for testing purposes. */
    retentionPeriod?: string;
  };

  /**
   * The Recovery Point Objective (RPO) of this bucket. Set to ASYNC_TURBO to turn on Turbo Replication on a bucket.
   */
  rpo?: string;

  /**
   * Reserved for future use.
   */
  satisfiesPZS?: boolean;

  /**
   * The URI of this bucket.
   */
  selfLink?: string;

  /**
   * The bucket's soft delete policy, which defines the period of time that soft-deleted objects will be retained, and cannot be permanently deleted.
   */
  softDeletePolicy?: {
    /** Server-determined value that indicates the time from which the policy, or one with a greater retention, was effective. This value is in RFC 3339 format. */
    effectiveTime?: utcDateTime;

    /** The duration in seconds that soft-deleted objects in the bucket will be retained and cannot be permanently deleted. */
    retentionDurationSeconds?: string;
  };

  /**
   * The bucket's default storage class, used whenever no storageClass is specified for a newly-created object. This defines how objects in the bucket are stored and determines the SLA and the cost of storage. Values include MULTI_REGIONAL, REGIONAL, STANDARD, NEARLINE, COLDLINE, ARCHIVE, and DURABLE_REDUCED_AVAILABILITY. If this value is not specified when the bucket is created, it will default to STANDARD. For more information, see storage classes.
   */
  storageClass?: string;

  /**
   * The creation time of the bucket in RFC 3339 format.
   */
  timeCreated?: utcDateTime;

  /**
   * The modification time of the bucket in RFC 3339 format.
   */
  updated?: utcDateTime;

  /**
   * The bucket's versioning configuration.
   */
  versioning?: {
    /** While set to true, versioning is fully enabled for this bucket. */
    enabled?: boolean;
  };

  /**
   * The bucket's website configuration, controlling how the service behaves when accessing bucket contents as a web site. See the Static Website Examples for more information.
   */
  website?: {
    /** If the requested object path is missing, the service will ensure the path has a trailing '/', append this suffix, and attempt to retrieve the resulting object. This allows the creation of index.html objects to represent directory pages. */
    mainPageSuffix?: string;

    /** If the requested object path is missing, and any mainPageSuffix object is missing, if applicable, the service will return the named object from this bucket as the content for a 404 Not Found result. */
    notFoundPage?: string;
  };
}

/**
 * An access-control entry.
 */
model BucketAccessControl {
  /**
   * The name of the bucket.
   */
  bucket?: string;

  /**
   * The domain associated with the entity, if any.
   */
  domain?: string;

  /**
   * The email address associated with the entity, if any.
   */
  email?: string;

  @doc("""
    The entity holding the permission, in one of the following forms: 
    - user-userId 
    - user-email 
    - group-groupId 
    - group-email 
    - domain-domain 
    - project-team-projectId 
    - allUsers 
    - allAuthenticatedUsers Examples: 
    - The user liz@example.com would be user-liz@example.com. 
    - The group example@googlegroups.com would be group-example@googlegroups.com. 
    - To refer to all members of the Google Apps for Business domain example.com, the entity would be domain-example.com.
    """)
  entity?: string;

  /**
   * The ID for the entity, if any.
   */
  entityId?: string;

  /**
   * HTTP 1.1 Entity tag for the access-control entry.
   */
  etag?: string;

  /**
   * The ID of the access-control entry.
   */
  id?: string;

  /**
   * The kind of item this is. For bucket access control entries, this is always storage#bucketAccessControl.
   */
  kind?: string = "storage#bucketAccessControl";

  /**
   * The project team associated with the entity, if any.
   */
  projectTeam?: {
    /** The project number. */
    projectNumber?: string;

    /** The team. */
    team?: string;
  };

  /**
   * The access permission for the entity.
   */
  role?: string;

  /**
   * The link to this access-control entry.
   */
  selfLink?: string;
}

/**
 * An access-control entry.
 */
model ObjectAccessControl {
  /**
   * The name of the bucket.
   */
  bucket?: string;

  /**
   * The domain associated with the entity, if any.
   */
  domain?: string;

  /**
   * The email address associated with the entity, if any.
   */
  email?: string;

  @doc("""
    The entity holding the permission, in one of the following forms: 
    - user-userId 
    - user-email 
    - group-groupId 
    - group-email 
    - domain-domain 
    - project-team-projectId 
    - allUsers 
    - allAuthenticatedUsers Examples: 
    - The user liz@example.com would be user-liz@example.com. 
    - The group example@googlegroups.com would be group-example@googlegroups.com. 
    - To refer to all members of the Google Apps for Business domain example.com, the entity would be domain-example.com.
    """)
  entity?: string;

  /**
   * The ID for the entity, if any.
   */
  entityId?: string;

  /**
   * HTTP 1.1 Entity tag for the access-control entry.
   */
  etag?: string;

  /**
   * The content generation of the object, if applied to an object.
   */
  generation?: string;

  /**
   * The ID of the access-control entry.
   */
  id?: string;

  /**
   * The kind of item this is. For object access control entries, this is always storage#objectAccessControl.
   */
  kind?: string = "storage#objectAccessControl";

  /**
   * The name of the object, if applied to an object.
   */
  object?: string;

  /**
   * The project team associated with the entity, if any.
   */
  projectTeam?: {
    /** The project number. */
    projectNumber?: string;

    /** The team. */
    team?: string;
  };

  /**
   * The access permission for the entity.
   */
  role?: string;

  /**
   * The link to this access-control entry.
   */
  selfLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface StorageBuckets {
  get is ArmResourceRead<StorageBucket>;
  @doc("Create a StorageBucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<StorageBucket>;
  update is ArmCustomPatchAsync<
    StorageBucket,
    Azure.ResourceManager.Foundations.TagsUpdateModel<StorageBucket>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StorageBucket>;
  listByResourceGroup is ArmResourceListByParent<StorageBucket>;
  listBySubscription is ArmListBySubscription<StorageBucket>;
}
