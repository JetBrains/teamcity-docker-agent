FROM teamcity-minimal-agent:latest-windowsservercore-ltsc2016 AS tools

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Git
RUN Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.15.1.windows.2/MinGit-2.15.1.2-64-bit.zip -OutFile git.zip; \
    Expand-Archive git.zip -DestinationPath $Env:ProgramFiles\Git ; \
    Remove-Item -Force git.zip

# Install Mercurial
RUN Invoke-WebRequest https://bitbucket.org/tortoisehg/files/downloads/mercurial-4.4.2-x64.msi -OutFile hg.msi; \
    Start-Process msiexec -Wait -ArgumentList /q, /i, hg.msi ; \
    Remove-Item -Force hg.msi

# Install Open JDK
RUN Invoke-WebRequest https://github.com/ojdkbuild/ojdkbuild/releases/download/1.8.0.151-1/java-1.8.0-openjdk-1.8.0.151-1.b12.ojdkbuild.windows.x86_64.zip -OutFile openjdk.zip; \
    Expand-Archive openjdk.zip -DestinationPath $Env:ProgramFiles\Java; \
    Get-ChildItem -Path $Env:ProgramFiles\Java -Filter "java-*-openjdk*" | ForEach-Object {$_ | Rename-Item -NewName "OpenJDK" }; \
	Remove-Item -Force $Env:ProgramFiles\Java\OpenJDK\src.zip; \
    Remove-Item -Force openjdk.zip

# Install .NET Core SDK
RUN Invoke-WebRequest https://dotnetcli.blob.core.windows.net/dotnet/Sdk/2.1.4/dotnet-sdk-2.1.4-win-x64.zip -OutFile dotnet.zip; \
    Expand-Archive dotnet.zip -DestinationPath $Env:ProgramFiles\dotnet; \
    Remove-Item -Force dotnet.zip

FROM microsoft/dotnet-framework-build:4.7.1-windowsservercore-ltsc2016

ENV CONFIG_FILE="C:/BuildAgent/conf/buildAgent.properties" \
    JRE_HOME="C:\Program Files\Java\Oracle\jre" \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

EXPOSE 9090

VOLUME C:/BuildAgent/conf

COPY --from=tools /BuildAgent /BuildAgent
COPY --from=tools ["C:/Program Files/Git", "C:/Program Files/Git"]
COPY --from=tools ["C:/Program Files/Mercurial", "C:/Program Files/Mercurial"]
COPY --from=tools ["C:/Program Files/Java/Oracle", "C:/Program Files/Java/Oracle"]
COPY --from=tools ["C:/Program Files/Java/OpenJDK", "C:/Program Files/Java/OpenJDK"]
COPY --from=tools ["C:/Program Files/dotnet", "C:/Program Files/dotnet"]

# Trigger the population of the local package cache
RUN New-Item -Type Directory warmup; \
    cd warmup; \
    dotnet new; \
    cd ..; \
    Remove-Item -Force -Recurse warmup

RUN setx /M PATH ('{0};{1}\bin;C:\Program Files\Git\cmd;C:\Program Files\Mercurial;C:\Program Files\dotnet' -f $env:PATH, $env:JRE_HOME)

CMD ./BuildAgent/run-agent.ps1