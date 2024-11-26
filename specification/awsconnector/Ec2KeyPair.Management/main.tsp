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

//---------------------------------------------- Ec2KeyPairs ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EC2 Key Pair",
    plural: "EC2 Key Pairs",
  },
  keywords: ["Microsoft.AwsConnector", "EC2", "Key", "Pair"],
})
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Ec2KeyPair")
model Ec2KeyPairProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEc2KeyPairProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEc2KeyPair")
model AwsEc2KeyPairProperties {
  @doc("Property keyFingerprint")
  keyFingerprint?: string;

  @doc("The format of the key pair. Default: ``pem``")
  keyFormat?: KeyFormat = "pem";

  @doc("A unique name for the key pair. Constraints: Up to 255 ASCII characters")
  keyName?: string;

  @doc("Property keyPairId")
  keyPairId?: string;

  @doc("The type of key pair. Note that ED25519 keys are not supported for Windows instances. If the ``PublicKeyMaterial`` property is specified, the ``KeyType`` property is ignored, and the key type is inferred from the ``PublicKeyMaterial`` value. Default: ``rsa``")
  keyType?: KeyType = "rsa";

  @doc("The public key material. The ``PublicKeyMaterial`` property is used to import a key pair. If this property is not specified, then a new key pair will be created.")
  publicKeyMaterial?: string;

  @doc("The tags to apply to the key pair.")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

@doc("KeyFormat enum")
union KeyFormat {
  @doc("KeyFormat enum pem")
  pem: "pem",

  @doc("KeyFormat enum ppk")
  ppk: "ppk",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("The tag key.")
  key?: string;

  @doc("The tag value.")
  value?: string;
}

@doc("KeyType enum")
union KeyType {
  @doc("KeyType enum ed25519")
  ed25519: "ed25519",

  @doc("KeyType enum rsa")
  rsa: "rsa",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Ec2KeyPairs {
  get is ArmResourceRead<Ec2KeyPair>;
  @doc("Create a Ec2KeyPair. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Ec2KeyPair>;
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
