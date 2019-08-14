$nanoserverTags = @("1803", "1809", "1903")
$servercoreTags = @("1803", "1809")

foreach ($tag in $nanoserverTags) {
 docker build `
  -t "teamcity-agent:latest-windowsservercore-$tag" `
  -f "windowsservercore/$tag/Dockerfile" .
}
foreach ($tag in $nanoserverTags) {
 docker build `
  -t "teamcity-agent:latest-nanoserver-$tag" `
  -f "nanoserver/$tag/Dockerfile" .
}
