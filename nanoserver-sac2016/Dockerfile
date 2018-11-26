FROM teamcity-base:latest-nanoserver-sac2016 AS dotnet
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Retrieve .NET Core SDK
ENV DOTNET_SDK_VERSION 2.1.500

RUN Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$Env:DOTNET_SDK_VERSION/dotnet-sdk-$Env:DOTNET_SDK_VERSION-win-x64.zip; \
    Expand-Archive dotnet.zip -DestinationPath $Env:ProgramFiles\dotnet; \
    Remove-Item -Force dotnet.zip; \
    Get-ChildItem -Path $Env:ProgramFiles\dotnet -Include *.lzma -File -Recurse | foreach { $_.Delete()}

FROM teamcity-agent:latest-windowsservercore-ltsc2016 AS tools
FROM teamcity-base:latest-nanoserver-sac2016

COPY --from=tools ["C:/Program Files/Git", "C:/Program Files/Git"]
COPY --from=tools ["C:/Program Files/Java/OpenJDK", "C:/Program Files/Java/OpenJDK"]
COPY --from=dotnet ["C:/Program Files/dotnet", "C:/Program Files/dotnet"]
COPY --from=tools /BuildAgent /BuildAgent

EXPOSE 9090

VOLUME C:/BuildAgent/conf

CMD powershell ./BuildAgent/run-agent.ps1

    # Configuration file for TeamCity agent
ENV CONFIG_FILE="C:/BuildAgent/conf/buildAgent.properties" \
    # Opt out of the telemetry feature
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    # Disable first time experience
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    # Configure Kestrel web server to bind to port 80 when present
    ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps perfomance
    NUGET_XMLDOC_MODE=skip

RUN setx /M PATH "%PATH%;C:\Program Files\Git\cmd;C:\Program Files\dotnet"

# Trigger first run experience by running arbitrary cmd to populate local package cache
RUN dotnet help