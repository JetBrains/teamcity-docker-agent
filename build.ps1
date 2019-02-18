# Build semi annual images
$tags = @("1803", "1809")
foreach ($tag in $tags) {
 docker build `
  --build-arg TAG=$tag `
  -t "teamcity-agent:latest-windowsservercore-$tag" `
  -f windowsservercore/Dockerfile .

 docker build `
  --build-arg TAG=$tag `
  -t "teamcity-agent:latest-nanoserver-$tag" `
  -f nanoserver/Dockerfile .
}