// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace NotificationHubs.Models;

@doc("Represents a direct send notification request.")
model DirectSendRequest {
  @doc("Direct send operation")
  @query direct: true,
  @doc("The notification target device handle")
  @header("ServiceBusNotification-DeviceHandle") deviceHandle: string;
}

@doc("Represents an audience notification request.")
model AudienceSendRequest {
  @doc("The notification target tag expression")
  @header("ServiceBusNotification-Tags") tags?: string
}

alias NotificationAudienceRequest = DirectSendRequest | AudienceSendRequest;

@doc("Represents an Apple based notification request.")
model AppleNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "apple"
}

@doc("Represents an Amazon Device Messaging based notification request.")
model AdmNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "adm"
}

@doc("Represents a Web Push based notification request.")
model BrowserNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8";
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "browser";
  @doc("The P256DH key for the browser push subscription")
  @header("P256DH") p256dh: string;
  @doc("The Auth key for the browser push subscription")
  @header("Auth") auth: string;
}

@doc("Represents a Baidu based notification request.")
model BaiduNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "baidu"
}

@doc("Represents a Firebase Legacy HTTP based notification request.")
model FirebaseLegacyNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "gcm"
}

@doc("Represents a Xiaomi based notification request.")
model XiaomiNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "xiaomi"
}

@doc("Represents a WNS Badge based notification request.")
model WindowsBadgeNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/xml",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "windows";
  @doc("The WNS type")
  @header("X-WNS-Type") type: "wns/badge";
}

@doc("Represents a WNS Tile based notification request.")
model WindowsTileNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/xml",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "windows";
  @doc("The WNS type")
  @header("X-WNS-Type") type: "wns/tile";
}

@doc("Represents a WNS Toast based notification request.")
model WindowsToastNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/xml",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "windows";
  @doc("The WNS type")
  @header("X-WNS-Type") type: "wns/toast";
}

@doc("Represents a WNS Raw based notification request.")
model WindowsRawNotificationRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/octet-stream",
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: "windows";
  @doc("The WNS type")
  @header("X-WNS-Type") type: "wns/raw";
}

alias DeviceNotificationRequest = AppleNotificationRequest
  | AdmNotificationRequest
  | BrowserNotificationRequest
  | BaiduNotificationRequest
  | FirebaseLegacyNotificationRequest
  | XiaomiNotificationRequest
  | WindowsBadgeNotificationRequest
  | WindowsTileNotificationRequest
  | WindowsToastNotificationRequest
  | WindowsRawNotificationRequest;

@doc("The request to a notification hub scheduled send action.")
model ScheduledNotificationSendRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8" | "application/xml;charset=utf-8" | "application/octet-stream",
  @doc("The notification to send")
  @body notification: string,
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: string,
  @doc("The notification target tag expression")
  @header("ServiceBusNotification-Tags") tags?: string;
  @doc("The notification schedule time")
  @header("ServiceBusNotification-ScheduleTime") scheduleTime: string;
}

@doc("The request to cancel a scheduled notification.")
model CancelScheduledNotificationRequest {
  @doc("The ID of the notification to cancel")
  @path notificationId: string
}

@doc("The request to a notification hub send action.")
model NotificationSendRequest {
  @doc("Content-Type header for the request")
  @header("Content-Type") contentType: "application/json;charset=utf-8" | "application/xml;charset=utf-8" | "application/octet-stream",
  @doc("Direct send operation")
  @query direct?: boolean,
  @doc("Enables test send for debug purposes")
  @query test: boolean,
  @doc("The notification to send")
  @body notification: string,
  @doc("The notification target platform")
  @header("ServiceBusNotification-Format") platform: string,
  @doc("The notification target device handle")
  @header("ServiceBusNotification-DeviceHandle") deviceHandle?: string;
  @doc("The notification target tag expression")
  @header("ServiceBusNotification-Tags") tags?: string
}

@doc("The response to a notification hub create or update operation.")
model NotificationResponse {
  @doc("Successful status code from the response")
  @statusCode statusCode: 201;
  @doc("The location header from the response")
  @header location?: string;
  @doc("The tracking ID header from the response")
  @header trackingId: string;
  @doc("The correlation ID header from the response")
  @header("x-ms-correlation-request-id") correlationId: string;
  @doc("The body which may contain an error in XML format")
  @body outcome?: string;
}