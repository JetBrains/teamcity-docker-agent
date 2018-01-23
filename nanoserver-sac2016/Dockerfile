FROM teamcity-agent:latest-windowsservercore-ltsc2016 as tools

FROM teamcity-minimal-agent:latest-nanoserver-sac2016

ENV NUGET_XMLDOC_MODE=skip \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

COPY --from=tools ["C:/Program Files/Git", "C:/Program Files/Git"]
COPY --from=tools ["C:/Program Files/Mercurial", "C:/Program Files/Mercurial"]
COPY --from=tools ["C:/Program Files/Java/OpenJDK", "C:/Program Files/Java/OpenJDK"]
COPY --from=tools ["C:/Program Files/dotnet", "C:/Program Files/dotnet"]

RUN setx /M PATH "%PATH%;C:\Program Files\Git\cmd;C:\Program Files\Mercurial;C:\Program Files\dotnet"

# Trigger the population of the local package cache
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    New-Item -Type Directory warmup; \
    cd warmup; \
    dotnet new; \
    cd ..; \
    Remove-Item -Force -Recurse warmup