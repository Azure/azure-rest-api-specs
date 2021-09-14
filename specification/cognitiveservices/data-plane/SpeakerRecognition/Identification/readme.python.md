## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  namespace: azure.cognitiveservices.speech.speaker.identification
  package-name: azure-cognitiveservices-speech-speaker-identification
  credential-scopes: https://cognitiveservices.azure.com/.default
  clear-output-folder: true
  no-namespace-folders: true

```

``` yaml $(tag) == 'release_2021-09-05'
namespace: azure.cognitiveservices.speech.speaker.identification.2021-09-05
output-folder: $(python-sdks-folder)/cognitiveservices/speech/speaker/identification/_generated/2021-09-05
```

``` yaml $(tag) == 'identification_v2_0_preview'
namespace: azure.cognitiveservices.speech.speaker.identification.v2_0_preview
output-folder: $(python-sdks-folder)/cognitiveservices/speech/speaker/identification/_generated/v2_0_preview
```

```yaml $(multiapi)
batch:
  - tag: release_2021-09-05
  - tag: identification_v2_0_preview
  - multiapiscript: true
```

``` yaml $(multiapiscript)
output-folder: $(python-sdks-folder)/cognitiveservices/speech/speaker/identification/_generated/_generated
clear-output-folder: false
perform-load: false
default-api: release_2021-09-05
```
