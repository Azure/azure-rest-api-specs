# Cognitive Services Language SDK

The Cognitive Service Language SDK has support for the Text Analytics Cognitive Service.
While this repository contains the [Autorest](https://aka.ms/autorest) generated SDK, the easiest way to consume the SDK is by installing the Nuget package for it.

Note that the Cognitive Services Language SDK is simply a wrapper on top of the Text Analytics Cognitive service. As such, it will generate calls to the Azure service.


## Prerequisites
You must have a [Cognitive Services API account](https://docs.microsoft.com/azure/cognitive-services/cognitive-services-apis-create-account) with **Text Analytics API**.

You must also have the [endpoint and access key](../How-tos/text-analytics-how-to-access-key.md) that was generated for you during sign up.

## Installing the Nuget SDK Package
1. Create a new Console solution in Visual Studio.
1. Right click on the solution and click **Manage NuGet Packages for Solution**
1. Mark the **Include Prerelease** checkbox.
1. Select the **Browse** tab, and Search for **Microsoft.Azure.CognitiveServices.Language**
1. Select the Nuget package and install it.

## Calling the Text Analytics API using the SDK
The following code snippets show to consume the SDK. Note that you will need to replace `client.SubscriptionKey` with the key you received when you signed up and `client.AzureRegion` with the region you signed up for.

```c#
using System;
using Microsoft.Azure.CognitiveServices.Language.TextAnalytics;
using Microsoft.Azure.CognitiveServices.Language.TextAnalytics.Models;
using System.Collections.Generic;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create a client.
            ITextAnalyticsAPI client = new TextAnalyticsAPI();
            client.AzureRegion = AzureRegions.Westus;
            client.SubscriptionKey = "ENTER KEY HERE";

            Console.OutputEncoding = System.Text.Encoding.UTF8;

            // Extracting language
            Console.WriteLine("===== LANGUAGE EXTRACTION ======");

            LanguageBatchResult result = client.DetectLanguage(
                    new BatchInput(
                        new List<Input>()
                        {
                          new Input("1", "This is a document written in English."),
                          new Input("2", "Este es un document escrito en Español."),
                          new Input("3", "这是一个用中文写的文件")
                        }));

            // Printing language results.
            foreach (var document in result.Documents)
            {
                Console.WriteLine("Document ID: {0} , Language: {1}", document.Id, document.DetectedLanguages[0].Name);
            }

            // Getting key-phrases
            Console.WriteLine("\n\n===== KEY-PHRASE EXTRACTION ======");

            KeyPhraseBatchResult result2 = client.KeyPhrases(
                    new MultiLanguageBatchInput(
                        new List<MultiLanguageInput>()
                        {
                          new MultiLanguageInput("ja", "1", "猫は幸せ"),
                          new MultiLanguageInput("de", "2", "Fahrt nach Stuttgart und dann zum Hotel zu Fu."),
                          new MultiLanguageInput("en", "3", "My cat is stiff as a rock."),
                          new MultiLanguageInput("es", "4", "A mi me encanta el fútbol!")
                        }));


            // Printing keyphrases
            foreach (var document in result2.Documents)
            {
                Console.WriteLine("Document ID: {0} ", document.Id);

                Console.WriteLine("\t Key phrases:");

                foreach (string keyphrase in document.KeyPhrases)
                {
                    Console.WriteLine("\t\t" + keyphrase);
                }
            }

            // Extracting sentiment
            Console.WriteLine("\n\n===== SENTIMENT ANALYSIS ======");

            SentimentBatchResult result3 = client.Sentiment(
                    new MultiLanguageBatchInput(
                        new List<MultiLanguageInput>()
                        {
                          new MultiLanguageInput("en", "0", "I had the best day of my life."),
                          new MultiLanguageInput("en", "1", "This was a waste of my time. The speaker put me to sleep."),
                          new MultiLanguageInput("es", "2", "No tengo dinero ni nada que dar..."),
                          new MultiLanguageInput("it", "3", "L'hotel veneziano era meraviglioso. È un bellissimo pezzo di architettura."),
                        }));


            // Printing sentiment results
            foreach (var document in result3.Documents)
            {
                Console.WriteLine("Document ID: {0} , Sentiment Score: {1:0.00}", document.Id, document.Score);
            }

        }
    }
}
```

## Releases

> see https://aka.ms/autorest

The current release is `release_2_0`.
A preview release `release_2_1` is also available.

``` yaml
tag: release_2_0
add-credentials: true
```

### Release 2.0

These settings apply only when `--tag=release_2_0` is specified on the command line.

``` yaml $(tag) == 'release_2_0'
input-file: stable/v2.0/TextAnalytics.json
log-file: logs/log.txt
```

### Release 2.1-Preview

These settings apply only when `--tag=release_2_1` is specified on the command line.

``` yaml $(tag) == 'release_2_1'
input-file: preview/v2.1/TextAnalytics.json
log-file: logs/log.txt
```

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_cognitiveservices_textanalytics']
```

## CSharp Settings

These settings apply only when `--csharp` is specified on the command line.

``` yaml $(csharp)
csharp:
  sync-methods: None
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.Azure.CognitiveServices.Language.TextAnalytics
  output-folder: $(csharp-sdks-folder)/CognitiveServices/dataPlane/Language/TextAnalytics/Generated/TextAnalytics
  clear-output-folder: true
```

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
  namespace: azure.cognitiveservices.language.textanalytics
  package-name: azure-cognitiveservices-language-textanalytics
  clear-output-folder: true
```

``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-language-textanalytics/azure/cognitiveservices/language/textanalytics
```

``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-cognitiveservices-language-textanalytics
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: com.microsoft.azure.cognitiveservices.language.textanalytics
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/cognitiveservices/data-plane/language/textanalytics
  with-optional-parameters: true
  with-single-async-method: true
```
