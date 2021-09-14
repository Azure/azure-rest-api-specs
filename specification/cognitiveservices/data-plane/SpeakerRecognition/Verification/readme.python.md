## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  license-header: MICROSOFT_MIT_NO_VERSION
  add-credentials: true
  payload-flattening-threshold: 2
  namespace: azure.cognitiveservices.speech.speaker.verification
  package-name: azure-cognitiveservices-speech-speaker-verification
  clear-output-folder: true
  no-namespace-folders: true
```

``` yaml $(tag) == 'release_2021-09-05'
namespace: azure.cognitiveservices.speech.speaker.verification
output-folder: $(python-sdks-folder)/cognitiveservices/speech/speaker/verification
```

``` yaml $(tag) == 'verification_v2_0_preview'
namespace: azure.cognitiveservices.speech.speaker.verification
output-folder: $(python-sdks-folder)/cognitiveservices/speech/speaker/verification
```
