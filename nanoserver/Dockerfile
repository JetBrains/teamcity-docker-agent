FROM teamcity-agent:latest-windowsservercore as tools

FROM teamcity-minimal-agent:latest-nanoserver

ENV GIT_HOME="C:\Program Files\Git" \
    HG_HOME="C:\Program Files\Mercurial" \
    DOTNET_HOME="C:\Program Files\dotnet" \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

COPY --from=tools $GIT_HOME $GIT_HOME
COPY --from=tools $HG_HOME $HG_HOME
COPY --from=tools $DOTNET_HOME $DOTNET_HOME

RUN setx /M PATH "%PATH%;%GIT_HOME%\cmd;%HG_HOME%;%DOTNET_HOME%"

# Trigger the population of the local package cache
RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    New-Item -Type Directory warmup; \
    cd warmup; \
    dotnet new; \
    cd ..; \
    Remove-Item -Force -Recurse warmup