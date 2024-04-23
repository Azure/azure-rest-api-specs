import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

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
  /** 2024-08-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-08-01-preview`,
}

//---------------------------------------------- KmsKeys ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
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
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsKmsKeyProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsKmsKey")
model AwsKmsKeyProperties {
  @doc("Gets and sets the property arn.")
  arn?: string;

  @doc("Gets and sets the property bypassPolicyLockoutSafetyCheck. Skips ('bypasses') the key policy lockout safety check. The default value is false.")
  bypassPolicyLockoutSafetyCheck?: boolean;

  @doc("Gets and sets the property description. A description of the AWS KMS key. Use a description that helps you to distinguish this AWS KMS key from others in the account, such as its intended use.")
  description?: string;

  @doc("Gets and sets the property enableKeyRotation. Enables automatic rotation of the key material for the specified AWS KMS key. By default, automation key rotation is not enabled.")
  enableKeyRotation?: boolean;

  @doc("Gets and sets the property enabled. Specifies whether the AWS KMS key is enabled. Disabled AWS KMS keys cannot be used in cryptographic operations.")
  enabled?: boolean;

  @doc("Gets and sets the property keyId.")
  keyId?: string;

  @doc("Gets and sets the property keyPolicy. The key policy that authorizes use of the AWS KMS key. The key policy must observe the following rules.")
  keyPolicy?: string;

  @doc("Gets and sets the property keySpec. Specifies the type of AWS KMS key to create. The default value is SYMMETRIC_DEFAULT. This property is required only for asymmetric AWS KMS keys. You can't change the KeySpec value after the AWS KMS key is created.")
  keySpec?: KeySpec;

  @doc("Gets and sets the property keyUsage. Determines the cryptographic operations for which you can use the AWS KMS key. The default value is ENCRYPT_DECRYPT. This property is required only for asymmetric AWS KMS keys. You can't change the KeyUsage value after the AWS KMS key is created.")
  keyUsage?: KeyUsage;

  @doc("Gets and sets the property multiRegion. Specifies whether the AWS KMS key should be Multi-Region. You can't change the MultiRegion value after the AWS KMS key is created.")
  multiRegion?: boolean;

  @doc("Gets and sets the property origin. The source of the key material for the KMS key. You cannot change the origin after you create the KMS key. The default is AWS_KMS, which means that AWS KMS creates the key material.")
  origin?: Origin;

  @doc("Gets and sets the property pendingWindowInDays. Specifies the number of days in the waiting period before AWS KMS deletes an AWS KMS key that has been removed from a CloudFormation stack. Enter a value between 7 and 30 days. The default value is 30 days.")
  pendingWindowInDays?: int32;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
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
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KmsKey>;
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
