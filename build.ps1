$tags = @("1803", "1809")

foreach ($tag in $tags) {
 docker build `
  -t "teamcity-agent:latest-windowsservercore-$tag" `
  -f "windowsservercore/$tag/Dockerfile" .

 docker build `
  -t "teamcity-agent:latest-nanoserver-$tag" `
  -f "nanoserver/$tag/Dockerfile" .
}