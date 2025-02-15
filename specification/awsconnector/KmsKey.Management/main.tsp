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

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- KmsKeys ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "KMS Key",
    plural: "KMS Keys",
  },
  keywords: ["Microsoft.AwsConnector", "KMS", "Key"],
})
@doc("A Microsoft.AwsConnector resource")
model KmsKey is TrackedResource<KmsKeyProperties> {
  @doc("Name of KmsKey")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("kmsKeys")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KmsKey")
model KmsKeyProperties {
  @doc("AWS Properties")
  awsProperties?: AwsKmsKeyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsKmsKey")
model AwsKmsKeyProperties {
  @doc("Property arn")
  arn?: string;

  @doc("Skips ('bypasses') the key policy lockout safety check. The default value is false.  Setting this value to true increases the risk that the KMS key becomes unmanageable. Do not set this value to true indiscriminately. For more information, see [Default key policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#prevent-unmanageable-key) in the *Developer Guide*.  Use this parameter only when you intend to prevent the principal that is making the request from making a subsequent [PutKeyPolicy](https://docs.aws.amazon.com/kms/latest/APIReference/API_PutKeyPolicy.html) request on the KMS key.")
  bypassPolicyLockoutSafetyCheck?: boolean;

  @doc("A description of the KMS key. Use a description that helps you to distinguish this KMS key from others in the account, such as its intended use.")
  description?: string;

  @doc("Enables automatic rotation of the key material for the specified KMS key. By default, automatic key rotation is not enabled.  KMS supports automatic rotation only for symmetric encryption KMS keys (``KeySpec`` = ``SYMMETRIC_DEFAULT``). For asymmetric KMS keys, HMAC KMS keys, and KMS keys with Origin ``EXTERNAL``, omit the ``EnableKeyRotation`` property or set it to ``false``. To enable automatic key rotation of the key material for a multi-Region KMS key, set ``EnableKeyRotation`` to ``true`` on the primary key (created by using ``AWS::KMS::Key``). KMS copies the rotation status to all replica keys. For details, see [Rotating multi-Region keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-manage.html#multi-region-rotate) in the *Developer Guide*. When you enable automatic rotation, KMS automatically creates new key material for the KMS key one year after the enable date and every year thereafter. KMS retains all key material until you delete the KMS key. For detailed information about automatic key rotation, see [Rotating KMS keys](https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html) in the *Developer Guide*.")
  enableKeyRotation?: boolean;

  @doc("Specifies whether the KMS key is enabled. Disabled KMS keys cannot be used in cryptographic operations. When ``Enabled`` is ``true``, the *key state* of the KMS key is ``Enabled``. When ``Enabled`` is ``false``, the key state of the KMS key is ``Disabled``. The default value is ``true``. The actual key state of the KMS key might be affected by actions taken outside of CloudFormation, such as running the [EnableKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_EnableKey.html), [DisableKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_DisableKey.html), or [ScheduleKeyDeletion](https://docs.aws.amazon.com/kms/latest/APIReference/API_ScheduleKeyDeletion.html) operations. For information about the key states of a KMS key, see [Key state: Effect on your KMS key](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html) in the *Developer Guide*.")
  enabled?: boolean;

  @doc("Property keyId")
  keyId?: string;

  @doc("The key policy to attach to the KMS key. If you provide a key policy, it must meet the following criteria:  +  The key policy must allow the caller to make a subsequent [PutKeyPolicy](https://docs.aws.amazon.com/kms/latest/APIReference/API_PutKeyPolicy.html) request on the KMS key. This reduces the risk that the KMS key becomes unmanageable. For more information, see [Default key policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam) in the *Developer Guide*. (To omit this condition, set ``BypassPolicyLockoutSafetyCheck`` to true.)  +  Each statement in the key policy must contain one or more principals. The principals in the key policy must exist and be visible to KMS. When you create a new AWS principal (for example, an IAM user or role), you might need to enforce a delay before including the new principal in a key policy because the new principal might not be immediately visible to KMS. For more information, see [Changes that I make are not always immediately visible](https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency) in the *User Guide*.   If you do not provide a key policy, KMS attaches a default key policy to the KMS key. For more information, see [Default key policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default) in the *Developer Guide*. A key policy document can include only the following characters:  +  Printable ASCII characters  +  Printable characters in the Basic Latin and Latin-1 Supplement character set  +  The tab (``\\u0009``), line feed (``\\u000A``), and carriage return (``\\u000D``) special characters    *Minimum*: ``1``   *Maximum*: ``32768``")
  keyPolicy?: Record<unknown>;

  @doc("Specifies the type of KMS key to create. The default value, ``SYMMETRIC_DEFAULT``, creates a KMS key with a 256-bit symmetric key for encryption and decryption. In China Regions, ``SYMMETRIC_DEFAULT`` creates a 128-bit symmetric key that uses SM4 encryption. You can't change the ``KeySpec`` value after the KMS key is created. For help choosing a key spec for your KMS key, see [Choosing a KMS key type](https://docs.aws.amazon.com/kms/latest/developerguide/symm-asymm-choose.html) in the *Developer Guide*. The ``KeySpec`` property determines the type of key material in the KMS key and the algorithms that the KMS key supports. To further restrict the algorithms that can be used with the KMS key, use a condition key in its key policy or IAM policy. For more information, see [condition keys](https://docs.aws.amazon.com/kms/latest/developerguide/policy-conditions.html#conditions-kms) in the *Developer Guide*.  If you change the value of the ``KeySpec`` property on an existing KMS key, the update request fails, regardless of the value of the [UpdateReplacePolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html). This prevents you from accidentally deleting a KMS key by changing an immutable property value.    [services that are integrated with](https://docs.aws.amazon.com/kms/features/#AWS_Service_Integration) use symmetric encryption KMS keys to protect your data. These services do not support encryption with asymmetric KMS keys. For help determining whether a KMS key is asymmetric, see [Identifying asymmetric KMS keys](https://docs.aws.amazon.com/kms/latest/developerguide/find-symm-asymm.html) in the *Developer Guide*.   KMS supports the following key specs for KMS keys:  +  Symmetric encryption key (default)  +   ``SYMMETRIC_DEFAULT`` (AES-256-GCM)    +  HMAC keys (symmetric)  +   ``HMAC_224``   +   ``HMAC_256``   +   ``HMAC_384``   +   ``HMAC_512``     +  Asymmetric RSA key pairs  +   ``RSA_2048``   +   ``RSA_3072``   +   ``RSA_4096``     +  Asymmetric NIST-recommended elliptic curve key pairs  +   ``ECC_NIST_P256`` (secp256r1)  +   ``ECC_NIST_P384`` (secp384r1)  +   ``ECC_NIST_P521`` (secp521r1)    +  Other asymmetric elliptic curve key pairs  +   ``ECC_SECG_P256K1`` (secp256k1), commonly used for cryptocurrencies.    +  SM2 key pairs (China Regions only)  +   ``SM2``")
  keySpec?: KeySpec = "SYMMETRIC_DEFAULT";

  @doc("Determines the [cryptographic operations](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#cryptographic-operations) for which you can use the KMS key. The default value is ``ENCRYPT_DECRYPT``. This property is required for asymmetric KMS keys and HMAC KMS keys. You can't change the ``KeyUsage`` value after the KMS key is created.  If you change the value of the ``KeyUsage`` property on an existing KMS key, the update request fails, regardless of the value of the [UpdateReplacePolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html). This prevents you from accidentally deleting a KMS key by changing an immutable property value.  Select only one valid value.  +  For symmetric encryption KMS keys, omit the property or specify ``ENCRYPT_DECRYPT``.  +  For asymmetric KMS keys with RSA key material, specify ``ENCRYPT_DECRYPT`` or ``SIGN_VERIFY``.  +  For asymmetric KMS keys with ECC key material, specify ``SIGN_VERIFY``.  +  For asymmetric KMS keys with SM2 (China Regions only) key material, specify ``ENCRYPT_DECRYPT`` or ``SIGN_VERIFY``.  +  For HMAC KMS keys, specify ``GENERATE_VERIFY_MAC``.")
  keyUsage?: KeyUsage = "ENCRYPT_DECRYPT";

  @doc("Creates a multi-Region primary key that you can replicate in other AWS-Regions. You can't change the ``MultiRegion`` value after the KMS key is created. For a list of AWS-Regions in which multi-Region keys are supported, see [Multi-Region keys in](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the **.  If you change the value of the ``MultiRegion`` property on an existing KMS key, the update request fails, regardless of the value of the [UpdateReplacePolicy attribute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatereplacepolicy.html). This prevents you from accidentally deleting a KMS key by changing an immutable property value.  For a multi-Region key, set to this property to ``true``. For a single-Region key, omit this property or set it to ``false``. The default value is ``false``.  *Multi-Region keys* are an KMS feature that lets you create multiple interoperable KMS keys in different AWS-Regions. Because these KMS keys have the same key ID, key material, and other metadata, you can use them to encrypt data in one AWS-Region and decrypt it in a different AWS-Region without making a cross-Region call or exposing the plaintext data. For more information, see [Multi-Region keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the *Developer Guide*. You can create a symmetric encryption, HMAC, or asymmetric multi-Region KMS key, and you can create a multi-Region key with imported key material. However, you cannot create a multi-Region key in a custom key store. To create a replica of this primary key in a different AWS-Region , create an [AWS::KMS::ReplicaKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-replicakey.html) resource in a CloudFormation stack in the replica Region. Specify the key ARN of this primary key.")
  multiRegion?: boolean;

  @doc("The source of the key material for the KMS key. You cannot change the origin after you create the KMS key. The default is ``AWS_KMS``, which means that KMS creates the key material. To [create a KMS key with no key material](https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-create-cmk.html) (for imported key material), set this value to ``EXTERNAL``. For more information about importing key material into KMS, see [Importing Key Material](https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html) in the *Developer Guide*. You can ignore ``ENABLED`` when Origin is ``EXTERNAL``. When a KMS key with Origin ``EXTERNAL`` is created, the key state is ``PENDING_IMPORT`` and ``ENABLED`` is ``false``. After you import the key material, ``ENABLED`` updated to ``true``. The KMS key can then be used for Cryptographic Operations.    CFN doesn't support creating an ``Origin`` parameter of the ``AWS_CLOUDHSM`` or ``EXTERNAL_KEY_STORE`` values.")
  origin?: Origin = "AWS_KMS";

  @doc("Specifies the number of days in the waiting period before KMS deletes a KMS key that has been removed from a CloudFormation stack. Enter a value between 7 and 30 days. The default value is 30 days. When you remove a KMS key from a CloudFormation stack, KMS schedules the KMS key for deletion and starts the mandatory waiting period. The ``PendingWindowInDays`` property determines the length of waiting period. During the waiting period, the key state of KMS key is ``Pending Deletion`` or ``Pending Replica Deletion``, which prevents the KMS key from being used in cryptographic operations. When the waiting period expires, KMS permanently deletes the KMS key.  KMS will not delete a [multi-Region primary key](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) that has replica keys. If you remove a multi-Region primary key from a CloudFormation stack, its key state changes to ``PendingReplicaDeletion`` so it cannot be replicated or used in cryptographic operations. This state can persist indefinitely. When the last of its replica keys is deleted, the key state of the primary key changes to ``PendingDeletion`` and the waiting period specified by ``PendingWindowInDays`` begins. When this waiting period expires, KMS deletes the primary key. For details, see [Deleting multi-Region keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-delete.html) in the *Developer Guide*. You cannot use a CloudFormation template to cancel deletion of the KMS key after you remove it from the stack, regardless of the waiting period. If you specify a KMS key in your template, even one with the same name, CloudFormation creates a new KMS key. To cancel deletion of a KMS key, use the KMS console or the [CancelKeyDeletion](https://docs.aws.amazon.com/kms/latest/APIReference/API_CancelKeyDeletion.html) operation. For information about the ``Pending Deletion`` and ``Pending Replica Deletion`` key states, see [Key state: Effect on your KMS key](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html) in the *Developer Guide*. For more information about deleting KMS keys, see the [ScheduleKeyDeletion](https://docs.aws.amazon.com/kms/latest/APIReference/API_ScheduleKeyDeletion.html) operation in the *API Reference* and [Deleting KMS keys](https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html) in the *Developer Guide*.")
  pendingWindowInDays?: int32;

  @doc("Property rotationPeriodInDays")
  rotationPeriodInDays?: int32 = 365;

  @doc("Assigns one or more tags to the replica key.  Tagging or untagging a KMS key can allow or deny permission to the KMS key. For details, see [ABAC for](https://docs.aws.amazon.com/kms/latest/developerguide/abac.html) in the *Developer Guide*.  For information about tags in KMS, see [Tagging keys](https://docs.aws.amazon.com/kms/latest/developerguide/tagging-keys.html) in the *Developer Guide*. For information about tags in CloudFormation, see [Tag](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-resource-tags.html).")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("KeySpec enum")
union KeySpec {
  @doc("KeySpec enum ECC_NIST_P256")
  ECC_NIST_P256: "ECC_NIST_P256",

  @doc("KeySpec enum ECC_NIST_P384")
  ECC_NIST_P384: "ECC_NIST_P384",

  @doc("KeySpec enum ECC_NIST_P521")
  ECC_NIST_P521: "ECC_NIST_P521",

  @doc("KeySpec enum ECC_SECG_P256K1")
  ECC_SECG_P256K1: "ECC_SECG_P256K1",

  @doc("KeySpec enum HMAC_224")
  HMAC_224: "HMAC_224",

  @doc("KeySpec enum HMAC_256")
  HMAC_256: "HMAC_256",

  @doc("KeySpec enum HMAC_384")
  HMAC_384: "HMAC_384",

  @doc("KeySpec enum HMAC_512")
  HMAC_512: "HMAC_512",

  @doc("KeySpec enum RSA_2048")
  RSA_2048: "RSA_2048",

  @doc("KeySpec enum RSA_3072")
  RSA_3072: "RSA_3072",

  @doc("KeySpec enum RSA_4096")
  RSA_4096: "RSA_4096",

  @doc("KeySpec enum SM2")
  SM2: "SM2",

  @doc("KeySpec enum SYMMETRIC_DEFAULT")
  SYMMETRIC_DEFAULT: "SYMMETRIC_DEFAULT",

  string,
}

@doc("Origin enum")
union Origin {
  @doc("Origin enum AWS_KMS")
  AWS_KMS: "AWS_KMS",

  @doc("Origin enum EXTERNAL")
  EXTERNAL: "EXTERNAL",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@doc("KeyUsage enum")
union KeyUsage {
  @doc("KeyUsage enum ENCRYPT_DECRYPT")
  ENCRYPT_DECRYPT: "ENCRYPT_DECRYPT",

  @doc("KeyUsage enum GENERATE_VERIFY_MAC")
  GENERATE_VERIFY_MAC: "GENERATE_VERIFY_MAC",

  @doc("KeyUsage enum SIGN_VERIFY")
  SIGN_VERIFY: "SIGN_VERIFY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface KmsKeys {
  get is ArmResourceRead<KmsKey>;
  @doc("Create a KmsKey. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<KmsKey>;
  update is ArmCustomPatchAsync<
    KmsKey,
    Azure.ResourceManager.Foundations.TagsUpdateModel<KmsKey>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<KmsKey>;
  listByResourceGroup is ArmResourceListByParent<KmsKey>;
  listBySubscription is ArmListBySubscription<KmsKey>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::KMS::Key
//--------------------------------------------------------------------------------------------
