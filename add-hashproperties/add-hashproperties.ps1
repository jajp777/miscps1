
function add-hashproperties {
  process {
    if ($_ -is [Hashtable]) {
      $hash = $_
      $out = new-object object
      foreach ($k in $hash.Keys) {
        $out = add-member -i $out -type "noteproperty" -name "$k" -force -passthru $hash[$k]
      }
      $out
    }
    else {
      $_
    }
  }
}



$rnd = new-object Random
$list = @()
1..5 | % {
  $o = @{}
  "keyone","keytwo" | % {
    $o["$_"] = "x$($rnd.next(100))"
  }
  $list += $o
}

"manual way"
$list | select-object @{Name="keyone";Expression={$_.keyone}},@{Name="keytwo";Expression={$_.keytwo}}

"automatic way"
$list | add-hashproperties
