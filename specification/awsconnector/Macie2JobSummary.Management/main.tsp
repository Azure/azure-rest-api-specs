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

//---------------------------------------------- Macie2JobSummaries ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Macie2 Job Summary",
    plural: "Macie2 Job Summaries",
  },
  keywords: ["Microsoft.AwsConnector", "Macie2", "Job", "Summary"],
})
@doc("A Microsoft.AwsConnector resource")
model Macie2JobSummary is TrackedResource<Macie2JobSummaryProperties> {
  @doc("Name of Macie2JobSummary")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("macie2JobSummaries")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Macie2JobSummary")
model Macie2JobSummaryProperties {
  @doc("AWS Properties")
  awsProperties?: AwsMacie2JobSummaryProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsMacie2JobSummary")
model AwsMacie2JobSummaryProperties {
  @doc("<p>The property- and tag-based conditions that determine which S3 buckets are included or excluded from the job's analysis. Each time the job runs, the job uses these criteria to determine which buckets to analyze. A job's definition can contain a bucketCriteria object or a bucketDefinitions array, not both.</p>")
  bucketCriteria?: S3BucketCriteriaForJob;

  @doc("<p>An array of objects, one for each Amazon Web Services account that owns specific S3 buckets for the job to analyze. Each object specifies the account ID for an account and one or more buckets to analyze for that account. A job's definition can contain a bucketDefinitions array or a bucketCriteria object, not both.</p>")
  @extension("x-ms-identifiers", [])
  bucketDefinitions?: S3BucketDefinitionForJob[];

  @doc("<p>The date and time, in UTC and extended ISO 8601 format, when the job was created.</p>")
  createdAt?: utcDateTime;

  @doc("<p>The unique identifier for the job.</p>")
  jobId?: string;

  @doc("<p>The current status of the job. Possible values are:</p> <ul><li><p>CANCELLED - You cancelled the job or, if it's a one-time job, you paused the job and didn't resume it within 30 days.</p></li> <li><p>COMPLETE - For a one-time job, Amazon Macie finished processing the data specified for the job. This value doesn't apply to recurring jobs.</p></li> <li><p>IDLE - For a recurring job, the previous scheduled run is complete and the next scheduled run is pending. This value doesn't apply to one-time jobs.</p></li> <li><p>PAUSED - Macie started running the job but additional processing would exceed the monthly sensitive data discovery quota for your account or one or more member accounts that the job analyzes data for.</p></li> <li><p>RUNNING - For a one-time job, the job is in progress. For a recurring job, a scheduled run is in progress.</p></li> <li><p>USER_PAUSED - You paused the job. If you paused the job while it had a status of RUNNING and you don't resume it within 30 days of pausing it, the job or job run will expire and be cancelled, depending on the job's type. To check the expiration date, refer to the UserPausedDetails.jobExpiresAt property.</p></li></ul>")
  jobStatus?: JobStatusEnumValue;

  @doc("<p>The schedule for running the job. Possible values are:</p> <ul><li><p>ONE_TIME - The job runs only once.</p></li> <li><p>SCHEDULED - The job runs on a daily, weekly, or monthly basis.</p></li></ul>")
  jobType?: JobTypeEnumValue;

  @doc("<p>Specifies whether any account- or bucket-level access errors occurred when the job ran. For a recurring job, this value indicates the error status of the job's most recent run.</p>")
  lastRunErrorStatus?: LastRunErrorStatus;

  @doc("<p>The custom name of the job.</p>")
  name?: string;

  @doc("<p>If the current status of the job is USER_PAUSED, specifies when the job was paused and when the job or job run will expire and be cancelled if it isn't resumed. This value is present only if the value for jobStatus is USER_PAUSED.</p>")
  userPausedDetails?: UserPausedDetails;
}

@doc("JobStatus enum")
union JobStatus {
  @doc("JobStatus enum CANCELLED")
  CANCELLED: "CANCELLED",

  @doc("JobStatus enum COMPLETE")
  COMPLETE: "COMPLETE",

  @doc("JobStatus enum IDLE")
  IDLE: "IDLE",

  @doc("JobStatus enum PAUSED")
  PAUSED: "PAUSED",

  @doc("JobStatus enum RUNNING")
  RUNNING: "RUNNING",

  @doc("JobStatus enum USER_PAUSED")
  USER_PAUSED: "USER_PAUSED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JobStatusEnumValue")
model JobStatusEnumValue {
  @doc("Property value")
  value?: JobStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3BucketCriteriaForJob")
model S3BucketCriteriaForJob {
  @doc("<p>The property- and tag-based conditions that determine which buckets to exclude from the job.</p>")
  excludes?: CriteriaBlockForJob;

  @doc("<p>The property- and tag-based conditions that determine which buckets to include in the job.</p>")
  includes?: CriteriaBlockForJob;
}

@doc("JobType enum")
union JobType {
  @doc("JobType enum ONE_TIME")
  ONE_TIME: "ONE_TIME",

  @doc("JobType enum SCHEDULED")
  SCHEDULED: "SCHEDULED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JobTypeEnumValue")
model JobTypeEnumValue {
  @doc("Property value")
  value?: JobType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3BucketDefinitionForJob")
model S3BucketDefinitionForJob {
  @doc("<p>The unique identifier for the Amazon Web Services account that owns the buckets.</p>")
  accountId?: string;

  @doc("<p>An array that lists the names of the buckets.</p>")
  @extension("x-ms-identifiers", [])
  buckets?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LastRunErrorStatus")
model LastRunErrorStatus {
  @doc("<p>Specifies whether any account- or bucket-level access errors occurred when the job ran. For a recurring job, this value indicates the error status of the job's most recent run. Possible values are:</p> <ul><li><p>ERROR - One or more errors occurred. Amazon Macie didn't process all the data specified for the job.</p></li> <li><p>NONE - No errors occurred. Macie processed all the data specified for the job.</p></li></ul>")
  code?: LastRunErrorStatusCodeEnumValue;
}

@doc("LastRunErrorStatusCode enum")
union LastRunErrorStatusCode {
  @doc("LastRunErrorStatusCode enum ERROR")
  ERROR: "ERROR",

  @doc("LastRunErrorStatusCode enum NONE")
  NONE: "NONE",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LastRunErrorStatusCodeEnumValue")
model LastRunErrorStatusCodeEnumValue {
  @doc("Property value")
  value?: LastRunErrorStatusCode;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of UserPausedDetails")
model UserPausedDetails {
  @doc("<p>The date and time, in UTC and extended ISO 8601 format, when the job or job run will expire and be cancelled if you don't resume it first.</p>")
  jobExpiresAt?: utcDateTime;

  @doc("<p>The Amazon Resource Name (ARN) of the Health event that Amazon Macie sent to notify you of the job or job run's pending expiration and cancellation. This value is null if a job has been paused for less than 23 days.</p>")
  jobImminentExpirationHealthEventArn?: string;

  @doc("<p>The date and time, in UTC and extended ISO 8601 format, when you paused the job.</p>")
  jobPausedAt?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CriteriaBlockForJob")
model CriteriaBlockForJob {
  @doc("<p>An array of conditions, one for each condition that determines which buckets to include or exclude from the job. If you specify more than one condition, Amazon Macie uses AND logic to join the conditions.</p>")
  @extension("x-ms-identifiers", [])
  and?: CriteriaForJob[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CriteriaForJob")
model CriteriaForJob {
  @doc("<p>A property-based condition that defines a property, operator, and one or more values for including or excluding buckets from the job.</p>")
  simpleCriterion?: SimpleCriterionForJob;

  @doc("<p>A tag-based condition that defines an operator and tag keys, tag values, or tag key and value pairs for including or excluding buckets from the job.</p>")
  tagCriterion?: TagCriterionForJob;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SimpleCriterionForJob")
model SimpleCriterionForJob {
  @doc("<p>The operator to use in the condition. Valid values are EQ (equals) and NE (not equals).</p>")
  comparator?: JobComparatorEnumValue;

  @doc("<p>The property to use in the condition.</p>")
  key?: SimpleCriterionKeyForJobEnumValue;

  @doc("<p>An array that lists one or more values to use in the condition. If you specify multiple values, Amazon Macie uses OR logic to join the values. Valid values for each supported property (key) are:</p> <ul><li><p>ACCOUNT_ID - A string that represents the unique identifier for the Amazon Web Services account that owns the bucket.</p></li> <li><p>S3_BUCKET_EFFECTIVE_PERMISSION - A string that represents an enumerated value that Macie defines for the <a href='https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketpublicaccess-effectivepermission'>BucketPublicAccess.effectivePermission</a> property of a bucket.</p></li> <li><p>S3_BUCKET_NAME - A string that represents the name of a bucket.</p></li> <li><p>S3_BUCKET_SHARED_ACCESS - A string that represents an enumerated value that Macie defines for the <a href='https://docs.aws.amazon.com/macie/latest/APIReference/datasources-s3.html#datasources-s3-prop-bucketmetadata-sharedaccess'>BucketMetadata.sharedAccess</a> property of a bucket.</p></li></ul> <p>Values are case sensitive. Also, Macie doesn't support use of partial values or wildcard characters in these values.</p>")
  @extension("x-ms-identifiers", [])
  values?: string[];
}

@doc("JobComparator enum")
union JobComparator {
  @doc("JobComparator enum CONTAINS")
  CONTAINS: "CONTAINS",

  @doc("JobComparator enum EQ")
  EQ: "EQ",

  @doc("JobComparator enum GT")
  GT: "GT",

  @doc("JobComparator enum GTE")
  GTE: "GTE",

  @doc("JobComparator enum LT")
  LT: "LT",

  @doc("JobComparator enum LTE")
  LTE: "LTE",

  @doc("JobComparator enum NE")
  NE: "NE",

  @doc("JobComparator enum STARTS_WITH")
  STARTS_WITH: "STARTS_WITH",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JobComparatorEnumValue")
model JobComparatorEnumValue {
  @doc("Property value")
  value?: JobComparator;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagCriterionForJob")
model TagCriterionForJob {
  @doc("<p>The operator to use in the condition. Valid values are EQ (equals) and NE (not equals).</p>")
  comparator?: JobComparatorEnumValue;

  @doc("<p>The tag keys, tag values, or tag key and value pairs to use in the condition.</p>")
  @extension("x-ms-identifiers", [])
  tagValues?: TagCriterionPairForJob[];
}

@doc("SimpleCriterionKeyForJob enum")
union SimpleCriterionKeyForJob {
  @doc("SimpleCriterionKeyForJob enum ACCOUNT_ID")
  ACCOUNT_ID: "ACCOUNT_ID",

  @doc("SimpleCriterionKeyForJob enum S3_BUCKET_EFFECTIVE_PERMISSION")
  S3_BUCKET_EFFECTIVE_PERMISSION: "S3_BUCKET_EFFECTIVE_PERMISSION",

  @doc("SimpleCriterionKeyForJob enum S3_BUCKET_NAME")
  S3_BUCKET_NAME: "S3_BUCKET_NAME",

  @doc("SimpleCriterionKeyForJob enum S3_BUCKET_SHARED_ACCESS")
  S3_BUCKET_SHARED_ACCESS: "S3_BUCKET_SHARED_ACCESS",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SimpleCriterionKeyForJobEnumValue")
model SimpleCriterionKeyForJobEnumValue {
  @doc("Property value")
  value?: SimpleCriterionKeyForJob;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of TagCriterionPairForJob")
model TagCriterionPairForJob {
  @doc("<p>The value for the tag key to use in the condition.</p>")
  key?: string;

  @doc("<p>The tag value to use in the condition.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface Macie2JobSummaries {
  get is ArmResourceRead<Macie2JobSummary>;
  @doc("Create a Macie2JobSummary. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Macie2JobSummary>;
  update is ArmCustomPatchAsync<
    Macie2JobSummary,
    Azure.ResourceManager.Foundations.TagsUpdateModel<Macie2JobSummary>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Macie2JobSummary>;
  listByResourceGroup is ArmResourceListByParent<Macie2JobSummary>;
  listBySubscription is ArmListBySubscription<Macie2JobSummary>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\macie2\macie2-2020-01-01.normal.json
// AWS Shape: JobSummary
//
// Related information for backend service:
// AWS Servcie : Macie2
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.46
//--------------------------------------------------------------------------------------------
