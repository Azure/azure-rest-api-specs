import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BlobContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The ImmutabilityPolicy property of a blob container, including Id, resource name, resource type, Etag.
 */
@parentResource(BlobContainer)
model ImmutabilityPolicy
  is Azure.ResourceManager.ProxyResource<ImmutabilityPolicyProperty, false> {
  ...ResourceNameParameter<
    Resource = ImmutabilityPolicy,
    KeyName = "ImmutabilityPolicyName",
    SegmentName = "immutabilityPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ImmutabilityPolicies {
  /**
   * Gets the existing immutability policy along with the corresponding ETag in response headers and body.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @operationId("BlobContainers_GetImmutabilityPolicy")
  getImmutabilityPolicy is ArmResourceRead<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update. A value of "*" can be used to apply the operation only if the immutability policy already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`?: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers..
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates or updates an unlocked immutability policy. ETag in If-Match is honored if given but not required for this operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @operationId("BlobContainers_CreateOrUpdateImmutabilityPolicy")
  createOrUpdateImmutabilityPolicy is ArmResourceCreateOrReplaceSync<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update. A value of "*" can be used to apply the operation only if the immutability policy already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`?: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers..
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Aborts an unlocked immutability policy. The response of delete has immutabilityPeriodSinceCreationInDays set to 0. ETag in If-Match is required for this operation. Deleting a locked immutability policy is not allowed, the only way is to delete the container after deleting all expired blobs inside the policy locked container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @operationId("BlobContainers_DeleteImmutabilityPolicy")
  deleteImmutabilityPolicy is ArmResourceDeleteSync<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update. A value of "*" can be used to apply the operation only if the immutability policy already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers..
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Sets the ImmutabilityPolicy to Locked state. The only action allowed on a Locked policy is ExtendImmutabilityPolicy action. ETag in If-Match is required for this operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @action("lock")
  @operationId("BlobContainers_LockImmutabilityPolicy")
  lockImmutabilityPolicy is ArmResourceActionSync<
    ImmutabilityPolicy,
    void,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update. A value of "*" can be used to apply the operation only if the immutability policy already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers..
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Extends the immutabilityPeriodSinceCreationInDays of a locked immutabilityPolicy. The only action allowed on a Locked policy will be this action. ETag in If-Match is required for this operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @action("extend")
  @operationId("BlobContainers_ExtendImmutabilityPolicy")
  extendImmutabilityPolicy is ArmResourceActionSync<
    ImmutabilityPolicy,
    {
      /**
       * The ImmutabilityPolicy Properties that will be extended for a blob container.
       */
      @bodyRoot
      parameters?: ImmutabilityPolicy;
    },
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update. A value of "*" can be used to apply the operation only if the immutability policy already exists. If omitted, this operation will always be applied.
       */
      @header
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & {
      /**
       * The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Match or If-None-Match headers..
       */
      @header("ETag")
      eTag: string;
    }
  >;
}

@@doc(ImmutabilityPolicy.name, "");
@@doc(ImmutabilityPolicy.properties,
  "The properties of an ImmutabilityPolicy of a blob container."
);
@@doc(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy::parameters.resource,
  "The ImmutabilityPolicy Properties that will be created or updated to a blob container."
);
