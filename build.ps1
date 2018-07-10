# Build semi annual images
$tags = @("1803")
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

# Build images with long term support
docker build --isolation=hyperv `
 -t teamcity-agent:latest-windowsservercore `
 -t teamcity-agent:latest-windowsservercore-ltsc2016 `
 -f windowsservercore-ltsc2016/Dockerfile .

docker build --isolation=hyperv `
 -t teamcity-agent:latest-nanoserver `
 -t teamcity-agent:latest-nanoserver-sac2016 `
 -f nanoserver-sac2016/Dockerfile .