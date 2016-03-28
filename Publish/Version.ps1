function Get-Version {
    $major=0
    $minor=0
    $patch=1

    $date=(Get-Date).ToUniversalTime()
    <#Semantic version doesn't work yet when Install-Package
    $prerelease="alpha"
    $build=[string](1200 * ($date.Year -2015)+$date.Month*100+$date.Day)+"-"+$date.ToString("HHmmss")
    $semVersion="$major.$minor.$patch-$prerelease-$build"
    #>

    $build=[string](1200 * ($date.Year -2015)+$date.Month*100+$date.Day)+$date.ToString("HHmmss")
    "$major.$minor.$build.$patch"    
}