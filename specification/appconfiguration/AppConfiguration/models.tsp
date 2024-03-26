import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AzureAppConfiguration;

enum KeyValueFields {
  key,
  label,
  content_type,
  value,
  last_modified,
  tags,
  locked,
  etag,
}

enum SnapshotFields {
  name,
  status,
  filters,
  composition_type,
  created,
  expires,
  retention_period,
  size,
  items_count,
  tags,
  etag,
}

enum SnapshotStatus {
  provisioning,
  ready,
  archived,
  failed,
}

enum CompositionType {
  key,
  key_label,
}

enum LabelFields {
  name,
}

@doc("The result of a list request.")
@pagedResult
model KeyListResult {
  @doc("The collection value.")
  @items
  items?: Key[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  @projectedName("json", "@nextLink")
  NextLink?: string;
}

model Key {
  @doc("The name of the key.")
  @visibility("read")
  name?: string;
}

@doc("Azure App Configuration error object.")
@error
model Error {
  @doc("The type of the error.")
  type?: string;

  @doc("A brief summary of the error.")
  title?: string;

  @doc("The name of the parameter that resulted in the error.")
  name?: string;

  @doc("A detailed description of the error.")
  detail?: string;

  @doc("The HTTP status code that the error maps to.")
  status?: int32;
}

@doc("The result of a list request.")
@pagedResult
model KeyValueListResult {
  @doc("The collection value.")
  @items
  items?: KeyValue[];

  @doc("An identifier representing the returned state of the resource.")
  etag?: string;

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  @projectedName("json", "@nextLink")
  NextLink?: string;
}

model KeyValue {
  @doc("The key of the key-value.")
  key?: string;

  @doc("The label the key-value belongs to.")
  label?: string;

  @doc("The content type of the value stored within the key-value.")
  @projectedName("json", "content_type")
  contentType?: string;

  @doc("The value of the key-value.")
  value?: string;

  @doc("A date representing the last time the key-value was modified.")
  @projectedName("json", "last_modified")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  @doc("The tags of the key-value")
  tags?: Record<string>;

  @doc("Indicates whether the key-value is locked.")
  locked?: boolean;

  @doc("A value representing the current state of the resource.")
  etag?: string;
}

@doc("The result of a snapshot list request.")
@pagedResult
model SnapshotListResult {
  @doc("The collection value.")
  @items
  items?: Snapshot[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  @projectedName("json", "@nextLink")
  NextLink?: string;
}

model Snapshot {
  @doc("The name of the snapshot.")
  @visibility("read")
  name?: string;

  @doc("The current status of the snapshot.")
  @visibility("read")
  status?: SnapshotStatus;

  @doc("A list of filters used to filter the key-values included in the snapshot.")
  filters: KeyValueFilter[];

  @doc("""
The composition type describes how the key-values within the snapshot are
composed. The 'key' composition type ensures there are no two key-values
containing the same key. The 'key_label' composition type ensures there are no
two key-values containing the same key and label.
""")
  @projectedName("json", "composition_type")
  compositionType?: CompositionType;

  @doc("The time that the snapshot was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  @doc("The time that the snapshot will expire.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;

  @doc("""
The amount of time, in seconds, that a snapshot will remain in the archived
state before expiring. This property is only writable during the creation of a
snapshot. If not specified, the default lifetime of key-value revisions will be
used.
""")
  @maxValue(7776000)
  @minValue(3600)
  @projectedName("json", "retention_period")
  retentionPeriod?: int32;

  @doc("The size in bytes of the snapshot.")
  @visibility("read")
  size?: int32;

  @doc("The amount of key-values in the snapshot.")
  @visibility("read")
  @projectedName("json", "items_count")
  itemsCount?: int32;

  @doc("The tags of the snapshot.")
  tags?: Record<string>;

  @doc("A value representing the current state of the snapshot.")
  @visibility("read")
  etag?: string;
}

@doc("""
Enables filtering of key-values. Syntax reference:
https://aka.ms/azconfig/docs/restapisnapshots
""")
model KeyValueFilter {
  @doc("Filters key-values by their key field.")
  key: string;

  @doc("Filters key-values by their label field.")
  label?: string;

  @doc("Filters key-values by their tags field.")
  tags?: string[];
}

@doc("Parameters used to update a snapshot.")
model SnapshotUpdateParameters {
  @doc("The desired status of the snapshot.")
  status?: SnapshotStatus;
}

@doc("The result of a list request.")
@pagedResult
model LabelListResult {
  @doc("The collection value.")
  @items
  items?: Label[];

  @doc("The URI that can be used to request the next set of paged results.")
  @nextLink
  @projectedName("json", "@nextLink")
  NextLink?: string;
}

model Label {
  @doc("The name of the label.")
  @visibility("read")
  name?: string;
}

@doc("Details of a long running operation.")
model OperationDetails {
  @doc("The unique id of the operation.")
  id: string;

  @doc("The current status of the operation")
  status: Azure.Core.Foundations.OperationState;

  @doc("""
An error, available when the status is `Failed`, describing why the operation
failed.
""")
  error?: ErrorDetail;
}

@doc("The details of an error.")
model ErrorDetail {
  @doc("One of a server-defined set of error codes.")
  code: string;

  @doc("A human-readable representation of the error.")
  message: string;

  @doc("An array of details about specific errors that led to this reported error.")
  details?: ErrorDetail[];

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innererror?: InnerError;
}

@doc("An object containing specific information about an error.")
model InnerError {
  @doc("One of a server-defined set of error codes.")
  code?: string;

  @doc("""
An object containing more specific information than the current object about
the error.
""")
  innererror?: InnerError;
}
