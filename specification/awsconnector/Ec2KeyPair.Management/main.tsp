import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
  version: "2024-08-01-preview",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

//---------------------------------------------- Ec2KeyPairs ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@doc("A Microsoft.AwsConnector resource")
model Ec2KeyPair is TrackedResource<Ec2KeyPairProperties> {
  @doc("Name of Ec2KeyPair")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("ec2KeyPairs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Ec2KeyPair")
model Ec2KeyPairProperties {
  @doc("Gets and sets the property awsProperties.")
  awsProperties?: AwsEc2KeyPairProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of awsEc2KeyPair")
model AwsEc2KeyPairProperties {
  @doc("Gets and sets the property keyFingerprint. A short sequence of bytes used for public key verification")
  keyFingerprint?: string;

  @doc("Gets and sets the property keyFormat. The format of the private key")
  keyFormat?: KeyFormat;

  @doc("Gets and sets the property keyName. The name of the SSH key pair")
  keyName?: string;

  @doc("Gets and sets the property keyPairId. An AWS generated ID for the key pair")
  keyPairId?: string;

  @doc("Gets and sets the property keyType. The crypto-system used to generate a key pair.")
  keyType?: KeyType;

  @doc("Gets and sets the property publicKeyMaterial. Plain text public key to import")
  publicKeyMaterial?: string;

  @doc("Gets and sets the property tags. An array of key-value pairs to apply to this resource.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("KeyFormat enum")
enum KeyFormat {
  @doc("KeyFormat enum pem")
  pem: "pem",

  @doc("KeyFormat enum ppk")
  ppk: "ppk",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
@doc("Definition of Tag")
model Tag {
  @doc("Gets and sets the property key. The key name of the tag. You can specify a value that is 1 to 128 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  key?: string;

  @doc("Gets and sets the property value. The value for the tag. You can specify a value that is 0 to 256 Unicode characters in length and cannot be prefixed with aws:. You can use any of the following characters: the set of Unicode letters, digits, whitespace, _, ., /, =, +, and -.")
  value?: string;
}

@doc("KeyType enum")
enum KeyType {
  @doc("KeyType enum ed25519")
  ed25519: "ed25519",

  @doc("KeyType enum rsa")
  rsa: "rsa",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2KeyPairs {
  get is ArmResourceRead<Ec2KeyPair>;
  @doc("Create a Ec2KeyPair. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Ec2KeyPair>;
  update is ArmCustomPatchAsync<
    Ec2KeyPair,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Ec2KeyPair>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Ec2KeyPair>;
  listByResourceGroup is ArmResourceListByParent<Ec2KeyPair>;
  listBySubscription is ArmListBySubscription<Ec2KeyPair>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EC2::KeyPair
//--------------------------------------------------------------------------------------------
