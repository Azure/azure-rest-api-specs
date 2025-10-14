// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as iterator from '@ts-common/iterator'

/**
 * The function generates a lot of `Hello world!` strings to test `exec` stdout buffer.
 */
export const generate = () => iterator.repeat('Hello world!', 100000)

/**
 * The function prints to `stdout` a lot of `Hello world!` strings to test `exec` function.
 */
export const print = () => generate().forEach((v) => console.log(v))
