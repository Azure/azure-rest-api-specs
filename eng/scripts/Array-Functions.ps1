function ShardArray($array, $shard, $totalShards) {
    if ($totalShards -lt 2) { 
      return $array
    }

    if ($shard -ge $totalShards) {
      throw "Shard index ($shard) must be less than total shards ($totalShards)"
    }

    if ($totalShards -gt $array.Length) {
      throw "Cannot shard array into more pieces than there are elements"
    }
  
    $shardSize = [math]::Ceiling($array.Length / $totalShards)
    $start = $shard * $shardSize
    $end = [math]::Min($start + $shardSize, $array.Length)
    return $array[$start..($end - 1)]
  }
