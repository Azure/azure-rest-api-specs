## Python

These settings apply only when `--track2` is specified on the command line.

``` yaml $(python)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
package-name: azure-mgmt-recoveryservicesbackup
package-version: 1.0.0b1
no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python)
clear-output-folder: true
batch:
  - tag: package-passivestamp-2021-11-15
  - tag: package-2025-02-01
```

### Tag: package-passivestamp-2021-11-15 and python

These settings apply only when `--tag=package-passivestamp-2021-11-15 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-passivestamp-2021-11-15'
title: Recovery Services Backup Passive Client
namespace: azure.mgmt.recoveryservicesbackup.passivestamp
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/passivestamp
```

### Tag: package-2025-02-01 and python

These settings apply only when `--package-2025-02-01 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2025-02-01'
namespace: azure.mgmt.recoveryservicesbackup.activestamp
output-folder: $(python-sdks-folder)/recoveryservices/azure-mgmt-recoveryservicesbackup/azure/mgmt/recoveryservicesbackup/activestamp
```

``` yaml $(python)
modelerfour:
  lenient-model-deduplication: true
directive:
  - from: swagger-document
    where: $.definitions.ProtectionIntent
    transform: >
        $['required'] = ['protectionIntentItemType'];
  - from: swagger-document
    where: $.definitions.FeatureSupportRequest
    transform: >
        $['required'] = ['featureType'];
  - from: swagger-document
    where: $.definitions.OperationWorkerResponse.properties.statusCode
    transform: >
         $['x-ms-enum'] = {
            "name": "HttpStatusCode",
            "modelAsString": false,
            "values": [
                {
                  'name': 'CONTINUE_ENUM',
                  'value': 'Continue'
                },
                {
                  'name': 'SWITCHING_PROTOCOLS',
                  'value': 'SwitchingProtocols'
                },
                {
                  'name': 'OK',
                  'value': 'OK'
                },
                {
                  'name': 'CREATED',
                  'value': 'Created'
                },
                {
                  'name': 'ACCEPTED',
                  'value': 'Accepted'
                },
                {
                  'name': 'NON_AUTHORITATIVE_INFORMATION',
                  'value': 'NonAuthoritativeInformation'
                },
                {
                  'name': 'NO_CONTENT',
                  'value': 'NoContent'
                },
                {
                  'name': 'RESET_CONTENT',
                  'value': 'ResetContent'
                },
                {
                  'name': 'PARTIAL_CONTENT',
                  'value': 'PartialContent'
                },
                {
                  'name': 'MULTIPLE_CHOICES',
                  'value': 'MultipleChoices'
                },
                {
                  'name': 'AMBIGUOUS',
                  'value': 'Ambiguous'
                },
                {
                  'name': 'MOVED_PERMANENTLY',
                  'value': 'MovedPermanently'
                },
                {
                  'name': 'MOVED',
                  'value': 'Moved'
                },
                {
                  'name': 'FOUND',
                  'value': 'Found'
                },
                {
                  'name': 'REDIRECT',
                  'value': 'Redirect'
                },
                {
                  'name': 'SEE_OTHER',
                  'value': 'SeeOther'
                },
                {
                  'name': 'REDIRECT_METHOD',
                  'value': 'RedirectMethod'
                },
                {
                  'name': 'NOT_MODIFIED',
                  'value': 'NotModified'
                },
                {
                  'name': 'USE_PROXY',
                  'value': 'UseProxy'
                },
                {
                  'name': 'UNUSED',
                  'value': 'Unused'
                },
                {
                  'name': 'TEMPORARY_REDIRECT',
                  'value': 'TemporaryRedirect'
                },
                {
                  'name': 'REDIRECT_KEEP_VERB',
                  'value': 'RedirectKeepVerb'
                },
                {
                  'name': 'BAD_REQUEST',
                  'value': 'BadRequest'
                },
                {
                  'name': 'UNAUTHORIZED',
                  'value': 'Unauthorized'
                },
                {
                  'name': 'PAYMENT_REQUIRED',
                  'value': 'PaymentRequired'
                },
                {
                  'name': 'FORBIDDEN',
                  'value': 'Forbidden'
                },
                {
                  'name': 'NOT_FOUND',
                  'value': 'NotFound'
                },
                {
                  'name': 'METHOD_NOT_ALLOWED',
                  'value': 'MethodNotAllowed'
                },
                {
                  'name': 'NOT_ACCEPTABLE',
                  'value': 'NotAcceptable'
                },
                {
                  'name': 'PROXY_AUTHENTICATION_REQUIRED',
                  'value': 'ProxyAuthenticationRequired'
                },
                {
                  'name': 'REQUEST_TIMEOUT',
                  'value': 'RequestTimeout'
                },
                {
                  'name': 'CONFLICT',
                  'value': 'Conflict'
                },
                {
                  'name': 'GONE',
                  'value': 'Gone'
                },
                {
                  'name': 'LENGTH_REQUIRED',
                  'value': 'LengthRequired'
                },
                {
                  'name': 'PRECONDITION_FAILED',
                  'value': 'PreconditionFailed'
                },
                {
                  'name': 'REQUEST_ENTITY_TOO_LARGE',
                  'value': 'RequestEntityTooLarge'
                },
                {
                  'name': 'REQUEST_URI_TOO_LONG',
                  'value': 'RequestUriTooLong'
                },
                {
                  'name': 'UNSUPPORTED_MEDIA_TYPE',
                  'value': 'UnsupportedMediaType'
                },
                {
                  'name': 'REQUESTED_RANGE_NOT_SATISFIABLE',
                  'value': 'RequestedRangeNotSatisfiable'
                },
                {
                  'name': 'EXPECTATION_FAILED',
                  'value': 'ExpectationFailed'
                },
                {
                  'name': 'UPGRADE_REQUIRED',
                  'value': 'UpgradeRequired'
                },
                {
                  'name': 'INTERNAL_SERVER_ERROR',
                  'value': 'InternalServerError'
                },
                {
                  'name': 'NOT_IMPLEMENTED',
                  'value': 'NotImplemented'
                },
                {
                  'name': 'BAD_GATEWAY',
                  'value': 'BadGateway'
                },
                {
                  'name': 'SERVICE_UNAVAILABLE',
                  'value': 'ServiceUnavailable'
                },
                {
                  'name': 'GATEWAY_TIMEOUT',
                  'value': 'GatewayTimeout'
                },
                {
                  'name': 'HTTP_VERSION_NOT_SUPPORTED',
                  'value': 'HttpVersionNotSupported'
                }
            ]
         }
```
