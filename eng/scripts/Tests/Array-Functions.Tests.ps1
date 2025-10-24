BeforeAll { 
    . "$PSScriptRoot\..\Array-Functions.ps1"
}

# 0..78 makes an array of 79 (prime number) items

Describe "ShardArray" { 
    Context "Input Validation" { 
        It "throws when sharding into more pieces than there are elements" { 
            $array = 0..78
            $shard = 0
            $totalShards = 150
    
            { ShardArray $array $shard $totalShards } | Should -Throw
        }
    
        It "returns the full array when given <totalShards> shards" -ForEach @( 
            @{ totalShards = 1 }, 
            @{ totalShards = 0 }, 
            @{ totalShards = -1 }, 
            @{ totalShards = -2 }
        ) { 
            $array = 0..78
            $shard = 0
    
            $result = ShardArray $array $shard $totalShards
    
            $result | Should -Be $array
        }
    
        It "throws when the shard index is greater than the total shards" { 
            $array = 0..78
            $shard = 10
            $totalShards = 3
    
            { ShardArray $array $shard $totalShards } | Should -Throw
        }
    
        It "does not throw when totalShards equals the array length" { 
            $array = 0..78
            $shard = 0
            $totalShards = 79
    
            { ShardArray $array $shard $totalShards } | Should -Not -Throw
        }
    
    }

    Context "Shards arrays" -ForEach @(
        @{ array = 0..78; totalShards = 1 },
        @{ array = 0..78; totalShards = 2 },
        @{ array = 0..11; totalShards = 3 }, 
        @{ array = 0..10; totalShards = 4 }, 
        @{ array = 0..78; totalShards = 79 }
    ) {
        It "returns all of the values in order when sharding (Total Shards: <totalShards>) " { 
            $shards = New-Object object[] $totalShards
            for ($i = 0; $i -lt $totalShards; $i++) {
                # Assigning directly avoids flattening the array.
                $shards[$i] = ShardArray $array $i $totalShards
            }
    
            # Flatten the array for comparison
            $actual = $shards | ForEach-Object { $_ }
    
            $actual | Should -Be $array
        }

        It "returns arrays of expected valid size (Total Shards: <totalShards>)" {
            $maxLength = [math]::Ceiling($array.Length / $totalShards)
            for ($i = 0; $i -lt $totalShards; $i++) {
                $shard = ShardArray $array $i $totalShards
                $shard.Length | Should -BeLessOrEqual $maxLength
            }
        }
    }
}
