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
@singleton("default")
@parentResource(BlobContainer)
model ImmutabilityPolicy
  is Azure.ResourceManager.ProxyResource<ImmutabilityPolicyProperty, false> {
  ...ResourceNameParameter<
    Resource = ImmutabilityPolicy,
    KeyName = "immutabilityPolicy",
    SegmentName = "immutabilityPolicies",
    NamePattern = ""
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface CreateOrUpdateImmutabilityPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the storage account within the specified resource group. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.")
        @path
        @segment("storageAccounts")
        @minLength(3)
        @maxLength(24)
        @pattern("^[a-z0-9]+$")
        accountName: string,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("blobServices")
        blobServicesDefault: "default",

        @doc("The name of the blob container within the specified storage account. Blob container names must be between 3 and 63 characters in length and use numbers, lower-case letters and dash (-) only. Every dash (-) character must be immediately preceded and followed by a letter or number.")
        @path
        @segment("containers")
        @minLength(3)
        @maxLength(63)
        containerName: string,
      },
      {
        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("immutabilityPolicies")
        immutabilityPoliciesDefault: "default",
      },
      ErrorType = ErrorResponse
    > {}

@armResourceOperations
interface ImmutabilityPolicies {
  /**
   * Gets the existing immutability policy along with the corresponding ETag in response headers and body.
   */
  getImmutabilityPolicy is ArmResourceRead<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update must be returned to the server for all update operations. The ETag value must include the leading and trailing double quotes as returned by the service.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & ETagHeader,
    Error = ErrorResponse
  >;

  /**
   * Creates or updates an unlocked immutability policy. ETag in If-Match is honored if given but not required for this operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdateImmutabilityPolicy is CreateOrUpdateImmutabilityPolicyOps.CreateOrUpdateSync<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update must be returned to the server for all update operations. The ETag value must include the leading and trailing double quotes as returned by the service.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<ImmutabilityPolicy> & ETagHeader,
    OverrideErrorType = ErrorResponse,
    OptionalRequestBody = true
  >;

  /**
   * Aborts an unlocked immutability policy. The response of delete has immutabilityPeriodSinceCreationInDays set to 0. ETag in If-Match is required for this operation. Deleting a locked immutability policy is not allowed, the only way is to delete the container after deleting all expired blobs inside the policy locked container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  deleteImmutabilityPolicy is ArmResourceDeleteSync<
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update must be returned to the server for all update operations. The ETag value must include the leading and trailing double quotes as returned by the service.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & ETagHeader,
    Error = ErrorResponse
  >;

  /**
   * Sets the ImmutabilityPolicy to Locked state. The only action allowed on a Locked policy is ExtendImmutabilityPolicy action. ETag in If-Match is required for this operation.
   */
  @action("lock")
  lockImmutabilityPolicy is ArmResourceActionSync<
    ImmutabilityPolicy,
    void,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update must be returned to the server for all update operations. The ETag value must include the leading and trailing double quotes as returned by the service.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & ETagHeader,
    Error = ErrorResponse
  >;

  /**
   * Extends the immutabilityPeriodSinceCreationInDays of a locked immutabilityPolicy. The only action allowed on a Locked policy will be this action. ETag in If-Match is required for this operation.
   */
  @action("extend")
  extendImmutabilityPolicy is ArmResourceActionSync<
    ImmutabilityPolicy,
    ImmutabilityPolicy,
    Parameters = {
      /**
       * The entity state (ETag) version of the immutability policy to update must be returned to the server for all update operations. The ETag value must include the leading and trailing double quotes as returned by the service.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ImmutabilityPolicy> & ETagHeader,
    Error = ErrorResponse,
    OptionalRequestBody = true
  >;
}

@@doc(ImmutabilityPolicy.name, "");
@@doc(ImmutabilityPolicy.properties,
  "The properties of an ImmutabilityPolicy of a blob container."
);
@@doc(ImmutabilityPolicies.createOrUpdateImmutabilityPolicy::parameters.resource,
  "The ImmutabilityPolicy Properties that will be created or updated to a blob container."
);
