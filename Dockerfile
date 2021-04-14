FROM mcr.microsoft.com/mssql/server:2019-latest
LABEL author="felipe mattos"
LABEL version="0.1"

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list)" \
    && apt-get update \
    && apt-get install -y mssql-server-is \
    && echo "[TELEMETRY]\nenabled = N" > /var/opt/ssis/ssis.conf \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y software-properties-common curl \
    && apt-get -y clean \
    && SSIS_PID=Enterprise ACCEPT_EULA=Y /opt/ssis/bin/ssis-conf -n setup 

USER ssis
ENV PATH=/opt/ssis/bin:${PATH} 
RUN mkdir -p /var/opt/ssis/.ssis/.system/system \
    && /opt/ssis/bin/dtexec 2>/dev/null || true

ENTRYPOINT ["/bin/bash"]
